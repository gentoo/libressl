# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib-minimal

DESCRIPTION="dummy package for dev-libs/libressl"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:LibreSSL"
LICENSE="metapackage"

SLOT="0"
KEYWORDS="amd64 arm ~arm64 ~hppa ~ia64 ~mips ppc ppc64 ~s390 sparc x86"

RDEPEND="dev-libs/libressl:${SLOT}[${MULTILIB_USEDEP}]"

S="${WORKDIR}"
