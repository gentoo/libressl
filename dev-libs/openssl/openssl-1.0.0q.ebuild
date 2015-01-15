# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib-build

DESCRIPTION="This is a fake ebuild to support libressl"
HOMEPAGE="http://www.openssl.org/"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="kerberos static-libs bindist"

DEPEND=">=dev-libs/libressl-2.0.0[static-libs?,${MULTILIB_USEDEP}]"
RDEPEND="${DEPEND}"
