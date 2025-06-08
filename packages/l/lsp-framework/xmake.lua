-- luacheck: ignore 111 113 143
---@diagnostic disable: undefined-global, undefined-field
-- will upload to
-- https://github.com/xmake-io/xmake-repo
package("lsp-framework")
do
    set_homepage("https://github.com/leon-bckl/lsp-framework")
    set_description("lsp-framework - Language Server Protocol implementation in C++")

    set_urls("https://github.com/leon-bckl/lsp-framework/archive/refs/tags/$(version).tar.gz",
        "https://github.com/leon-bckl/lsp-framework.git")
    add_versions("1.1.1", "bd430a3c0a8a6704c220a479790bbea24a17895c2e25720681b49cfd90081217")

    add_deps("cmake", "ninja")

    on_install(function(package)
        import("package.tools.cmake").install(package, {'-GNinja'})
    end)
end
package_end()
