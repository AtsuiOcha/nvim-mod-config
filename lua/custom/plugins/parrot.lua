-- File: lua/custom/plugins/parrot.lua
return {
  'frankroeder/parrot.nvim',
  main = 'parrot',
  dependencies = {
    'ibhagwan/fzf-lua',
    'nvim-lua/plenary.nvim',
  },
  lazy = false,

  config = function()
    require('parrot').setup {
      providers = {
        anthropic = {
          name = 'anthropic',

          endpoint = (function()
            local base = os.getenv 'ANTHROPIC_BASE_URL'
            if base and not base:match '/v1/messages$' then
              return base:gsub('/$', '') .. '/v1/messages'
            end
            return base or 'https://api.anthropic.com/v1/messages'
          end)(),

          model_endpoint = (function()
            local base = os.getenv 'ANTHROPIC_MODEL_ENDPOINT'
            if base then
              return base
            end
            local base2 = os.getenv 'ANTHROPIC_BASE_URL'
            if base2 then
              return base2:gsub('/$', '') .. '/v1/models'
            end
            return 'https://api.anthropic.com/v1/models'
          end)(),

          api_key = os.getenv 'ANTHROPIC_API_KEY' or os.getenv 'ANTHROPIC_AUTH_TOKEN',

          params = {
            chat = { max_tokens = 4096 },
            command = { max_tokens = 4096 },
          },

          topic = false,

          headers = function(self)
            return {
              ['Content-Type'] = 'application/json',
              ['x-api-key'] = self.api_key,
              ['anthropic-version'] = '2023-06-01',
            }
          end,

          models = {
            os.getenv 'ANTHROPIC_MODEL' or 'us-gov.anthropic.claude-sonnet-4-5-20250929-v1:0',
          },

          preprocess_payload = function(payload)
            for _, msg in ipairs(payload.messages) do
              if type(msg.content) == 'string' then
                msg.content = msg.content:gsub('^%s*(.-)%s*$', '%1')
              end
            end

            if payload.messages[1] and payload.messages[1].role == 'system' then
              payload.system = payload.messages[1].content
              table.remove(payload.messages, 1)
            end

            return payload
          end,
        },
      },

      toggle_target = 'popup',
      user_input_ui = 'native',
      enable_spinner = true,
    }

    -- keymaps
    local map = vim.keymap.set

    map({ 'n', 'i', 'v' }, '…', function()
      vim.cmd 'PrtChatToggle popup'
    end, { noremap = true, silent = true, desc = 'AI Chat Toggle' })

    map('v', '<leader>ar', ':PrtRewrite<CR>', { desc = 'AI Rewrite' })
    map('v', '<leader>aa', ':PrtAppend<CR>', { desc = 'AI Append' })
    map('v', '<leader>ap', ':PrtPrepend<CR>', { desc = 'AI Prepend' })
    map({ 'n', 'v' }, '<leader>as', '<cmd>PrtStop<CR>', { desc = 'AI Stop' })
  end,
}
