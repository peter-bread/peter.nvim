---@class peter.util.table
local M = {}

local H = {}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Remove `keys` from `tbl` in-place.
---@param tbl table Table to mutate.
---@param keys string[] Keys to remove.
---@return table tbl The mutated table.
function M.without_keys(tbl, keys)
  local keyset = H.make_keyset(keys)

  for key in pairs(keyset) do
    tbl[key] = nil
  end

  return tbl
end

---Remove `keys` from a copy of `tbl`.
---
---WARNING: This function is subject to change and/or removal.
---@param tbl table Original table.
---@param keys string[] Keys to remove.
---@return table tbl_copy New table with keys removed.
function M.without_keys_copy(tbl, keys)
  return M.without_keys(vim.deepcopy(tbl), keys)
end

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ---------- END OF API FUNCTIONS. START OF HELPER FUNCTIONS. ---------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

function H.make_keyset(keys)
  local keyset = {}
  for _, key in ipairs(keys) do
    keyset[key] = true
  end
  return keyset
end

return M
