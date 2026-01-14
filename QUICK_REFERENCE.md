# Quick Reference for HS2-Software Development

## Linter Commands

```bash
# Format code
fprime-util format                    # Format all changed files
clang-format -i file.cpp              # Format specific file

# Check style
cpplint --recursive .                 # Check entire project
cpplint file.cpp                      # Check specific file

# Static analysis
clang-tidy file.cpp -- -I<includes>   # Run on specific file

# Pre-commit hooks
pre-commit install                    # Install hooks
pre-commit run --all-files            # Run all hooks manually
```

## Build Commands

```bash
# Setup
fprime-util generate                  # Generate build files
fprime-util build                     # Build project
fprime-util build --clean             # Clean build

# Testing
fprime-util check                     # Run unit tests
fprime-util check --integration       # Run integration tests

# Running
fprime-util run                       # Run deployment
```

## Component Development

```bash
# Create new component
cd HS2/Components
fprime-util new --component MyComponent

# Build component
cd MyComponent
fprime-util build

# Test component
fprime-util check
```

## Git Workflow

```bash
# Start new feature
git checkout -b feature/my-feature

# Make changes and commit (pre-commit hooks run automatically)
git add .
git commit -m "feat: Add new feature"

# Push and create PR
git push origin feature/my-feature
```

## Design Pattern Checklist

When writing F Prime components:

- [ ] Use ports for all inter-component communication
- [ ] No direct method calls to other components
- [ ] No shared global variables
- [ ] Manager components orchestrate, workers execute
- [ ] Use `nullptr` instead of `NULL`
- [ ] Include braces on all control flow statements
- [ ] Line length ≤ 120 characters
- [ ] 4-space indentation
- [ ] Use `#ifndef` header guards (not `#pragma once`)

## Useful Resources

- [F Prime Docs](https://fprime.jpl.nasa.gov/)
- [Project Setup](docs/SETUP.md)
- [Linter Rules](docs/LINTER_RULES.md)
- [Contributing Guide](CONTRIBUTING.md)
- [Component Guide](HS2/Components/README.md)

## Common Issues

**Linter fails**: Run `fprime-util format` before commit

**Build fails**: Ensure F Prime submodule is initialized:
```bash
git submodule update --init --recursive
```

**Pre-commit hook fails**: Install pre-commit:
```bash
pip install pre-commit && pre-commit install
```
