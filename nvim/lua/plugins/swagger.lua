return {
  {
    'vinnymeller/swagger-preview.nvim',
    cmd = { 'SwaggerPreview', 'SwaggerPreviewStop', 'SwaggerPreviewToggle' },
    build = 'npm i',
    config = true,
    opts = {
      port = 3200,
    },
  },
}