# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib-build

DESCRIPTION="This is a fake ebuild to support libressl"
HOMEPAGE="http://www.openssl.org/"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 mips ppc ppc64 x86"
IUSE="kerberos static-libs bindist zlib"

DEPEND=">=dev-libs/libressl-2.0.0[static-libs?,${MULTILIB_USEDEP}]"
RDEPEND="${DEPEND}
	app-misc/c_rehash"
