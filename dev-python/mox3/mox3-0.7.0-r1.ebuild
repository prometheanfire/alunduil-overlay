# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mox3/mox3-0.7.0.ebuild,v 1.2 2014/08/01 05:59:05 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )
DISTUTILS_IN_SOURCE_BUILD=TRUE

inherit distutils-r1

DESCRIPTION="Mock object framework for Python"
HOMEPAGE="http://www.openstack.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

CDEPEND="
	>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
	<dev-python/pbr-1.0[${PYTHON_USEDEP}]
"
CRDEPEND=">=dev-python/fixtures-0.3.12[${PYTHON_USEDEP}]"

# NOTE dev-python/hacking isn't actually required for tests
# >=dev-python/hacking-0.5.6[${PYTHON_USEDEP}]
# <dev-python/hacking-0.7[${PYTHON_USEDEP}]

# NOTE dev-python/pyflakes isn't actually required for tests
# ~dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${CDEPEND}
	test? (
		${CRDEPEND}
		>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
		~dev-python/flake8-2.0[${PYTHON_USEDEP}]
		~dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
		dev-python/subunit[${PYTHON_USEDEP}]
		>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
		>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}]
	)
"
RDEPEND="
	${CDEPEND}
	${CRDEPEND}
"

python_prepare() {
	if [[ "${EPYTHON}" = "python3.4" ]]; then
		ebegin "patching mox3/tests/test_mox.py for ${EPYTHON}"
		sed \
			-e '/def testStubOutClass_OldStyle(self):/,/def/ d' \
			-i mox3/tests/test_mox.py || die 'sed'
		eend $?
	fi

	distutils-r1_python_prepare
}

python_test() {
	testr init || die "testr init failed under ${EPYTHON}"
	testr run || die "testr run failed under ${EPYTHON}"
}
