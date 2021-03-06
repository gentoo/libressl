# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="library and programs to process reports from NetFlow data"
HOMEPAGE="https://code.google.com/p/flow-tools/"
SRC_URI="https://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug mysql postgres ssl static-libs"

RDEPEND="
	acct-group/flows
	acct-user/flows
	sys-apps/tcp-wrappers
	sys-libs/zlib
	mysql? ( dev-db/mysql-connector-c:0= )
	postgres? ( dev-db/postgresql:* )
	ssl? ( dev-libs/openssl:0= )"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/flex
	sys-devel/bison"

DOCS=( ChangeLog README SECURITY TODO )

PATCHES=(
	"${FILESDIR}"/${P}-run.patch
	"${FILESDIR}"/${P}-syslog.patch
	"${FILESDIR}"/${P}-openssl11.patch
	"${FILESDIR}"/${P}-fno-common.patch
)

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(usex mysql --with-mysql '') \
		$(usex postgres --with-postgresql=yes --with-postgresql=no) \
		$(usex ssl --with-openssl '') \
		--sysconfdir=/etc/flow-tools
}

src_install() {
	default

	find "${D}" -name '*.la' -delete || die

	exeinto /var/lib/flows/bin
	doexe "${FILESDIR}"/linkme

	keepdir /var/lib/flows/ft

	newinitd "${FILESDIR}/flowcapture.initd" flowcapture
	newconfd "${FILESDIR}/flowcapture.confd" flowcapture

	fowners flows:flows /var/lib/flows
	fowners flows:flows /var/lib/flows/bin
	fowners flows:flows /var/lib/flows/ft

	fperms 0755 /var/lib/flows
	fperms 0755 /var/lib/flows/bin
}
