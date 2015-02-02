# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gloox/gloox-1.0.12.ebuild,v 1.1 2014/11/26 02:42:58 mrueg Exp $

EAPI=5

inherit eutils

MY_P="${P/_/-}"
DESCRIPTION="A portable high-level Jabber/XMPP library for C++"
HOMEPAGE="http://camaya.net/gloox"
SRC_URI="http://camaya.net/download/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0/13"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug gnutls idn libressl ssl static-libs test zlib"
REQUIRED_USE="?? ( gnutls libressl )"

DEPEND="idn? ( net-dns/libidn )
	ssl? (
		gnutls? ( net-libs/gnutls )
		!libressl? ( dev-libs/openssl:0 )
		libressl? ( dev-libs/libressl:= )
	)
	zlib? ( sys-libs/zlib )"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch_user
}

src_configure() {
	# Examples are not installed anyway, so - why should we build them?
	econf \
		--without-examples \
		$(use debug && echo "--enable-debug") \
		$(use_enable static-libs static) \
		$(use_with idn libidn) \
		$(usex ssl "$(use_with gnutls)" "--without-gnutls") \
		$(use_with ssl openssl) \
		$(use_with test tests) \
		$(use_with zlib)
}

src_install() {
	default
	prune_libtool_files
}
