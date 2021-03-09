message("Engaging tests")
# automatically enable catch2 to generate ctest targets
if(CONAN_CATCH2_ROOT_DEBUG)
  include(${CONAN_CATCH2_ROOT_DEBUG}/lib/cmake/Catch2/Catch.cmake)
else()
  include(${CONAN_CATCH2_ROOT}/lib/cmake/Catch2/Catch.cmake)
endif()

#configure_file(../src/version.hpp.in ../src/version.hpp)

add_library(catch_main STATIC catch_main.cpp)
target_link_libraries(catch_main PUBLIC CONAN_PKG::catch2)
target_link_libraries(catch_main PRIVATE project_options)

set(TESTS_EXECUTABLE tests)
add_executable(${TESTS_EXECUTABLE} 
                test_catch.cpp 
                test_1.cpp
                )
if(ENABLE_COVERAGE)
  add_coverage(${TESTS_EXECUTABLE})
endif()
              
target_link_libraries(${TESTS_EXECUTABLE} PRIVATE project_warnings project_options catch_main CONAN_PKG::fmt)

# automatically discover tests that are defined in catch based test files you can modify the unittests. 
# TEST_PREFIX to whatever you want, or use different for different binaries
set(TEST_PREFIX "")
catch_discover_tests(
  ${TESTS_EXECUTABLE}
  TEST_PREFIX
  "unittests."
  EXTRA_ARGS
  -s
  --reporter=xml
  --out=tests.xml)

# The catch_discover_tests macro above replaces these types of 
# lines found in many examples.
#add_test(test1 ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/tests)

# if(ENABLE_GCOV)
#   message("Enabling gcov code coverage tool for testing")
#   message("${PROJECT_BINARY_DIR}")
#   # found example: https://jhbell.com/using-cmake-and-gcov
#   set(CMAKE_CXX_FLAGS "-fprofile-arcs -ftest-coverage")

#   # this sets up the gcov
#   add_custom_target(gcov
#     COMMAND mkdir -p coverage
#     COMMAND ${CMAKE_MAKE_PROGRAM} test
#     WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
#   )
#   add_custom_command(TARGET gcov
#     COMMAND echo "=================== GCOV ===================="
#     COMMAND gcov -b ${PROJECT_SOURCE_DIR}/*.cpp -o ./${TESTS_EXECUTABLE}/CMakeFiles/${TESTS_EXECUTABLE}.dir
#     COMMAND cat CoverageSummary.tmp
#     COMMAND echo "-- Coverage files have been output to ${CMAKE_BINARY_DIR}/coverage"
#     WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/coverage
#   )
#   # make gcov depend on tests having been run first
#   add_dependencies(gcov tests)
#   set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_MAKE_CLEAN_FILES coverage)

#   add_custom_target(scrub
#     COMMAND ${CMAKE_MAKE_PROGRAM} clean
#     COMMAND rm -f ${OBJECT_DIR}/*.gcno
#     COMMAND rm -f ${OBJECT_DIR}/*.gcda
#     WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
#   )
# endif()

