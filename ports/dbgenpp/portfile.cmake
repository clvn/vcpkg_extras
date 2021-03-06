include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO clvn/dbgenpp
	REF 7259e0bcb661fe0baf947aafcb3762ab2bdca376
    SHA512 1d95299f6af5378b8c8606bb8013dd121c81b71fa8e5ca5c2f00abb66ea20e61957985ec92c7f47ed9e22c1976ddd95b060a183811b72de67447c3b8191bc419
    HEAD_REF master)

IF (TRIPLET_SYSTEM_ARCH MATCHES "x86")
	SET(BUILD_ARCH "Win32")
ELSE()
	SET(BUILD_ARCH ${TRIPLET_SYSTEM_ARCH})
ENDIF()

# need re2c and lemon
set(ENV{PATH} "$ENV{PATH};${CURRENT_INSTALLED_DIR}/tools")

vcpkg_build_msbuild(
    PROJECT_PATH ${SOURCE_PATH}/dbgenpp.sln
    OPTIONS_DEBUG /p:OutDir=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/
    OPTIONS_RELEASE /p:OutDir=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/
	PLATFORM ${BUILD_ARCH}
)

# Allow empty include directory
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/dbgenpp.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
# file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/dbgenpp.exe DESTINATION ${CURRENT_PACKAGES_DIR}/debug/tools)

file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/dbgenpp RENAME copyright)