#!/usr/bin/env node

import fs from "fs";
import path from "node:path";
import os from "os";
import { spawn } from "child_process";

const LOG_FILE = path.join(os.tmpdir(), "sourcekit-lsp.log");
const LOG_STREAM = fs.createWriteStream(LOG_FILE, { flags: "a" });
console.log(`Logging to: ${LOG_FILE}`);
const main = async () => {
  const currentDir = process.cwd();
  log(`Detecting Swift package, for file: ${currentDir}`);
  const packageBuilder = await SwiftPackageBuilder.from(currentDir);
  const sourceKit = new SourceKit(packageBuilder);

  process.on("SIGINT", () => {
    sourceKit.stop();
    process.exit(0);
  });

  await sourceKit.start();
};

class SourceKit {
  static SCRATCH_PATH = `.sourcekit-build`;
  static RESTART_TIMEOUT = 1000;

  #sourceKitProcess;
  #currentBuild;
  #shouldRebuild = false;

  #packageBuilder;

  constructor(packageBuilder) {
    this.#packageBuilder = packageBuilder;
  }

  async start() {
    if (this.#sourceKitProcess) return;

    if (!this.#packageBuilder) {
      log("Starting SourceKit LSP without package");
      this.#sourceKitProcess = this.#executeSourceKit();
      return;
    }

    const packageRoot = this.#packageBuilder.packageRoot;
    const scratchPath = path.join(packageRoot, SourceKit.SCRATCH_PATH);

    log(`Starting SourceKit LSP at: ${packageRoot}`);
    this.#sourceKitProcess = this.#executeSourceKitAt(scratchPath);

    const scratchPathExists = await canReadFile(scratchPath);
    if (!scratchPathExists) {
      log(`No previous build found, building at: ${scratchPath}`);
      await this.refresh();
    }
  }

  async stop() {
    if (!this.#sourceKitProcess) return;

    this.#sourceKitProcess.removeAllListeners("exit");
    this.#sourceKitProcess.kill();
  }

  async refresh() {
    if (!this.#packageBuilder || !this.#sourceKitProcess) return;

    const packageRoot = this.#packageBuilder.packageRoot;
    const scratchPath = path.join(packageRoot, SourceKit.SCRATCH_PATH);
    await this.#enqueueBuild(scratchPath);
  }

  #executeSourceKit() {
    return spawnOnStdio("sourcekit-lsp");
  }

  #executeSourceKitAt(scratchPath) {
    const args = ["--scratch-path", scratchPath];
    log(`Starting SourceKit LSP with args: ${args.join(" ")}`);
    const command = spawnOnStdio("sourcekit-lsp", args);
    command.on("exit", (code, signal) => this.#handleSourceKitExit(scratchPath, code, signal));
    return command;
  }

  async #handleSourceKitExit(scratchPath, code, signal) {
    log(`SourceKit LSP ended. Code: ${code}. Signal: ${signal}`);
    log(`Waiting ${SourceKit.RESTART_TIMEOUT}ms for restart`);
    await waitMs(SourceKit.RESTART_TIMEOUT);
    log(`Restarting SourceKit LSP`);
    this.#sourceKitProcess = this.#executeSourceKitAt(scratchPath);
  }

  async #enqueueBuild(scratchPath) {
    while (this.#currentBuild) {
      this.#shouldRebuild = true;
      await this.#currentBuild;
      return;
    }

    this.#currentBuild = this.#packageBuilder.build(scratchPath);
    while (this.#currentBuild) {
      try {
        await this.#currentBuild;
      } finally {
        log("Swift build finished, killing SourceKit LSP");
        this.#sourceKitProcess.kill();
        if (this.#shouldRebuild) {
          this.#shouldRebuild = false;
          this.#currentBuild = this.#packageBuilder.build(scratchPath);
        } else {
          this.#currentBuild = undefined;
        }
      }
    }
  }
}

class SwiftPackageBuilder {
  static async from(currentFile) {
    let packageRoot = currentFile;
    while (!pathIsRootDir(packageRoot)) {
      const packageFileDir = path.join(packageRoot, "Package.swift");
      const isPackageRoot = await canReadFile(packageFileDir);
      if (isPackageRoot) {
        return new SwiftPackageBuilder(packageRoot);
      }
      packageRoot = path.dirname(packageRoot);
    }
    return undefined;
  }

  constructor(packageRoot) {
    this.packageRoot = packageRoot;
  }

  async build(scratchPath) {
    const args = [
      "build",
      "--package-path",
      this.packageRoot,
      "--scratch-path",
      scratchPath,
    ];

    const command = spawn("swift", args);
    const onData = (prefix) => (data) => {
      const dataStr = data.toString();
      const dataLines = dataStr.split("\n")
      for (const dataLine of dataLines) {
        if (dataLine.trim() === "") continue;
        log(`${prefix}: "${dataLine}"`);
      }
    }
    command.stdout.on("data", onData("SwiftPM stdout"));
    command.stderr.on("data", onData("SwiftPM stderr"));

    return new Promise((resolve, reject) =>
      command.on("exit", (num) => {
        if (num === 0) {
          resolve();
        } else {
          reject(Error(`Build failed with exit code: ${num}`));
        }
      }),
    );
  }
}

const canReadFile = (file) =>
  new Promise((resolve) =>
    fs.access(file, fs.constants.R_OK, (err) => resolve(!err)),
  );

const pathIsRootDir = (dir) => path.dirname(dir) === dir;

const log = (message) =>
  LOG_STREAM.write(`${new Date().toISOString()} ${message}\n`);


const spawnOnStdio = (command, args) => {
  const child = spawn(command, args);
  child.stdout.pipe(process.stdout);
  child.stderr.pipe(process.stderr);
  child.stdin.pipe(process.stdin);
  return child;
};

const waitMs = async (ms) => await new Promise((res) => setTimeout(res, ms));

await main();
