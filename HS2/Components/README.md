# HS2 Components

This directory contains custom F Prime components for the HS2 CubeSat software.

## Component Development Guidelines

### Creating a New Component

Use the F Prime utility to scaffold a new component:

```bash
cd HS2/Components
fprime-util new --component <ComponentName>
```

This will create:
- `<ComponentName>/<ComponentName>.fpp` - Component model definition
- `<ComponentName>/<ComponentName>.hpp` - C++ header
- `<ComponentName>/<ComponentName>.cpp` - C++ implementation
- `<ComponentName>/CMakeLists.txt` - Build configuration

### Component Design Best Practices

#### 1. Port-Based Communication
- **Always** use ports for inter-component communication
- **Never** call methods directly on other components
- Define typed ports in FPP for type safety

Example:
```fpp
port DataPort(data: U32)

component MyComponent {
    output port dataOut: DataPort
    sync input port dataIn: DataPort
}
```

#### 2. Component Types

**Active Component** (with thread):
```fpp
active component ActiveComp {
    # Has its own thread, processes commands asynchronously
}
```

**Queued Component** (with queue, no thread):
```fpp
queued component QueuedComp {
    # Has a message queue, processed by external thread
}
```

**Passive Component** (no thread or queue):
```fpp
passive component PassiveComp {
    # Synchronous execution
}
```

#### 3. Manager-Worker Pattern

Implement clear separation between orchestration and work:

**Manager Component**:
- Coordinates multiple worker components
- Makes high-level decisions
- Handles command sequencing

**Worker Component**:
- Performs specific tasks
- Reports status to manager
- Focuses on single responsibility

#### 4. Avoid Port Circumvention

❌ **Don't**:
```cpp
// Direct method call - BAD
otherComponent->doSomething();

// Shared global state - BAD
extern GlobalData g_data;
g_data.value = 42;
```

✅ **Do**:
```cpp
// Use ports - GOOD
this->dataOut_out(0, dataValue);
```

#### 5. State Management

- Use member variables for component state
- Protect state with mutexes if accessed from multiple contexts
- Use events to report state changes

#### 6. Error Handling

- Return status codes from port handlers
- Use event ports to report errors
- Implement proper error recovery

### Component Structure

Each component should include:
- **FPP Model** (`.fpp`): Define interfaces, ports, commands, events, telemetry
- **Header File** (`.hpp`): C++ class declaration
- **Implementation** (`.cpp`): Business logic
- **Unit Tests**: Test component behavior
- **Documentation**: README explaining component purpose

### Testing Components

```bash
# Build component tests
fprime-util build --ut

# Run component tests
fprime-util check
```

### Example Component Directory

```
Components/
└── ExampleComponent/
    ├── CMakeLists.txt
    ├── ExampleComponent.fpp
    ├── ExampleComponent.hpp
    ├── ExampleComponent.cpp
    ├── test/
    │   └── ut/
    │       ├── TestMain.cpp
    │       └── Tester.cpp
    └── docs/
        └── README.md
```

## Available Components

(List will be populated as components are added)

## References

- [F Prime Component Development](https://fprime.jpl.nasa.gov/latest/docs/user-manual/dev/developing-components.html)
- [FPP Language Reference](https://fprime.jpl.nasa.gov/fpp/latest/fpp-language.html)
