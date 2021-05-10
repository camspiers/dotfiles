(module plugin.lsp
        {autoload {nvim aniseed.nvim
                   lspsaga lspsaga
                   core aniseed.core
                   which-key which-key
                   lspinstall lspinstall
                   lspconfig lspconfig
                   nvim-lsp-ts-utils nvim-lsp-ts-utils}})

;; These servers get automatically setup
(def- auto-setup-servers [:bash :json :tailwindcss :html :css])

(defn- server-installed [server] "Checks if the server is installed"
       (core.some (partial = server) (lspinstall.installed_servers)))

;; The typescript config
(def- typescript-config {})

;; Typescript handlers
(set typescript-config.handlers
     {:textDocument/publishDiagnostics (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics
                                                     {:virtual_text true
                                                      :signs true
                                                      :underline true
                                                      :update_in_insert true})})

(fn typescript-config.on_attach [client buffer]
  "On attach function for the typescript server"
  (set client.resolved_capabilities.document_formatting false)
  ;; Set up lsp-ts-utils
  (nvim-lsp-ts-utils.setup {:disable_commands true :enable_formatting false})
  ;; Register bindings for lsp-ts-utils
  (which-key.register {:<leader>lo [nvim-lsp-ts-utils.organize_imports
                                    "LSP Organize"]
                       :<leader>lr [nvim-lsp-ts-utils.rename_file
                                    "LSP Rename File"]
                       :<leader>li [nvim-lsp-ts-utils.import_all
                                    "LSP Import All"]
                       :<leader>lc [nvim-lsp-ts-utils.fix_current
                                    "LSP Fix Current"]}
                      {: buffer}))

(defn- setup-typescript-server [] "Sets up the typescript server"
       (lspconfig.typescript.setup typescript-config))

(def- lua-server-settings
      {:Lua {:runtime {:version :LuaJIT :path (vim.split package.path ";")}
             :diagnostics {:globals {1 :vim}}
             :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                   (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}}}})

(defn- setup-lua-server [] "Sets up the lua server"
       (lspconfig.lua.setup {:settings lua-server-settings}))

(defn- setup-csharp-server [] "Sets up the csharp server"
       (lspconfig.csharp.setup {}))

(defn- setup-lsp-servers []
       "Sets up all lsp servers, installing & auto configuring ones that are 'auto-setup'"
       ;; Set up lspinstall
       (lspinstall.setup) ;; Register a post install hook
       (fn lspinstall.post_install_hook []
         "Register a post install hook that calls this setup servers function"
         (setup-lsp-servers)
         (vim.cmd "bufdo e"))
       ;; Auto set up certain servers and install them if they aren't yet installed
       (each [_ server (ipairs auto-setup-servers)]
         (if (server-installed server)
             ((. (. lspconfig server) :setup) {})
             (lspinstall.install_server server)))
       ;; If the lua server is installed then set it up
       (when (server-installed :lua)
         (setup-lua-server))
       ;; If the typescript server is installed then set it up
       (when (server-installed :typescript)
         (setup-typescript-server))
       ;; If the csharp server is installed then set it up
       (when (server-installed :csharp)
         (setup-csharp-server)))

;; Set up all the servers
(setup-lsp-servers)

;; Define new signs for lsp
(vim.fn.sign_define :LspDiagnosticsSignError
                    {:texthl :LspDiagnosticsSignError
                     :text ""
                     :numhl :LspDiagnosticsSignError})

(vim.fn.sign_define :LspDiagnosticsSignWarning
                    {:texthl :LspDiagnosticsSignWarning
                     :text ""
                     :numhl :LspDiagnosticsSignWarning})

(vim.fn.sign_define :LspDiagnosticsSignHint
                    {:texthl :LspDiagnosticsSignHint
                     :text ""
                     :numhl :LspDiagnosticsSignHint})

(vim.fn.sign_define :LspDiagnosticsSignInformation
                    {:texthl :LspDiagnosticsSignInformation
                     :text ""
                     :numhl :LspDiagnosticsSignInformation})

(lspsaga.init_lsp_saga {})

