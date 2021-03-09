message("Building executable")

configure_file(version.hpp.in version.hpp)
add_executable(
  ${PROJECT_NAME}
  main.cpp
  )
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_BINARY_DIR}/src)
target_link_libraries(
  ${PROJECT_NAME}
  PRIVATE project_options
          project_warnings
          CONAN_PKG::fmt
          )
