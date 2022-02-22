vcpkg_download_distfile(ARCHIVE
    URLS "http://green.ribbon.to/~ikazuhiro/dic/files/eb-4.4.3+u-20100516.tar.gz"
    FILENAME "eb-4.4.3+u-20100516.tar.gz"
    SHA512 25cf88dcaa702b9dd93427c5d44e108f79b92a19fef3cc776d5aca862a8695bd1a3c70a75152677f547b58fb561d5a8405c8410f0cae355cb7d25af679289b0b
)
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

if(VCPKG_TARGET_IS_WINDOWS)
  z_vcpkg_determine_autotools_host_cpu(BUILD_ARCH)
  z_vcpkg_determine_autotools_target_cpu(HOST_ARCH)
  list(APPEND OPTIONS --build=${BUILD_ARCH}-pc-mingw32)
  list(APPEND OPTIONS --host=${HOST_ARCH}-pc-mingw32)
endif()

vcpkg_configure_make(
  SOURCE_PATH ${SOURCE_PATH}
  AUTOCONFIG
  OPTIONS   --enable-ipv6=no --enable-ebnet=no --enable-nls=no --host=x86_64-pc-mingw32
)
vcpkg_install_make()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")


vcpkg_fixup_pkgconfig()

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
