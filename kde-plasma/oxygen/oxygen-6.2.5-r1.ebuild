# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.6.0
QTMIN=6.7.2
inherit ecm plasma.kde.org

DESCRIPTION="Oxygen visual style for the Plasma desktop"
HOMEPAGE="https://invent.kde.org/plasma/oxygen"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS="amd64 arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="+qt6 X"

# slot op: Uses Qt6::GuiPrivate for qtx11extras_p.h
COMMON_DEPEND="
	qt6? (
		>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
		>=dev-qt/qtdeclarative-${QTMIN}:6
		>=kde-frameworks/frameworkintegration-${KFMIN}:6
		>=kde-frameworks/kcmutils-${KFMIN}:6
		>=kde-frameworks/kcompletion-${KFMIN}:6
		>=kde-frameworks/kconfig-${KFMIN}:6
		>=kde-frameworks/kconfigwidgets-${KFMIN}:6
		>=kde-frameworks/kcoreaddons-${KFMIN}:6
		>=kde-frameworks/kguiaddons-${KFMIN}:6
		>=kde-frameworks/ki18n-${KFMIN}:6
		>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
		>=kde-frameworks/kwindowsystem-${KFMIN}:6
		>=kde-plasma/kdecoration-${KDE_CATV}:6
		>=kde-plasma/libplasma-${KDE_CATV}:6
	)
	X? (
		>=dev-qt/qtbase-${QTMIN}:6=[gui]
		x11-libs/libxcb
	)
"
DEPEND="${COMMON_DEPEND}
	>=kde-frameworks/kservice-${KFMIN}:6
"
RDEPEND="${COMMON_DEPEND}
	!<kde-plasma/libplasma-6.1.90:*[-kf6compat(-)]
	>=dev-qt/qtsvg-${QTMIN}:6
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_QT6=$(usex qt6)
		$(cmake_use_find_package X XCB)
	)
	ecm_src_configure
}
