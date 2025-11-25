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

---Select diffview layout by `name`.
---
---Not all layouts work in all circumstances, for example `"diff3_mixed"` is only
---available for merge_tool. There are no checks in this function to verify that
---a layout is valid. It is the callers responsibility to ensure a valid layout
---is being used.
---@param name peter.util.diffview.LayoutName
function M.select_layout(name)
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

return M
