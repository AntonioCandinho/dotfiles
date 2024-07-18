#!/bin/sh

echo "⚙️  Updating Lua Language Server..."
pushd lua-language-server >/dev/null

echo "⬇️  Downloading latests sources..."
git pull >/dev/null
echo "✅ Latest sources downloaded"

echo "🚧 Building sources..."
./make.sh >/dev/null

echo "✅ Lua Language Server updated"
popd >/dev/null

echo "⚙️  Updating JS based language servers..."
pushd npm-available-servers >/dev/null

yarn install >/dev/null

echo "✅ JS based language servers updated"
popd >/dev/null

echo "⚙️  Updating Rust Analyzer..."
pushd rust-analyzer >/dev/null

echo "⬇️  Downloading latests sources..."
git pull >/dev/null
echo "✅ Latest sources downloaded"

echo "🚧 Building sources..."
cargo build --release
