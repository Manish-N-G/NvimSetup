-- This is a simple plugin. Allows us to open a tree of our history that we have make.
-- When we have this tree, we can see history of all changes even before node has changed and
-- branched off to a new node.
return {
  {
    'mbbill/undotree',
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {desc='[U]nto tree'} )
  }
}
