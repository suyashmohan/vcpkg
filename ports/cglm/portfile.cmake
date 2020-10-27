vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO recp/cglm
    REF v0.7.8
    SHA512 1fd5db117f22899dbbb3e7c8ab452476293b155df96a34b4319a57991d2361a210d8e29d015c14cbdbcaa80440cddc3ed4c8d5930a2f2ed11853b02f60796e55
    HEAD_REF master
    PATCHES
        fix-directories.patch
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" CGLM_SHARED)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" CGLM_STATIC)

vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}"
    PREFER_NINJA
    OPTIONS
        -DCGLM_SHARED=${CGLM_SHARED}
        -DCGLM_STATIC=${CGLM_STATIC}
)
vcpkg_install_cmake()
vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets()

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/cglm" RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
