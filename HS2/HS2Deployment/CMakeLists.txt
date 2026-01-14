####
# HS2/HS2Deployment/CMakeLists.txt
# Deployment configuration for HS2 software
####

set(SOURCE_FILES
  "${CMAKE_CURRENT_LIST_DIR}/Main.cpp"
)

set(MOD_DEPS
  # Add component dependencies here
)

register_fprime_deployment(HS2Deployment "${SOURCE_FILES}" "${MOD_DEPS}")

# Add topology
add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/Top/")
