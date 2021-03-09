# This adds functionality for the codecov service in GitHub
if (ENABLE_CODECOV)
    message("enabled code coverage")
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
    find_package(codecov)
    add_coverage(tests)
    list(APPEND LCOV_REMOVE_PATTERNS "/usr/")
    coverage_evaluate()
endif()