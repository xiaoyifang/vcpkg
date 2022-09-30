vcpkg_download_distfile(ARCHIVE
    URLS https://oligarchy.co.uk/xapian/1.4.21/xapian-core-1.4.21.tar.xz
    FILENAME xapian-core-1.4.21.tar.xz
    SHA512 4071791daf47f5ae77f32f358c6020fcfa9aa81c15c8da25489b055eef30383695e449ab1cb73670f2f5db2b2a5f78056da0e8eea89d83aaad91dfe340a6b13a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)
if(WIN32)
    vcpkg_replace_string("${SOURCE_PATH}/configure.ac" "z zlib zdll" "z zlib zdll zlibd")

endif()

vcpkg_configure_make(
    SOURCE_PATH "${SOURCE_PATH}"
    AUTOCONFIG
)

vcpkg_install_make()

vcpkg_fixup_pkgconfig()
vcpkg_cmake_config_fixup()
if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/cmake/xapian")
    vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/xapian)
elseif(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib/cmake/xapian")
    vcpkg_cmake_config_fixup(CONFIG_PATH debug/lib/cmake/xapian)
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
# Handle copyright
configure_file("${SOURCE_PATH}/COPYING" "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" COPYONLY)
# vcpkg_copy_pdbs()
