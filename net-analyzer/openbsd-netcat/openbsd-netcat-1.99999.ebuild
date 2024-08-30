# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="dummy package for dev-libs/libressl[netcat]"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:LibreSSL"
S="${WORKDIR}"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~loong ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc x86 ~amd64-linux ~ppc-macos ~x64-macos ~x64-solaris"

RDEPEND="dev-libs/libressl[netcat]"
