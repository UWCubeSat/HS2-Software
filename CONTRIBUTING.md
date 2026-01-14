# Contributing to HS2-Software

Thank you for your interest in contributing to the HS2 CubeSat Software project!

## Development Setup

### 1. Fork and Clone

```bash
git clone https://github.com/YOUR_USERNAME/HS2-Software.git
cd HS2-Software
git remote add upstream https://github.com/UWCubeSat/HS2-Software.git
```

### 2. Install Dependencies

```bash
# Create and activate virtual environment
python3 -m venv fprime-venv
source fprime-venv/bin/activate

# Install F Prime tools
pip install fprime-tools fprime-gds

# Install development tools
pip install pre-commit cpplint
```

### 3. Initialize Submodules

```bash
git submodule update --init --recursive
```

### 4. Install Pre-commit Hooks

```bash
pre-commit install
```

This will automatically run linters before each commit.

## Code Quality Standards

### Linters and Formatters

This project uses multiple linters to enforce F Prime design standards:

#### 1. Clang-Format (Code Formatting)

**Configuration**: `.clang-format`
- Based on Chromium style
- 120 character line limit
- 4-space indentation

**Usage**:
```bash
# Format all changed files
fprime-util format

# Format specific file
clang-format -i <file.cpp>
```

#### 2. Clang-Tidy (Static Analysis)

**Configuration**: `.clang-tidy`
- Checks for design issues
- Enforces modern C++ practices
- Detects potential bugs

**Usage**:
```bash
# Run on a file
clang-tidy <file.cpp> -- -I<include-paths>

# Run on all files during build
fprime-util build --ut
```

**Key Checks**:
- `bugprone-unhandled-self-assignment`: Ensures self-assignment is handled
- `modernize-use-nullptr`: Enforces `nullptr` over `NULL`
- `readability-braces-around-statements`: Requires braces on control flow

#### 3. Cpplint (Style Guide)

**Configuration**: `CPPLINT.cfg`
- Enforces Google C++ Style Guide subset
- 120 character line limit
- Specific filters for F Prime patterns

**Usage**:
```bash
# Check entire project
cpplint --recursive .

# Check specific file
cpplint <file.cpp>
```

### Design Standards

#### Port-Based Communication
- ✅ Use ports for all inter-component communication
- ❌ Never call methods directly on other components
- ✅ Define typed ports in FPP for type safety

#### Manager-Worker Pattern
- ✅ Separate orchestration (managers) from execution (workers)
- ✅ Use command-response pattern
- ✅ Keep components focused on single responsibility

#### Avoiding Port Circumvention
- ❌ No direct method calls between components
- ❌ No shared global state
- ✅ All communication through ports

#### Code Style
- Use 4-space indentation
- 120 character line limit
- Use `nullptr` instead of `NULL`
- Include braces around all control statements
- Use modern C++ features (C++11+)

## Workflow

### 1. Create a Branch

```bash
git checkout -b feature/your-feature-name
```

### 2. Make Changes

- Follow the F Prime design patterns
- Write unit tests for new components
- Update documentation as needed

### 3. Run Linters

```bash
# Format code
fprime-util format

# Run cpplint
cpplint --recursive HS2/

# Build with static analysis
fprime-util build
```

### 4. Run Tests

```bash
# Run unit tests
fprime-util check

# Run specific component tests
cd HS2/Components/YourComponent
fprime-util check
```

### 5. Commit Changes

```bash
git add .
git commit -m "feat: Add new component for X"
```

Pre-commit hooks will automatically run linters.

### 6. Push and Create PR

```bash
git push origin feature/your-feature-name
```

Create a pull request on GitHub targeting the `develop` branch.

## Pull Request Guidelines

### PR Title Format

Use conventional commit format:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting)
- `refactor:` Code refactoring
- `test:` Test additions or changes
- `chore:` Build or tooling changes

### PR Description

Include:
1. **Purpose**: What does this PR do?
2. **Changes**: What files/components were modified?
3. **Testing**: How was this tested?
4. **Design Review**: How does this follow F Prime patterns?

### PR Checklist

- [ ] Code follows F Prime design patterns
- [ ] All linters pass (clang-format, clang-tidy, cpplint)
- [ ] Unit tests added/updated
- [ ] Documentation updated
- [ ] No port circumvention
- [ ] Manager-worker pattern used appropriately
- [ ] PR description is clear and complete

## CI/CD

GitHub Actions will automatically:
- Run cpplint on all C++ files
- Check for style violations
- Report issues in the PR

Fix any issues reported by CI before merging.

## Getting Help

- Review [F Prime Documentation](https://fprime.jpl.nasa.gov/)
- Check existing components for examples
- Ask questions in GitHub Discussions
- Open issues for bugs or unclear documentation

## Code Review Process

1. Automated checks must pass
2. At least one team member must review
3. Address all review comments
4. Maintainer will merge when ready

## License

By contributing, you agree that your contributions will be licensed under the same terms as the project.

## Questions?

Open an issue or contact the maintainers!
