return {
  'vyfor/cord.nvim',
  build = ':Cord update',
  opts = {
    text = {
      editing = 'Editing a file',
      viewing = 'Viewing a file',
      file_browser = 'Browsing files in some directory',
      workspace = 'In some workspace',
    },
  },
}
