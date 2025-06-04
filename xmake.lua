-- luacheck: ignore 111 113 143
---@diagnostic disable: undefined-global, undefined-field
package("lsp-framework")
do
    set_homepage("https://github.com/leon-bckl/lsp-framework")
    set_description("lsp-framework - Language Server Protocol implementation in C++")

    set_urls("https://github.com/leon-bckl/lsp-framework/archive/refs/tags/$(version).tar.gz",
        "https://github.com/leon-bckl/lsp-framework.git")
    add_versions("1.0.1", "07f924d851896a2d424d554d20820483f8458aa1ff907bb68657b0d2d0bd0d13")

    add_deps("cmake", "ninja")

    on_install(function(package)
        -- https://github.com/leon-bckl/lsp-framework/pull/10
        io.replace("CMakeLists.txt", "add_library(lsp STATIC)", [[
option(BUILD_SHARED_LIBS "Build using shared libraries" OFF)
add_library(lsp)
install(TARGETS lsp LIBRARY)
include(GNUInstallDirs)
install(FILES
	${LSP_GENERATED_FILES_DIR}/lsp/types.h
	${LSP_GENERATED_FILES_DIR}/lsp/messages.h
	DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/lsp)
install(DIRECTORY lsp DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
        ]], {plain = true})
        import("package.tools.cmake").install(package, {'-GNinja', '-DBUILD_SHARED_LIBS=ON'})
    end)
end
package_end()
add_requires("lsp-framework")
set_languages("c++20")

target("katid")
do
    set_kind("binary")
    add_files("src/*.cc")
    add_packages("lsp-framework")
    on_load(
        function(target)
            if not os.isdir("kati") then
                import("devel.git")
                git.clone("https://github.com/Freed-Wu/kati", { depth = 1, branch="meson" })
            end
        end
    )
end
