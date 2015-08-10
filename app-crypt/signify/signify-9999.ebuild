# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2

DESCRIPTION="OpenBSD tool to signs and verify signatures on files. Portable version."
HOMEPAGE="https://github.com/aperezdc/signify"
SRC_URI=""
EGIT_REPO_URI="git@github.com:aperezdc/signify.git
	https://github.com/aperezdc/signify.git"

LICENSE="ISC public-domain"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-libs/libbsd-0.7.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i \
		-e 's/$(CC) $(LDFLAGS)/$(CC) $(CFLAGS) $(LDFLAGS)/' \
		Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	einstalldocs
}
