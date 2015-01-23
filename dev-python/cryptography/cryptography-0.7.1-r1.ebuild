# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cryptography/cryptography-0.7.1-r1.ebuild,v 1.1 2015/01/14 00:32:22 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Library providing cryptographic recipes and primitives"
HOMEPAGE="https://github.com/pyca/cryptography/ https://pypi.python.org/pypi/cryptography/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="|| ( Apache-2.0 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris"
IUSE="libressl test"

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	!libressl? ( dev-libs/openssl:0 )
	libressl? ( dev-libs/libressl:= )
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/cffi-0.8:=[${PYTHON_USEDEP}]' 'python*')
	$(python_gen_cond_dep 'dev-python/enum34[${PYTHON_USEDEP}]' python2_7 python3_3 pypy)"
DEPEND="${RDEPEND}
	test? (
		~dev-python/cryptography-vectors-${PV}[${PYTHON_USEDEP}]
		dev-python/iso8601[${PYTHON_USEDEP}]
		dev-python/pretend[${PYTHON_USEDEP}]
		>=dev-python/pytest-2.4.2[${PYTHON_USEDEP}]
	)"

DOCS=( AUTHORS.rst CONTRIBUTING.rst README.rst )

PATCHES=(
	"${FILESDIR}"/0.7-setup.patch
	"${FILESDIR}"/0.7-libressl.patch )

python_test() {
	py.test -v || die "Tests fail with ${EPYTHON}"
}
