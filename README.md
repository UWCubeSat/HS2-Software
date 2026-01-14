# HS2-Software

High-Speed CubeSat Software built with NASA's F Prime (F´) framework.

## Overview

This repository contains the flight software for the HS2 CubeSat project, developed using the F Prime framework. F Prime is a component-driven framework designed for rapid development and deployment of spaceflight and embedded software applications.

## Project Structure

```
HS2-Software/
├── .github/
│   └── workflows/          # CI/CD workflows including cpplint
├── HS2/
│   ├── Components/         # Custom F Prime components
│   └── HS2Deployment/      # Main deployment configuration
│       ├── Main.cpp        # Entry point
│       └── Top/            # Topology definitions
├── lib/
│   └── fprime/            # F Prime framework (submodule)
├── .clang-format          # Code formatting rules
├── .clang-tidy            # Static analysis configuration
├── CPPLINT.cfg            # C++ style checking configuration
├── .pre-commit-config.yaml # Pre-commit hooks
├── CMakeLists.txt         # Top-level CMake configuration
└── settings.ini           # F Prime project settings
```

## Prerequisites

1. **Operating System**: Linux, macOS, or Windows with WSL
2. **Build Tools**:
   - CMake 3.16+
   - GCC/Clang compiler with C++11 support
   - Python 3.9+
3. **F Prime Tools**:
   ```bash
   pip install fprime-tools fprime-gds
   ```

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/UWCubeSat/HS2-Software.git
cd HS2-Software
```

### 2. Initialize F Prime Submodule

```bash
git submodule add https://github.com/nasa/fprime.git lib/fprime
git submodule update --init --recursive
```

### 3. Set Up Python Virtual Environment (Recommended)

```bash
python3 -m venv fprime-venv
source fprime-venv/bin/activate  # On Windows: fprime-venv\Scripts\activate
pip install -r lib/fprime/requirements.txt
pip install fprime-tools fprime-gds
```

### 4. Generate Build Files

```bash
fprime-util generate
```

### 5. Build the Project

```bash
fprime-util build
```

## Code Quality and Linting

This project uses multiple linters to enforce F Prime design standards:

### Clang-Format
Automatically formats C++ code according to F Prime style guidelines:
```bash
fprime-util format
```

### Clang-Tidy
Static analysis tool for C++ code quality and design patterns:
```bash
clang-tidy <file.cpp> -- -I<include-paths>
```

### Cpplint
Google C++ Style Guide checker:
```bash
cpplint --recursive .
```

### Pre-commit Hooks
Install pre-commit hooks to automatically check code before commits:
```bash
pip install pre-commit
pre-commit install
```

## Continuous Integration

The project uses GitHub Actions for automated code quality checks:
- **Cpplint Scan**: Runs on every push and pull request to ensure code style compliance

## Development Guidelines

### F Prime Design Patterns

1. **Component Design**:
   - Follow the Active Component or Queued Component pattern
   - Use ports for all inter-component communication
   - Avoid direct function calls between components

2. **Port Usage**:
   - Use typed ports for data exchange
   - Follow input/output port conventions
   - Do not circumvent the port system

3. **Manager-Worker Pattern**:
   - Implement manager components for orchestration
   - Use worker components for specific tasks
   - Follow the command-response pattern

4. **Coding Standards**:
   - 120 character line limit
   - 4-space indentation
   - Use `nullptr` instead of `NULL`
   - Include braces around all control statements

### Adding New Components

```bash
cd HS2/Components
fprime-util new --component <ComponentName>
```

## Testing

Run unit tests:
```bash
fprime-util check
```

Run integration tests:
```bash
fprime-util check --integration
```

## Documentation

- [F Prime Documentation](https://fprime.jpl.nasa.gov/)
- [F Prime User Guide](https://fprime.jpl.nasa.gov/latest/docs/user-manual/)
- [F Prime Tutorials](https://fprime.jpl.nasa.gov/latest/docs/tutorials/)

## Contributing

1. Create a feature branch from `develop`
2. Make your changes following the coding standards
3. Run linters and tests
4. Submit a pull request

## License

This project follows the licensing of the F Prime framework. See [LICENSE](LICENSE) for details.

## Contact

For questions or issues, please open an issue on GitHub or contact the UW CubeSat team.