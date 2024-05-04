return {
    "mistricky/codesnap.nvim",
    lazy = "true",
    build = "make",
    cmd = "CodeSnapPreviewOn",
    opts = {
        mac_window_bar = true,
        watermark = "",
        preview_title = "",
        editor_font_family = "Hack Nerd Font Mono",
    },
    config = function(_, opts)
        require("codesnap").setup(opts)
    end,
}
