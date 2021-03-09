# # This adds functionality for the codecov service in GitHub
if (ENABLE_COVERAGE)
    message("enabled code coverage")
    # added as per instructions at https://github.com/RWTH-HPC/CMake-codecov
    set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/externals/CMake-codecov/cmake" ${CMAKE_MODULE_PATH})
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
    find_package(codecov)
    list(APPEND LCOV_REMOVE_PATTERNS "/usr/")
endif()