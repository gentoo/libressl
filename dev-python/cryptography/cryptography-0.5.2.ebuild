# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cryptography/cryptography-0.5.2.ebuild,v 1.1 2014/07/11 00:04:34 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Library providing cryptographic recipes and primitives"
HOMEPAGE="https://github.com/pyca/cryptography/ https://pypi.python.org/pypi/cryptography/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND="dev-libs/openssl:0
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/cffi-0.8:=[${PYTHON_USEDEP}]' python*)"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		=dev-python/cryptography-vectors-${PV}[${PYTHON_USEDEP}]
		dev-python/iso8601[${PYTHON_USEDEP}]
		dev-python/pretend[${PYTHON_USEDEP}]
		dev-python/pyasn1[${PYTHON_USEDEP}]
		>=dev-python/pytest-2.4.2[${PYTHON_USEDEP}]
	)"

DOCS=( AUTHORS.rst CONTRIBUTING.rst README.rst )

src_prepare() {
	epatch "${FILESDIR}/cryptography-liressl.diff"
}

python_test() {
	py.test -v || die "Tests fail with ${EPYTHON}"
}
