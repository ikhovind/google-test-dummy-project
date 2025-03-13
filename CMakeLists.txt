cmake_minimum_required(VERSION 3.21)

include(cmake/prelude.cmake)

project(
    mocking
    VERSION 0.1.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES C
)

include(cmake/variables.cmake)

# ---- Declare library ----
add_library(
    c_lib SHARED
    source/lib.c
)

target_include_directories(
    c_lib ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source>"
)

# ---- Declare executable ----

add_executable(mocking_exe source/main.c)

set_property(TARGET mocking_exe PROPERTY OUTPUT_NAME mocking)

target_compile_features(mocking_exe PRIVATE c_std_99)

target_link_libraries(mocking_exe PRIVATE c_lib)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT mocking_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of mocking"
  )
endif()

include(cmake/dev-mode.cmake)
