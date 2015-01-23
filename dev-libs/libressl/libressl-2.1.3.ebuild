# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib-minimal

DESCRIPTION="Free version of the SSL/TLS protocol forked from OpenSSL"
HOMEPAGE="http://www.libressl.org/"
SRC_URI="http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${P}.tar.gz"

LICENSE="ISC openssl"
SLOT="0/30"
KEYWORDS="amd64 ~mips ppc ppc64 x86"
IUSE="+asm libtls static-libs"

# when importing into the tree, make sure to add
# 	!dev-libs/openssl:0
# to DEPEND
DEPEND="
	abi_x86_32? (
		!<=app-emulation/emul-linux-x86-baselibs-20140508
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)"
RDEPEND="${DEPEND}"
PDEPEND="app-misc/ca-certificates"

src_prepare() {
	# Fix building with MUSL Libc
	# Thanks, Voidlinux
	epatch "${FILESDIR}"/${PN}-glibc.patch
	touch crypto/Makefile.in

	sed -i \
		-e '/^CFLAGS=/s#-g##' \
		-e '/^USER_CFLAGS=/s#-O2##' \
		configure || die "fixing CFLAGS failed"
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable asm) \
		$(use_enable libtls) \
		$(use_enable static-libs static)
}

multilib_src_test() {
	emake check
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files

	# Include default config for openssl from openssl 1.0.1j
	insinto /etc/ssl
	newins "${S}/apps/openssl.cnf" openssl.cnf
}
