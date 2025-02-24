# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=Vulkan-Headers
inherit cmake

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/KhronosGroup/${MY_PN}.git"
	inherit git-r3
else
	EGIT_COMMIT="234c4b7370a8ea3239a214c9e871e4b17c89f4ab"
	SRC_URI="https://github.com/KhronosGroup/${MY_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm arm64 ~hppa ~loong ppc ppc64 ~riscv x86"
	S="${WORKDIR}"/${MY_PN}-${EGIT_COMMIT}
fi

DESCRIPTION="Vulkan Header files and API registry"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Headers"

LICENSE="Apache-2.0"
SLOT="0"

src_configure() {
	local mycmakeargs=(
		-DVULKAN_HEADERS_ENABLE_MODULE=OFF
	)

	cmake_src_configure
}
