# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit multilib-minimal

DESCRIPTION="dummy package for dev-libs/libressl"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:LibreSSL"
LICENSE="metapackage"

SLOT="0/48" # .so version of libssl/libcrypto
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~mips ppc ppc64 ~s390 sparc x86 ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="+asm bindist sslv3 static-libs test"
REQUIRED_USE="!sslv3"

RDEPEND="dev-libs/libressl:${SLOT}[asm=,static-libs=,test=,${MULTILIB_USEDEP}]"

S="${WORKDIR}"
