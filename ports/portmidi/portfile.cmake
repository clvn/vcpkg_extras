include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "WindowsStore not supported")
endif()

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/portmidi)
vcpkg_download_distfile(ARCHIVE
    URLS "https://downloads.sourceforge.net/project/portmedia/portmidi/217/portmidi-src-217.zip"
    FILENAME "portmidi-src-217.zip"
    SHA512 d08d4d57429d26d292b5fe6868b7c7a32f2f1d2428f6695cd403a697e2d91629bd4380242ab2720e8f21c895bb75cb56b709fb663a20e8e623120e50bfc5d90b
)
vcpkg_extract_source_archive(${ARCHIVE})

# Fix project file for static library on windows
file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH}/pm_common)

# TODO: Fix project file for shared library on windows (in pm_dylib)
# TODO: Patch CMakeLists instead: hint shared/static, install on win32, install headers, configure prefix

# Run cmake configure step
vcpkg_configure_cmake(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DJAVA_INCLUDE_PATH=
        -DJAVA_INCLUDE_PATH2=
        -DJAVA_JVM_LIBRARY=
)

# Run cmake install step
vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(COPY ${SOURCE_PATH}/license.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/portmidi)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/portmidi/license.txt ${CURRENT_PACKAGES_DIR}/share/portmidi/copyright)
