# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python bindings for interacting with Vagrant virtual machines."
HOMEPAGE="https://github.com/todddeluca/python-vagrant"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	"
RDEPEND="
	${PYTHON_DEPS}
	app-emulation/vagrant
	"
