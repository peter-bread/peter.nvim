---@class peter.util.diffview
local M = {}

---@alias peter.util.diffview.LayoutName
---| "diff1"
---| "diff2_hor"
---| "diff2_ver"
---| "diff3"
---| "diff3_hor"
---| "diff3_ver"
---| "diff3_mixed"
---| "diff4"
---| "diff4_mixed"

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]
--

---Select a Diffview layout by name.
---
---Not all layouts work in all situations (ex: diff3_mixed only works on
---merge-tool conflicts). The caller is responsible for ensuring the layout
---is valid for the current file.
---@param name peter.util.diffview.LayoutName
function M.select_layout3(name)
  local lazy = require("diffview.lazy")
  local lib = require("diffview.lib")

  -- stylua: ignore
  local DiffView = lazy.access("diffview.scene.views.diff.diff_view", "DiffView")
  local FileHistoryView = lazy.access(
    "diffview.scene.views.file_history.file_history_view",
    "FileHistoryView"
  )

  -- stylua: ignore start
  local Diff1       = lazy.access("diffview.scene.layouts.diff_1"      ,  "Diff1")
  local Diff2Hor    = lazy.access("diffview.scene.layouts.diff_2_hor"  ,  "Diff2Hor")
  local Diff2Ver    = lazy.access("diffview.scene.layouts.diff_2_ver"  ,  "Diff2Ver")
  local Diff3       = lazy.access("diffview.scene.layouts.diff_3"      ,  "Diff3")
  local Diff3Hor    = lazy.access("diffview.scene.layouts.diff_3_hor"  ,  "Diff3Hor")
  local Diff3Ver    = lazy.access("diffview.scene.layouts.diff_3_ver"  ,  "Diff3Ver")
  local Diff3Mixed  = lazy.access("diffview.scene.layouts.diff_3_mixed",  "Diff3Mixed")
  local Diff4       = lazy.access("diffview.scene.layouts.diff_4"      ,  "Diff4")
  local Diff4Mixed  = lazy.access("diffview.scene.layouts.diff_4_mixed",  "Diff4Mixed")

  local layout_map = {
    diff1       = Diff1      .__get(),
    diff2_hor   = Diff2Hor   .__get(),
    diff2_ver   = Diff2Ver   .__get(),
    diff3       = Diff3      .__get(),
    diff3_hor   = Diff3Hor   .__get(),
    diff3_ver   = Diff3Ver   .__get(),
    diff3_mixed = Diff3Mixed .__get(),
    diff4       = Diff4      .__get(),
    diff4_mixed = Diff4Mixed .__get(),
  }
  -- stylua: ignore end

  local target = layout_map[name]
  if not target then
    vim.notify("Unknown layout: " .. name, vim.log.levels.ERROR)
    return
  end

  local view = lib.get_current_view()
  if not view then
    return
  end

  -- Determine which file entries to update.
  local files

  if view:instanceof(FileHistoryView.__get()) then
    files = view.panel:list_files()
  elseif view:instanceof(DiffView.__get()) then
    local cur = view.cur_entry
    if not cur then
      return
    end

    if cur.kind == "conflicting" then
      files = view.files.conflicting
    else
      files = vim.list_extend(
        vim.deepcopy(view.panel.files.working),
        view.panel.files.staged
      )
    end
  else
    -- Not a diffview or file history view → do nothing.
    return
  end

  -- Save cursor + focus.
  local main = view.cur_layout:get_main_win()
  local pos = vim.api.nvim_win_get_cursor(main.id)
  local was_focused = view.cur_layout:is_focused()

  -- Apply layout to all file entries.
  for _, entry in ipairs(files) do
    entry:convert_layout(target)
  end

  -- Reopen current file to apply layout + restore cursor/focus.
  view:set_file(view.cur_entry, false)

  local new_main = view.cur_layout:get_main_win()
  vim.api.nvim_win_set_cursor(new_main.id, pos)

  if was_focused then
    new_main:focus()
  end
end

---@deprecated
function M.select_layout2(name)
  local lazy = require("diffview.lazy")
  local lib = require("diffview.lib")
  -- stylua: ignore
  -- local DiffView = lazy.access("diffview.scene.views.diff.diff_view", "DiffView") -- Unused.
  local FileHistoryView = lazy.access(
    "diffview.scene.views.file_history.file_history_view",
    "FileHistoryView"
  )

  -- stylua: ignore start
  local Diff1       = lazy.access("diffview.scene.layouts.diff_1"      ,  "Diff1")
  local Diff2Hor    = lazy.access("diffview.scene.layouts.diff_2_hor"  ,  "Diff2Hor")
  local Diff2Ver    = lazy.access("diffview.scene.layouts.diff_2_ver"  ,  "Diff2Ver")
  local Diff3       = lazy.access("diffview.scene.layouts.diff_3"      ,  "Diff3")
  local Diff3Hor    = lazy.access("diffview.scene.layouts.diff_3_hor"  ,  "Diff3Hor")
  local Diff3Ver    = lazy.access("diffview.scene.layouts.diff_3_ver"  ,  "Diff3Ver")
  local Diff3Mixed  = lazy.access("diffview.scene.layouts.diff_3_mixed",  "Diff3Mixed")
  local Diff4       = lazy.access("diffview.scene.layouts.diff_4"      ,  "Diff4")
  local Diff4Mixed  = lazy.access("diffview.scene.layouts.diff_4_mixed",  "Diff4Mixed")

  local layout_map = {
    diff1       = Diff1      .__get(),
    diff2_hor   = Diff2Hor   .__get(),
    diff2_ver   = Diff2Ver   .__get(),
    diff3       = Diff3      .__get(),
    diff3_hor   = Diff3Hor   .__get(),
    diff3_ver   = Diff3Ver   .__get(),
    diff3_mixed = Diff3Mixed .__get(),
    diff4       = Diff4      .__get(),
    diff4_mixed = Diff4Mixed .__get(),
  }
  -- stylua: ignore end

  local target = layout_map[name]
  if not target then
    return
  end

  local view = lib.get_current_view()
  if not view then
    return
  end

  -- Save cursor + focus state BEFORE changing anything
  local main = view.cur_layout:get_main_win()
  local pos = vim.api.nvim_win_get_cursor(main.id)
  local was_focused = view.cur_layout:is_focused()

  -- Determine which file entries to update
  local files
  if view:instanceof(FileHistoryView.__get()) then
    files = view.panel:list_files()
  else
    local cur = view.cur_entry
    if not cur then
      return
    end
    if cur.kind == "conflicting" then
      files = view.files.conflicting
    else
      files = vim.list_extend(
        vim.deepcopy(view.panel.files.working),
        view.panel.files.staged
      )
    end
  end

  -- Convert all entries to the chosen layout
  for _, entry in ipairs(files) do
    entry:convert_layout(target)
  end

  -- Re-open the current file to apply layout
  view:set_file(view.cur_entry, false)
  local new_main = view.cur_layout:get_main_win()

  -- Restore cursor WITHOUT causing jump
  vim.api.nvim_win_set_cursor(new_main.id, pos)

  if was_focused then
    new_main:focus()
  end
end

---Select diffview layout by `name`.
---
---Not all layouts work in all circumstances, for example `"diff3_mixed"` is only
---available for merge_tool. There are no checks in this function to verify that
---a layout is valid. It is the callers responsibility to ensure a valid layout
---is being used.
---@deprecated Cursor jumps on first call.
---@param name peter.util.diffview.LayoutName
function M.select_layout1(name)
  local lazy = require("diffview.lazy")
  local lib = require("diffview.lib")
  -- stylua: ignore
  local DiffView = lazy.access("diffview.scene.views.diff.diff_view", "DiffView")
  local FileHistoryView = lazy.access(
    "diffview.scene.views.file_history.file_history_view",
    "FileHistoryView"
  )

  -- stylua: ignore start
  local Diff1       = lazy.access("diffview.scene.layouts.diff_1",        "Diff1")
  local Diff2Hor    = lazy.access("diffview.scene.layouts.diff_2_hor",    "Diff2Hor")
  local Diff2Ver    = lazy.access("diffview.scene.layouts.diff_2_ver",    "Diff2Ver")
  local Diff3       = lazy.access("diffview.scene.layouts.diff_3",        "Diff3")
  local Diff3Hor    = lazy.access("diffview.scene.layouts.diff_3_hor",    "Diff3Hor")
  local Diff3Ver    = lazy.access("diffview.scene.layouts.diff_3_ver",    "Diff3Ver")
  local Diff3Mixed  = lazy.access("diffview.scene.layouts.diff_3_mixed",  "Diff3Mixed")
  local Diff4       = lazy.access("diffview.scene.layouts.diff_4",        "Diff4")
  local Diff4Mixed  = lazy.access("diffview.scene.layouts.diff_4_mixed",  "Diff4Mixed")

  local layout_map = {
    diff1       = Diff1      .__get(),
    diff2_hor   = Diff2Hor   .__get(),
    diff2_ver   = Diff2Ver   .__get(),
    diff3       = Diff3      .__get(),
    diff3_hor   = Diff3Hor   .__get(),
    diff3_ver   = Diff3Ver   .__get(),
    diff3_mixed = Diff3Mixed .__get(),
    diff4       = Diff4      .__get(),
    diff4_mixed = Diff4Mixed .__get(),
  }
  -- stylua: ignore end

  local target = layout_map[name]
  if not target then
    vim.notify("Unknown layout: " .. name, vim.log.levels.ERROR)
    return
  end

  local view = lib.get_current_view()
  if not view then
    return
  end

  local files
  if view:instanceof(FileHistoryView.__get()) then
    files = view.panel:list_files()
  elseif view:instanceof(DiffView.__get()) then
    local cur = view.cur_entry
    if not cur then
      return
    end

    if cur.kind == "conflicting" then
      files = view.files.conflicting
    else
      files = vim.list_extend(
        vim.deepcopy(view.panel.files.working),
        view.panel.files.staged
      )
    end
  else
    return
  end

  for _, entry in ipairs(files) do
    entry:convert_layout(target)
  end

  -- Preserve cursor position
  local main = view.cur_layout:get_main_win()
  local pos = vim.api.nvim_win_get_cursor(main.id)

  view:set_file(view.cur_entry, false)

  main = view.cur_layout:get_main_win()
  if pos then
    vim.api.nvim_win_set_cursor(main.id, pos)
  end
end

---Toggle between a pair of layouts.
---
---This function calls `M.select_layout3`, so, as with that function, it is the
---caller's responsibility to ensure the layouts are valid for the diffview mode.
---@param a peter.util.diffview.LayoutName
---@param b peter.util.diffview.LayoutName
function M.toggle_layout_pair(a, b)
  local lib = require("diffview.lib")

  local view = lib.get_current_view()
  if not view or not view.cur_entry then
    return
  end

  local cur = view.cur_entry.layout.class.name
  local target = (cur == a) and b or a
  M.select_layout3(target)
end

return M
