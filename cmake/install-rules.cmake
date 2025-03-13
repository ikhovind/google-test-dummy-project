install(
    TARGETS mocking_exe
    RUNTIME COMPONENT mocking_Runtime
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
