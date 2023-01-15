# Copyright 2018-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1 toolchain-funcs

MY_PN="M2Crypto"
DESCRIPTION="A Python crypto and SSL toolkit"
HOMEPAGE="https://gitlab.com/m2crypto/m2crypto https://pypi.org/project/M2Crypto/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~loong ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~x64-macos"
IUSE="test abi_mips_n32 abi_mips_n64 abi_mips_o32"
RESTRICT="!test? ( test )"

BDEPEND="
	>=dev-lang/swig-2.0.9
	test? ( dev-python/parameterized[${PYTHON_USEDEP}] )
"
RDEPEND="
	dev-libs/openssl:0=
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-libressl-0.38.0.patch"
)

distutils_enable_tests setup.py

swig_define() {
	local x
	for x; do
		if tc-cpp-is-true "defined(${x})"; then
			SWIG_FEATURES+=" -D${x}"
		fi
	done
}

src_prepare() {
	# relies on very exact clock behavior which apparently fails
	# with inconvenient CONFIG_HZ*
	sed -e 's:test_server_simple_timeouts:_&:' \
		-i tests/test_ssl.py || die
	distutils-r1_src_prepare
}

python_compile() {
	# setup.py looks at platform.machine() to determine swig options.
	# For exotic ABIs, we need to give swig a hint.
	local -x SWIG_FEATURES=

	# https://bugs.gentoo.org/617946
	swig_define __ILP32__

	# https://bugs.gentoo.org/674112
	swig_define __ARM_PCS_VFP

	# Avoid similar errors to bug #688668 for MIPS
	if use abi_mips_n32; then
	    swig_define _MIPS_SIM = _ABIN32
	elif use abi_mips_n64; then
	    swig_define _MIPS_SIM = _ABI64
	elif use abi_mips_o32; then
	    swig_define _MIPS_SIM = _ABIO32
	fi

	distutils-r1_python_compile --openssl="${ESYSROOT}"/usr
}
