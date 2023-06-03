vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO openzim/libzim
    REF 3ca2fb887ab39cd6edad4c429bc320cec0eaaa6c
    SHA512 f59ef53684fa9872065b06da0dc2e4363585020fcd9477d40a0bffdade2ff7ac26f631d504301b99506a79359d7ede69f61ca8e42641b15bf598ae28d9ca44f0
    HEAD_REF fix/new-vcpkg
    PATCHES
        cross-builds.diff
        # dllexport.diff
        disable-gtest.diff
)

set(EXTRA_OPTIONS "")

if(NOT "xapian" IN_LIST FEATURES)
    list(APPEND EXTRA_OPTIONS "-Dwith_xapian=false")
endif()

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
      -Dexamples=false
      ${EXTRA_OPTIONS}
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
