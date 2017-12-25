include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "WindowsStore not supported")
endif()

set(VERSION 3210000)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/sqlite-src-${VERSION})
vcpkg_download_distfile(ARCHIVE
    URLS "http://www.sqlite.org/2017/sqlite-src-${VERSION}.zip"
    FILENAME "sqlite-src-${VERSION}.zip"
    SHA512 3a054422da80d750fd5ab297f9d2728f4e7b55fa790a72d55da8c381835571992d56b349e50d4680b04c9e2e44d6fa83009c2df3ffa045f43ff9059bb8736894
)
vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}/tool
    PATCHES ${CMAKE_CURRENT_LIST_DIR}/fix_win32_sep.patch
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

# Run cmake configure step
vcpkg_configure_cmake(SOURCE_PATH ${SOURCE_PATH})

# Run cmake install step
vcpkg_install_cmake()

# Allow empty include directory
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

# Handle copyright
file(WRITE ${CURRENT_PACKAGES_DIR}/share/lemon/copyright "Lemon is in the Public Domain.\nhttp://www.sqlite.org/copyright.html\n")

#file(COPY ${SOURCE_PATH}/NO_WARRANTY DESTINATION ${CURRENT_PACKAGES_DIR}/share/re2c)
#file(RENAME ${CURRENT_PACKAGES_DIR}/share/re2c/NO_WARRANTY ${CURRENT_PACKAGES_DIR}/share/re2c/copyright)
