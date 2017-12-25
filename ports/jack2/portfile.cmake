include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "WindowsStore not supported")
endif()

set(VERSION 1.9.12)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/jack2-${VERSION})
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jackaudio/jack2/releases/download/v${VERSION}/jack2-${VERSION}.tar.gz"
    FILENAME "jack2-${VERSION}.tar.gz"
    SHA512 f0271dfc8f8e2f2489ca52f431ad4fa420665816d6c67a01a76da1d4b5ae91f6dad8c4e3309ec5e0c159c9d312ed56021ab323d74bce828ace26f1b8d477ddfa
)
vcpkg_extract_source_archive(${ARCHIVE})

# Only install headers, developers install JACK for Windows separately and embed JackWeakAPI.c in their apps

file(INSTALL ${SOURCE_PATH}/common/jack DESTINATION ${CURRENT_PACKAGES_DIR}/include FILES_MATCHING PATTERN "*.h")

file(INSTALL ${SOURCE_PATH}/README DESTINATION ${CURRENT_PACKAGES_DIR}/share/jack2 RENAME copyright)

# Handle copyright
# file(COPY ${SOURCE_PATH}/NO_WARRANTY DESTINATION ${CURRENT_PACKAGES_DIR}/share/re2c)
# file(RENAME ${CURRENT_PACKAGES_DIR}/share/re2c/NO_WARRANTY ${CURRENT_PACKAGES_DIR}/share/re2c/copyright)
