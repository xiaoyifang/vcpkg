if(VCPKG_TARGET_IS_WINDOWS)
  list(APPEND PATCHES "0001-remove-cross-compile-test.patch")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "http://green.ribbon.to/~ikazuhiro/dic/files/ebu-4.5-20200413.tar.gz"
    FILENAME "ebu-4.5-20200413.tar.gz"
    SHA512 ec72aac8eb660d155660fdd612076df03c68c735cb584df48718542363a1a87baa076510dae71918287e88c2af68362ec06aec9b05b063e9f6519576c597e453
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES ${PATCHES}
)

vcpkg_configure_make(
  SOURCE_PATH ${SOURCE_PATH}
  AUTOCONFIG
  OPTIONS    --enable-ipv6=no --enable-ebnet=no --enable-nls=no
)
vcpkg_install_make()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")


vcpkg_fixup_pkgconfig()

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
