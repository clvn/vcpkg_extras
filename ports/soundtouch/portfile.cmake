include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "WindowsStore not supported")
endif()

set(VERSION 2.0.0)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/soundtouch)
vcpkg_download_distfile(ARCHIVE
    URLS "https://www.surina.net/soundtouch/soundtouch-${VERSION}.zip"
    FILENAME "soundtouch-${VERSION}.zip"
    SHA512 50ef36b6cd21c16e235b908c5518e29b159b11f658a014c47fe767d3d8acebaefefec0ce253b4ed322cbd26387c69c0ed464ddace0c098e61d56d55c198117a5
)
vcpkg_extract_source_archive(${ARCHIVE})

# Replace project files with upgraded ones
file(COPY ${CMAKE_CURRENT_LIST_DIR}/SoundTouchDLL.sln DESTINATION ${SOURCE_PATH}/source/SoundTouchDLL)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/SoundTouchDLL.vcxproj DESTINATION ${SOURCE_PATH}/source/SoundTouchDLL)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/SoundTouch.vcxproj DESTINATION ${SOURCE_PATH}/source/SoundTouch)

# TODO: Configuration=ReleaseX64|Win32
IF (TRIPLET_SYSTEM_ARCH MATCHES "x86")
	SET(BUILD_ARCH "Win32")
ELSE()
	SET(BUILD_ARCH ${TRIPLET_SYSTEM_ARCH})
ENDIF()

vcpkg_build_msbuild(
    PROJECT_PATH ${SOURCE_PATH}/source/SoundTouchDLL/SoundTouchDLL.sln
    OPTIONS_DEBUG /p:OutDir=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/
    OPTIONS_RELEASE /p:OutDir=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/
	PLATFORM ${BUILD_ARCH}
)

file(COPY ${SOURCE_PATH}/source/SoundTouchDLL/SoundTouchDLL.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# Handle libraries
file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/SoundTouchDLL.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/SoundTouchDLL.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/SoundTouchDLL.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/SoundTouchDLL.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)


file(COPY ${SOURCE_PATH}/COPYING.TXT DESTINATION ${CURRENT_PACKAGES_DIR}/share/soundtouch)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/soundtouch/COPYING.TXT ${CURRENT_PACKAGES_DIR}/share/soundtouch/copyright)
