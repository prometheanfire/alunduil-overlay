# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Holland mysqldump Plugin"
HOMEPAGE="http://www.hollandbackup.org/"

MY_P="${P%%-*}-${P##*-}"

SRC_URI="http://hollandbackup.org/releases/stable/${PV%.*}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

CDEPEND="
	=app-backup/holland-lib-common-${PV}[${PYTHON_USEDEP}]
	=app-backup/holland-lib-mysql-${PV}[${PYTHON_USEDEP}]
"
DEPEND="
	${PYTHON_DEPS}
	${CDEPEND}
"
RDEPEND="
	${PYTHON_DEPS}
	app-arch/gzip
	${CDEPEND}
"
PDEPEND="=app-backup/holland-${PV}[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}/plugins/${PN//-/.}"

python_install_all() {
	distutils-r1_python_install_all

	keepdir /etc/holland
	keepdir /etc/holland/backupsets
	keepdir /etc/holland/providers

	insinto /etc/holland/backupsets
	doins "${S}"/../../config/backupsets/examples/${PN##*-}.conf

	insinto /etc/holland/providers
	doins "${S}"/../../config/providers/${PN##*-}.conf
}

pkg_postinst() {
	einfo "Inline-compression is performed by default."
	einfo "gzip is used by default but any of the following can be used if installed:"
	einfo ""
	einfo "* app-arch/gzip"
	einfo "* app-arch/bzip2"
	einfo "* app-arch/xz-utils"
}
