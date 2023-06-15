# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multilib-minimal

DESCRIPTION="dummy package for dev-libs/libressl"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:LibreSSL"
LICENSE="metapackage"

SLOT="0/54" # .so version of libssl/libcrypto
KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~mips ~ppc ~ppc64 ~s390 ~sparc x86 ~amd64-linux ~ppc-macos ~x64-macos ~x64-solaris"
IUSE="+asm sslv3 static-libs test"
REQUIRED_USE="!sslv3"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/libressl:${SLOT}[asm=,static-libs=,test=,${MULTILIB_USEDEP}]"

S="${WORKDIR}"
