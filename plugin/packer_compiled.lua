-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/diego/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/diego/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/diego/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/diego/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/diego/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n|\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\28current_line_blame_opts\1\0\1\ndelay\3d\1\0\1\23current_line_blame\2\nsetup\rgitsigns\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/diego/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["lazygit.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins.config.lazygit\frequire\0" },
    loaded = true,
    path = "/home/diego/.local/share/nvim/site/pack/packer/start/lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/diego/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/diego/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/diego/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/diego/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  rnvimr = {
    config = { "\27LJ\2\nã\2\0\0\a\0\16\0\0246\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\v€6\2\3\0'\4\4\0B\2\2\0016\2\5\0009\2\6\0029\2\a\2'\4\b\0'\5\t\0'\6\n\0B\2\4\1X\2\6€9\2\v\0015\4\r\0005\5\f\0=\5\14\0045\5\15\0B\2\3\1K\0\1\0\1\0\1\vprefix\r<Leader>\6b\1\0\0\1\3\0\0001<Cmd>RnvimrToggle<CR><Cmd>RnvimrResize 2<CR>\29Open ranger file manager\rregister1<Cmd>RnvimrToggle<CR><Cmd>RnvimrResize 2<CR>\14<Leader>b\6n\20nvim_set_keymap\bapi\bvim&[Rnvimr] could not load which-key\nprint\14which-key\frequire\npcall\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/diego/.local/share/nvim/site/pack/packer/opt/rnvimr",
    url = "https://github.com/kevinhwang91/rnvimr"
  },
  ["which-key.nvim"] = {
    after = { "rnvimr", "gitsigns.nvim" },
    loaded = true,
    only_config = true
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: rnvimr
time([[Setup for rnvimr]], true)
try_loadstring("\27LJ\2\nx\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0\21rnvimr_enable_bw\25rnvimr_enable_picker\21rnvimr_enable_ex\6g\bvim\0", "setup", "rnvimr")
time([[Setup for rnvimr]], false)
-- Config for: lazygit.nvim
time([[Config for lazygit.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins.config.lazygit\frequire\0", "config", "lazygit.nvim")
time([[Config for lazygit.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n\\\0\0\3\0\6\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0)\1d\0=\1\5\0K\0\1\0\15timeoutlen\6g\bvim\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd gitsigns.nvim ]]

-- Config for: gitsigns.nvim
try_loadstring("\27LJ\2\n|\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\28current_line_blame_opts\1\0\1\ndelay\3d\1\0\1\23current_line_blame\2\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")

vim.cmd [[ packadd rnvimr ]]

-- Config for: rnvimr
try_loadstring("\27LJ\2\nã\2\0\0\a\0\16\0\0246\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\v€6\2\3\0'\4\4\0B\2\2\0016\2\5\0009\2\6\0029\2\a\2'\4\b\0'\5\t\0'\6\n\0B\2\4\1X\2\6€9\2\v\0015\4\r\0005\5\f\0=\5\14\0045\5\15\0B\2\3\1K\0\1\0\1\0\1\vprefix\r<Leader>\6b\1\0\0\1\3\0\0001<Cmd>RnvimrToggle<CR><Cmd>RnvimrResize 2<CR>\29Open ranger file manager\rregister1<Cmd>RnvimrToggle<CR><Cmd>RnvimrResize 2<CR>\14<Leader>b\6n\20nvim_set_keymap\bapi\bvim&[Rnvimr] could not load which-key\nprint\14which-key\frequire\npcall\0", "config", "rnvimr")

time([[Sequenced loading]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
