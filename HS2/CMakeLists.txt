####
# HS2/CMakeLists.txt
# Top-level CMake file for HS2 software components and deployments
####

# Include components
add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/Components/")

# Include deployment
add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/HS2Deployment/")
