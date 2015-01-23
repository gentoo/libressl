# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/luasec/luasec-0.5.ebuild,v 1.1 2014/12/24 10:36:09 mrueg Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

DESCRIPTION="Lua binding for OpenSSL library to provide TLS/SSL communication"
HOMEPAGE="https://github.com/brunoos/luasec http://www.inf.puc-rio.br/~brunoos/luasec/"
SRC_URI="https://github.com/brunoos/luasec/archive/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="libressl"

S=${WORKDIR}/${PN}-${P}

RDEPEND=">=dev-lang/lua-5.1[deprecated]
		dev-lua/luasocket
		!libressl? ( dev-libs/openssl:0 )
		libressl? ( dev-libs/libressl:= )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	# Libressl
	epatch "${FILESDIR}"/${P}-libressl.patch

	sed -i -e "s#^LUAPATH.*#LUAPATH=$(pkg-config --variable INSTALL_LMOD lua)#"\
		-e "s#^LUACPATH.*#LUACPATH=$(pkg-config --variable INSTALL_CMOD lua)#" Makefile || die
	sed -i -e "s/-O2//" src/Makefile || die
	lua src/options.lua -g /usr/include/openssl/ssl.h > src/options.h || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		linux
}

src_install() {
	emake DESTDIR="${D}" install
}
