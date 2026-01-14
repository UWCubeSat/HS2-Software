# HS2 Deployment

This directory contains the main deployment for the HS2 CubeSat High-Speed Software system.

## Structure

- `Main.cpp` - Main entry point for the deployment
- `Top/` - Topology definition files
  - `topology.fpp` - F Prime topology definition (to be created)
  - `instances.fpp` - Component instances (to be created)

## Building

To build the HS2 deployment:

```bash
# Generate build files
fprime-util generate

# Build the deployment
fprime-util build
```

## Running

To run the HS2 deployment:

```bash
fprime-util run
```

## Testing

To run unit tests:

```bash
fprime-util check
```
