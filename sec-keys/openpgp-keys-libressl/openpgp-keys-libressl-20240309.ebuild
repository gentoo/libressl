# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenPGP keys used by the libressl project"
HOMEPAGE="https://www.libressl.org/"
SRC_URI="https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl.asc -> ${P}.asc"
S=${WORKDIR}

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc x86 ~amd64-linux ~ppc-macos ~x64-macos ~x64-solaris"

src_install() {
	local files=( ${A} )
	insinto /usr/share/openpgp-keys
	newins - libressl.asc < <(cat "${files[@]/#/${DISTDIR}/}" || die)
}
