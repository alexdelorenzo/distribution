# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 Trond Haugland (trondah@gmail.com)

PKG_NAME="pcsx_rearmed"
PKG_VERSION="e8633a2e14027e4552940ef3e1c27c40b94c4870"
PKG_SHA256="f44293026af94934a98cd60a6a86d9e1316c78ab82d5536832a3ba947f55c461"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="ARM optimized PCSX fork"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+speed -gold"
PKG_PATCH_DIRS+="${DEVICE}"

make_target() {
  cd ${PKG_BUILD}
  if [ ! "${ARCH}" = "aarch64" ]; then
    make -f Makefile.libretro GIT_VERSION=${PKG_VERSION} platform=rpi3
  fi
}

makeinstall_target() {
  INSTALLTO="/usr/lib/libretro/"

  mkdir -p ${INSTALL}${INSTALLTO}
  cd ${PKG_BUILD}
  if [ "${ARCH}" = "aarch64" ]; then
    cp -vP ${PKG_BUILD}/../../build.${DISTRO}-${DEVICE}.arm/pcsx_rearmed-*/.install_pkg/usr/lib/libretro/pcsx_rearmed_libretro.so ${INSTALL}${INSTALLTO}
  else
    cp pcsx_rearmed_libretro.so ${INSTALL}${INSTALLTO}
  fi
}
