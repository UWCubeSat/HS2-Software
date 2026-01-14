# F Prime Design Patterns and Linter Rules

This document explains the F Prime design patterns enforced by the linters in this project.

## Overview

The HS2-Software project uses three complementary linters to enforce F Prime design style:

1. **Clang-Format** - Code formatting
2. **Clang-Tidy** - Static analysis and design pattern enforcement
3. **Cpplint** - Style guide compliance

## Design Patterns Enforced

### 1. Port-Based Communication

**Rule**: All inter-component communication must use ports.

**Why**: Ports provide:
- Type safety
- Clear interfaces
- Testability
- Decoupling

**Example**:
```cpp
// ❌ BAD - Direct method call
otherComponent->processData(value);

// ✅ GOOD - Use port
this->dataOut_out(0, value);
```

**Linter Detection**:
- Manual code review required (automated detection is limited)
- Look for method calls to other component instances

### 2. Manager-Worker Pattern

**Rule**: Separate orchestration logic (managers) from work execution (workers).

**Why**: 
- Single Responsibility Principle
- Better testability
- Clearer system architecture

**Manager Component Example**:
```fpp
active component DataManager {
    # Orchestrates data processing
    command port cmdIn
    output port workerCmd: WorkerCommand
    async input port workerStatus: WorkerStatus
}
```

**Worker Component Example**:
```fpp
queued component DataWorker {
    # Does the actual data processing
    async input port workCmd: WorkerCommand
    output port statusOut: WorkerStatus
}
```

### 3. Avoiding Port Circumvention

**Rule**: Never bypass the port system through:
- Direct method calls
- Shared global variables
- Direct access to component internals

**Examples**:
```cpp
// ❌ BAD - Global state
extern GlobalConfig g_config;
void handler() {
    g_config.value = 42;  // Port circumvention!
}

// ❌ BAD - Direct access
void handler() {
    Component* comp = getComponentPtr();
    comp->directMethod();  // Port circumvention!
}

// ✅ GOOD - Port-based
void handler() {
    this->configOut_out(0, 42);  // Proper port usage
}
```

## Clang-Tidy Rules Explained

### `bugprone-unhandled-self-assignment`

**What**: Detects self-assignment issues in assignment operators.

**Why**: Self-assignment can cause bugs if not handled properly.

**Example**:
```cpp
// ❌ BAD
MyClass& operator=(const MyClass& other) {
    delete[] data;
    data = new int[other.size];
    std::copy(other.data, other.data + other.size, data);
    return *this;  // Bug if this == &other
}

// ✅ GOOD
MyClass& operator=(const MyClass& other) {
    if (this != &other) {  // Check for self-assignment
        delete[] data;
        data = new int[other.size];
        std::copy(other.data, other.data + other.size, data);
    }
    return *this;
}
```

### `modernize-use-nullptr`

**What**: Enforces use of `nullptr` instead of `NULL` or `0`.

**Why**: Type safety in C++11+.

**Example**:
```cpp
// ❌ BAD
void* ptr = NULL;
int* iptr = 0;

// ✅ GOOD
void* ptr = nullptr;
int* iptr = nullptr;
```

### `modernize-deprecated-headers`

**What**: Prefers C++ headers over C headers.

**Example**:
```cpp
// ❌ BAD
#include <string.h>
#include <stdio.h>

// ✅ GOOD
#include <cstring>
#include <cstdio>
```

### `readability-braces-around-statements`

**What**: Requires braces on all control flow statements.

**Why**: Prevents bugs from missing braces.

**Example**:
```cpp
// ❌ BAD
if (condition)
    doSomething();

// ✅ GOOD
if (condition) {
    doSomething();
}
```

## Cpplint Rules Explained

### Line Length (120 characters)

**What**: Maximum line length is 120 characters.

**Why**: Readability on modern displays while maintaining reasonable limits.

**Fix**:
```cpp
// ❌ BAD - Too long
void myFunction(int param1, int param2, int param3, int param4, int param5, int param6, int param7, int param8, int param9) {

// ✅ GOOD - Wrapped
void myFunction(
    int param1, int param2, int param3,
    int param4, int param5, int param6,
    int param7, int param8, int param9) {
```

### Header Guards

**What**: Use `#ifndef` guards, not `#pragma once`.

**Why**: More portable, F Prime standard.

**Example**:
```cpp
// ❌ BAD
#pragma once

// ✅ GOOD
#ifndef HS2_MYCOMPONENT_HPP
#define HS2_MYCOMPONENT_HPP
// ...
#endif
```

## Clang-Format Rules Explained

### Indentation (4 spaces)

**What**: Use 4 spaces for indentation.

**Why**: F Prime standard based on Chromium style.

### Column Limit (120)

**What**: Maximum 120 characters per line.

**Why**: Balances readability with modern displays.

### Access Modifier Offset

**What**: Access modifiers (`public:`, `private:`) indented 2 spaces less than members.

**Example**:
```cpp
class MyComponent {
  public:  // 2 spaces less
    void method();  // 4 spaces
    
  private:  // 2 spaces less
    int member;  // 4 spaces
};
```

## Running Linters

### Format Code
```bash
# Format all changed files
fprime-util format

# Format specific file
clang-format -i <file.cpp>
```

### Run Static Analysis
```bash
# Run clang-tidy
clang-tidy <file.cpp> -- -I<include-paths>

# Run with build
fprime-util build
```

### Check Style
```bash
# Check all files
cpplint --recursive .

# Check specific file
cpplint <file.cpp>
```

### Pre-commit Hooks
```bash
# Install hooks
pip install pre-commit
pre-commit install

# Run manually
pre-commit run --all-files
```

## CI Integration

The cpplint GitHub Action runs automatically on:
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop`

It checks:
- All C++ files (`.cpp`, `.hpp`, `.c`, `.h`)
- Excludes build directories
- Reports style violations in PR

## References

- [F Prime Design Patterns](https://fprime.jpl.nasa.gov/latest/docs/design/)
- [Clang-Tidy Checks](https://clang.llvm.org/extra/clang-tidy/checks/list.html)
- [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)
- [Clang-Format Style Options](https://clang.llvm.org/docs/ClangFormatStyleOptions.html)
