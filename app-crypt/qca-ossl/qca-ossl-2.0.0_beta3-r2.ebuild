# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/qca-ossl/qca-ossl-2.0.0_beta3-r2.ebuild,v 1.9 2012/06/14 07:01:37 yngwin Exp $

EAPI=5
inherit eutils qt4-r2

MY_P="${P/_/-}"
QCA_VER="${PV%.*}"

DESCRIPTION="TLS, S/MIME, PKCS#12, crypto algorithms plugin for QCA"
HOMEPAGE="http://delta.affinix.com/qca/"
SRC_URI="http://delta.affinix.com/download/qca/${QCA_VER}/plugins/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~sparc-solaris"
IUSE="debug libressl"

DEPEND=">=app-crypt/qca-${QCA_VER}[debug?]
	!libressl? ( >=dev-libs/openssl-0.9.6:0 )
	libressl? ( dev-libs/libressl:= )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

PATCHES=(
	"${FILESDIR}/${PN}-openssl-1.0.0.patch"
	"${FILESDIR}/${P}-libressl.patch"
)

src_configure() {
	use prefix || EPREFIX=
	# Fix some locations
	sed -e "s|/usr/|${EPREFIX}/usr/|g" -e "s|usr/local|usr/|g" -i configure

	# cannot use econf because of non-standard configure script
	./configure --qtdir="${EPREFIX}"/usr --no-separate-debug-info \
		$(use debug && echo "--debug" || echo "--release") || die

	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
}
