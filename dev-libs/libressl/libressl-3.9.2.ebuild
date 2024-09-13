# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/libressl.asc
inherit autotools multilib-minimal verify-sig

DESCRIPTION="Free version of the SSL/TLS protocol forked from OpenSSL"
HOMEPAGE="https://www.libressl.org/"
SRC_URI="
	https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${P}.tar.gz
	verify-sig? ( https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${P}.tar.gz.asc )
"

LICENSE="ISC openssl"
# Reflects ABI of libcrypto.so and libssl.so. Since these can differ,
# we'll try to use the max of either. However, if either change between
# versions, we have to change the subslot to trigger rebuild of consumers.
SLOT="0/56"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc x86 ~amd64-linux ~ppc-macos ~x64-macos ~x64-solaris"
IUSE="+asm netcat static-libs test"
RESTRICT="!test? ( test )"

PDEPEND="app-misc/ca-certificates"
BDEPEND="verify-sig? ( sec-keys/openpgp-keys-libressl )"
RDEPEND="netcat? (
	!net-analyzer/netcat
	!net-analyzer/nmap[symlink]
	!net-analyzer/openbsd-netcat
)"

MULTILIB_WRAPPED_HEADERS=( /usr/include/openssl/opensslconf.h )

# LibreSSL checks for libc features during configure
QA_CONFIG_IMPL_DECL_SKIP=(
	__va_copy
	b64_ntop
)

PATCHES=(
	"${FILESDIR}"/${PN}-2.8.3-solaris10.patch
	# Gentoo's ssl-cert.eclass uses 'openssl genrsa -rand'
	# which LibreSSL doesn't support.
	# https://github.com/libressl/portable/issues/839
	"${FILESDIR}"/${PN}-3.7.2-genrsa-rand.patch
)

src_prepare() {
	default

	eautoreconf
}

multilib_src_configure() {
	local ECONF_SOURCE="${S}"
	local args=(
		$(use_enable asm)
		$(use_enable static-libs static)
		$(use_enable netcat nc)
		$(use_enable test tests)
	)
	econf "${args[@]}"
}

multilib_src_install_all() {
	einstalldocs
	find "${D}" -name '*.la' -exec rm -f {} + || die
}
