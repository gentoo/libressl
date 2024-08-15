# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multilib-minimal

DESCRIPTION="dummy package for dev-libs/libressl"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:LibreSSL"
LICENSE="metapackage"

SLOT="0/56" # .so version of libssl/libcrypto
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~arm64-macos ~ppc-macos ~x64-macos ~x64-solaris"
IUSE="+asm quic sctp static-libs test sslv3"
REQUIRED_USE="!quic !sslv3"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/libressl:${SLOT}[asm=,static-libs=,test=,${MULTILIB_USEDEP}]"

S="${WORKDIR}"
