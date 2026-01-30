---
name: swift-performance
description: Write and review Swift code with a focus on measurable performance, memory behavior, and concurrency correctness.
compatibility: opencode
---

## What I do
- Produce Swift that is efficient, readable, and benchmark-friendly.
- Review Swift code for algorithmic complexity, allocations, ARC churn, and concurrency hazards.
- Prefer changes that are justified by likely hotspots or profiling evidence.

## Default assumptions
- Prefer clarity first, then optimize obvious hot paths.
- Avoid micro-optimizations unless the code is in a loop, parsing, rendering, networking pipelines, or called frequently.
- If performance tradeoffs are ambiguous, propose 2 options and explain costs.

## Writing rules (performance-oriented Swift)
- Choose the right data structure: Array vs ContiguousArray, Dictionary/Set, avoid repeated linear scans in hot loops.
- Minimize allocations and copying:
  - Preallocate with reserveCapacity(_:) when sizes are known or can be estimated.
  - Avoid intermediate arrays from map/filter in hot paths; consider for loops or lazy when appropriate.
  - Be careful with String/Substring lifetimes; avoid accidental retention of large buffers.
- Control dynamic dispatch and ARC:
  - Prefer struct for value semantics when it reduces heap allocations.
  - Avoid capturing self strongly in long-lived closures; use [weak self] when needed (but don't cargo-cult it).
- Concurrency:
  - Use structured concurrency (async/await, task groups) and avoid data races.
  - Avoid blocking threads; do not call sync I/O on main actor; keep actor hops minimal in tight loops.
- Use @inlinable/@usableFromInline only for library boundaries and only when it helps; do not spam attributes.
- Prefer measuring:
  - Suggest Instruments (Time Profiler, Allocations), os_signpost, and XCTest performance tests where relevant.

## Code review checklist
- Big-O: any accidental O(n^2) behavior from nested loops / repeated firstIndex(of:) / repeated sorting?
- Allocations: repeated temporary collections, repeated string interpolation, bridging to Foundation in loops?
- Copying: repeated concatenation, Data/Array growth without reserve, needless conversions.
- Concurrency: actor isolation correctness, main-thread work, cancellation handling, task lifetime leaks.
- I/O: batching, streaming, backpressure, avoiding excessive buffering.

## Output format when reviewing code
- Start with 3-6 high-impact findings.
- Include specific changes (snippets) and explain the performance mechanism (allocations avoided, reduced copies, fewer actor hops, etc.).
- Call out anything that needs profiling to confirm.
