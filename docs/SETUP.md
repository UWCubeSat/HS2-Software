# Quick Setup Guide

This guide will help you get started with the HS2-Software project.

## Prerequisites

- Python 3.9 or later
- C++ compiler (GCC or Clang)
- CMake 3.16 or later
- Git

## Step-by-Step Setup

### 1. Clone the Repository

```bash
git clone https://github.com/UWCubeSat/HS2-Software.git
cd HS2-Software
```

### 2. Set Up F Prime Submodule

**Note**: This step is only needed when setting up the repository for the first time or if the submodule doesn't exist yet.

```bash
# Add the F Prime framework as a submodule (only if not already added)
git submodule add https://github.com/nasa/fprime.git lib/fprime 2>/dev/null || true

# Initialize and update submodules (always safe to run)
git submodule update --init --recursive
```

### 3. Create Python Virtual Environment

```bash
# Create virtual environment
python3 -m venv fprime-venv

# Activate it
source fprime-venv/bin/activate  # On Linux/Mac
# OR
fprime-venv\Scripts\activate  # On Windows
```

### 4. Install F Prime Tools

```bash
# Install F Prime dependencies
pip install -r lib/fprime/requirements.txt

# Install F Prime tools
pip install fprime-tools fprime-gds

# Install development tools
pip install pre-commit cpplint
```

### 5. Set Up Pre-commit Hooks

```bash
pre-commit install
```

### 6. Generate Build Files

```bash
fprime-util generate
```

### 7. Build the Project

```bash
fprime-util build
```

## Verify Setup

Run the linters to verify everything is configured correctly:

```bash
# Format code (should not change anything if already formatted)
fprime-util format

# Run cpplint (should pass with no errors on initial setup)
cpplint --recursive HS2/
```

## Next Steps

- Read the [README.md](../README.md) for project overview
- Review [CONTRIBUTING.md](../CONTRIBUTING.md) for development guidelines
- Check [docs/LINTER_RULES.md](LINTER_RULES.md) for linter configuration details
- Explore [HS2/Components/README.md](../HS2/Components/README.md) for component development patterns

## Common Issues

### Issue: `fprime-util: command not found`

**Solution**: Make sure your virtual environment is activated and F Prime tools are installed:
```bash
source fprime-venv/bin/activate
pip install fprime-tools
```

### Issue: CMake errors about F Prime not found

**Solution**: Ensure the F Prime submodule is initialized:
```bash
git submodule update --init --recursive
```

### Issue: Pre-commit hooks failing

**Solution**: Install pre-commit and the hooks:
```bash
pip install pre-commit
pre-commit install
```

## Getting Help

- Check the [F Prime documentation](https://fprime.jpl.nasa.gov/)
- Open an issue on GitHub
- Contact the UW CubeSat team

## Useful Commands

```bash
# Generate build configuration
fprime-util generate

# Build the project
fprime-util build

# Run unit tests
fprime-util check

# Format code
fprime-util format

# Run the deployment
fprime-util run

# Create a new component
cd HS2/Components
fprime-util new --component MyComponent

# Clean build artifacts
fprime-util build --clean
```
