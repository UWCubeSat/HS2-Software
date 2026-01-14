# ====================================================================
# HS2-Software: CubeSat High-Speed Software Project
# This sets up the build system for the HS2 project, including
# components and deployments. It imports the F Prime framework.
# ====================================================================

cmake_minimum_required(VERSION 3.16)
cmake_policy(SET CMP0048 NEW)
project(HS2 VERSION 1.0.0 LANGUAGES C CXX)

###
# F Prime Core Setup
# This includes all of the F Prime core components and imports the make-system.
###
include("${CMAKE_CURRENT_LIST_DIR}/lib/fprime/cmake/FPrime.cmake")
# NOTE: register custom targets between these two lines
fprime_setup_included_code()

# Include project-wide components and deployments
add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/HS2/")
