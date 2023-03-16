local ok, headlines = pcall(require, 'headlines')
if not ok then
  return
end

vim.cmd [[highlight Headline guibg=#22212C gui=bold]]
vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
vim.cmd [[highlight Dash guibg=#22212C guifg=#454158 gui=bold]]

headlines.setup({
  markdown = {
        query = vim.treesitter.parse_query(
            "markdown",
            [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
            ]]
        ),
        headline_highlights = { "Headline" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        dash_string = "-",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headlines = true,
        fat_headline_upper_string = "",
        fat_headline_lower_string = "",
    },
})
