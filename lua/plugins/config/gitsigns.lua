require('gitsigns').setup({
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },

   highlights = {
    add = {hl = 'DiffAdd'},         -- 使用DiffAdd高亮组来显示添加标记
    change = {hl = 'DiffChange'},   -- 使用DiffChange高亮组来显示更改标记
    delete = {hl = 'DiffDelete'}    -- 使用DiffDelete高亮组来显示删除标记
  },

  -- 修改行号颜色, 作为标记
  numhl = true,         -- 当前行号是否修改
  linehl = false,       -- 当前行颜色是否修改
  signcolumn = true,
})


