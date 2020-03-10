# Find the Cython compiler.
#
# This code sets the following variables:
#
#  CYTHON_EXECUTABLE
#
# See also UseCython.cmake

#=============================================================================
# Copyright 2011 Kitware, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#=============================================================================

# Use the Cython executable that lives next to the Python executable
# if it is a local installation.
find_package( PythonInterp )
if( PYTHONINTERP_FOUND )
  get_filename_component( _python_path ${PYTHON_EXECUTABLE} PATH )
  find_program( CYTHON_EXECUTABLE
    NAMES cython cython.bat cython3
    HINTS ${_python_path}
    )
else()
  find_program( CYTHON_EXECUTABLE
    NAMES cython cython.bat cython3
    )
endif()

# Check version
if(NOT CYTHON_EXECUTABLE)
  set(CYTHON_EXECUTABLE ${PYTHON_EXECUTABLE} -m cython)
endif()
execute_process(COMMAND ${CYTHON_EXECUTABLE} -V
                ERROR_VARIABLE CYTHON_OUTPUT RESULT_VARIABLE CYTHON_STATUS OUTPUT_QUIET)
if(CYTHON_STATUS EQUAL 0)
  string(REGEX REPLACE "^Cython version ([0-9]+\\.[0-9\\.]+).*" "\\1" CYTHON_VERSION "${CYTHON_OUTPUT}")
endif()

include( FindPackageHandleStandardArgs )
FIND_PACKAGE_HANDLE_STANDARD_ARGS( Cython REQUIRED_VARS CYTHON_EXECUTABLE
                                   VERSION_VAR CYTHON_VERSION)

mark_as_advanced( CYTHON_EXECUTABLE )
