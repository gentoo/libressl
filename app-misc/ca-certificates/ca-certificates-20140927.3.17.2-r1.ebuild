# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ca-certificates/ca-certificates-20140927.3.17.2.ebuild,v 1.1 2014/10/16 17:48:39 vapier Exp $

# The Debian ca-certificates package merely takes the CA database as it exists
# in the nss package and repackages it for use by openssl.
#
# The issue with using the compiled debs directly is two fold:
# - they do not update frequently enough for us to rely on them
# - they pull the CA database from nss tip of tree rather than the release
#
# So we take the Debian source tools and combine them with the latest nss
# release to produce (largely) the same end result.  The difference is that
# now we know our cert database is kept in sync with nss and, if need be,
# can be sync with nss tip of tree more frequently to respond to bugs.

# When triaging bugs from users, here's some handy tips:
# - To see what cert is hitting errors, use openssl:
#   openssl s_client -port 443 -CApath /etc/ssl/certs/ -host $HOSTNAME
#   Focus on the errors written to stderr.
#
# - Look at the upstream log as to why certs were added/removed:
#   https://hg.mozilla.org/projects/nss/log/tip/lib/ckfw/builtins/certdata.txt
#
# - If people want to add/remove certs, tell them to file w/mozilla:
#   https://bugzilla.mozilla.org/enter_bug.cgi?product=NSS&component=CA%20Certificates&version=trunk

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit eutils python-any-r1 versionator

DEB_VER=$(get_version_component_range 1)
NSS_VER=$(get_version_component_range 2-)
RTM_NAME="NSS_${NSS_VER//./_}_RTM"

DESCRIPTION="Common CA Certificates PEM files"
HOMEPAGE="http://packages.debian.org/sid/ca-certificates"
NMU_PR=""

SRC_URI="mirror://debian/pool/main/c/${PN}/${PN}_${DEB_VER}${NMU_PR:++nmu}${NMU_PR}.tar.xz
	ftp://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/${RTM_NAME}/src/nss-${NSS_VER}.tar.gz
	cacert? ( http://dev.gentoo.org/~anarchy/patches/nss-3.14.1-add_spi+cacerts_ca_certs.patch )"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE="+cacert +trusted-db"

DEPEND="${PYTHON_DEPS}"

S=${WORKDIR}
MY_D=${S}/${PN}/mozilla

src_unpack() {
	default
	mv ${PN}-*/ ${PN} || die
}

src_prepare() {
	if use cacert ; then
		pushd "${S}"/nss-${NSS_VER} >/dev/null
		epatch "${DISTDIR}"/nss-3.14.1-add_spi+cacerts_ca_certs.patch
		popd >/dev/null
	fi
}

src_compile() {
	# Grab the database from the nss sources.
	cp "${S}"/nss-${NSS_VER}/nss/lib/ckfw/builtins/{certdata.txt,nssckbi.h} \
		"${MY_D}" || die
	emake -C "${MY_D}"
}

src_install() {
	insinto /var/lib/ca-certificates/mozilla/
	keepdir /etc/ssl/certs /etc/ca-certificates/update.d
	doins "${MY_D}"/*.crt

	if use cacert ; then
		insinto /var/lib/ca-certificates/cacert.org
		newins "${MY_D}"/CAcert_Inc..crt cacert.org_root.crt
		insinto /var/lib/ca-certificates/spi-inc.org
		newins "${MY_D}"/SPI_Inc..crt spi-cacert-2008.crt
	fi

	doman ca-certificates/sbin/*.8
	dodoc ca-certificates/debian/README.* \
		ca-certificates/examples/ca-certificates-local/README

	if use trusted-db ; then
		find "${ED%/}"/var/lib/ca-certificates/ -type f \
			-exec sed -e '$a\' '{}' >> "${ED%/}"/etc/ssl/cert.pem + \
			|| die
	fi
}

pkg_postinst() {
	if use trusted-db ; then
		elog "This ebuild installs a default trusted cert bundle as"
		elog "\"/etc/ssl/cert.pem\"."
		elog "If you don't want that, disable 'trusted-db' USE flag."
		elog
	fi
	elog "In order to customize trusted certs, you have to build the"
	elog "trusted cert bundle file at \"/etc/ssl/cert.pem\""
	elog "or the hash-style ca-directory in \"/etc/ssl/certs\"."
	elog "Both can be done with the package app-crypt/p11-kit, also see"
	elog "http://p11-glue.freedesktop.org/doc/p11-kit/trust.html"
	elog
	elog "The packaged certificates are placed in"
	elog "\"/var/lib/ca-certificates/\"."
}

