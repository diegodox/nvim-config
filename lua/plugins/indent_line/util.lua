local M = {}

function M.round(n) return n >= 0 and math.floor(n + 0.5) or math.ceil(n - 0.5) end

function M.hex2rgb(hex)
    hex = hex:gsub("#", "")
    return { r = tonumber(hex:sub(1, 2), 16), g = tonumber(hex:sub(3, 4), 16), b = tonumber(hex:sub(5, 6), 16) }
end

function M.rgb2hex(rgb)
    local r = math.min(math.max(0, M.round(rgb.r)), 255)
    local g = math.min(math.max(0, M.round(rgb.g)), 255)
    local b = math.min(math.max(0, M.round(rgb.b)), 255)
    return "#" .. ("%02X%02X%02X"):format(r, g, b)
end

function M.add(a, bg, fg)
    local r = bg.r + (fg.r - bg.r) * a
    local g = bg.g + (fg.g - bg.g) * a
    local b = bg.b + (fg.b - bg.b) * a
    return { r = r, g = g, b = b }
end

function M.get_hl_bg_rgb(name)
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    if not hl.background then
        return false, nil
    end
    ---@diagnostic disable-next-line: undefined-global
    local tohex = bit.tohex
    return true, M.hex2rgb("#" .. tohex(hl.background, 6))
end

-- set indent highlights minimal style
---@param hls string[]
function M.highlight_indent_blankline(hls)
    for i, hl in ipairs(hls) do
        vim.cmd({
            cmd = "highlight",
            args = { "IndentBlanklineIndent" .. i, "guifg=" .. hl },
        })
    end
end

-- set indent highlights like vscode's indent-rainbow
---@param hls string[]
function M.highlight_indent_rainbow(alpha, fg, hls)
    local is_ok, normal_bg_rgb = M.get_hl_bg_rgb("Normal")
    if not is_ok then
        return
    end

    -- vim.cmd({
    --     cmd = "highlight",
    --     args = { "Visual", "guibg=#264f78", "gui=nocombine" },
    -- })
    for i, hl in ipairs(hls) do
        local bg = M.add(alpha, normal_bg_rgb, M.hex2rgb(hl))
        vim.cmd({
            cmd = "highlight",
            args = { "IndentBlanklineIndent" .. i, "guifg=" .. fg, "guibg=" .. M.rgb2hex(bg), "gui=nocombine" },
        })
    end
end

--return M
return {}
