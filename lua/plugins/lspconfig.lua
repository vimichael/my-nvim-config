return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				PATH = "prepend",
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				automatic_enable = false,
				ensure_installed = {
					"fortls",
					"bashls",
					"omnisharp",
					"cmake",
					"lua_ls",
					"gopls",
					"templ",
					"html",
					"cssls",
					"emmet_ls",
					"tailwindcss",
					"ts_ls",
					"astro",
					"ols",
					"pyright",
					"clangd",
					"prismals",
					"yamlls",
					"jsonls",
					"eslint",
					"marksman",
					"sqlls",
					"wgsl_analyzer",
					"texlab",
					"intelephense",
					"nim_langserver",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig").util
			local configs = require("lspconfig.configs")

      lspconfig.cmake.setup({
        capabilities = capabilities,
      })
      lspconfig.fortls.setup({
        capabilities = capabilities,
        root_dir = require("lspconfig").util.root_pattern("*.f90"),
      })
      lspconfig.purescriptls.setup({
        capabilities = capabilities,
        filetypes = { "purescript" },
        settings = {
          purescript = {
            addSpagoSources = true,
          },
        },
        flags = {
          debounce_text_changes = 150,
        },
      })
      lspconfig.ols.setup({
        capabilities = capabilities,
        root_dir = require("lspconfig").util.root_pattern("*.odin"),
      })
      lspconfig.ocamllsp.setup({
        capabilities = capabilities,
        cmd = { "ocamllsp", "--stdio" },
        filetypes = { "ocaml", "reason" },
        root_dir = require("lspconfig").util.root_pattern("*.opam", "esy.json", "package.json"),
      })
      if not configs.roc_ls then
        configs.roc_ls = {
          default_config = {
            cmd = { "roc_language_server", "--stdio" },
            capabilities = capabilities,
            filetypes = {
              "roc",
            },
            single_file_support = true,
          },
        }
      end
      lspconfig.roc_ls.setup({
        capabilities = capabilities,
      })
      -- lspconfig.gdscript.setup({
      --   capabilities = capabilities,
      --   filetypes = { "gd", "gdscript", "gdscript3" },
      -- })
      lspconfig.astro.setup({
        capabilities = capabilities,
      })
      lspconfig.nil_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.sqlls.setup({
        capabilities = capabilities,
      })
      lspconfig.intelephense.setup({
        capabilities = capabilities,
      })
      lspconfig.texlab.setup({
        capabilities = capabilities,
      })
      lspconfig.zls.setup({
        capabilities = capabilities,
        cmd = { "zls" },
      })
      lspconfig.hls.setup({
        capabilities = capabilities,
        single_file_support = true,
      })
      lspconfig.bashls.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        -- cmd = { "lua_ls" },
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Recognize 'vim' as a global variable
            },
            workspace = {
              library = {
                vim.api.nvim_get_runtime_file("", true),
                "${3rd}/love2d/library"
              }, -- Include Neovim runtime files
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      lspconfig.wgsl_analyzer.setup({
        capabilities = capabilities,
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })
      lspconfig.gopls.setup({
        capabilities = capabilities,
      })
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })
      lspconfig.prismals.setup({
        capabilities = capabilities,
      })
      lspconfig.yamlls.setup({
        capabilities = capabilities,
      })
      -- lspconfig.html.setup({
      --   capabilities = capabilities,
      --   single_file_support = true,
      --   filetypes = {
      --     "templ",
      --     "html",
      --     "php",
      --     "css",
      --     "javascriptreact",
      --     "typescriptreact",
      --     "javascript",
      --     "typescript",
      --     "jsx",
      --     "tsx",
      --   },
      -- })
      -- lspconfig.htmx.setup({
      --   capabilities = capabilities,
      --   single_file_support = true,
      --   filetypes = { "html", "templ" },
      -- })
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        single_file_support = true,
        filetypes = {
          "templ",
          "html",
          "css",
          "php",
          "javascript",
          "javascriptreact",
          "typescriptreact",
          "typescript",
          "jsx",
          "tsx",
        },
      })
      -- lspconfig.tailwindcss.setup({
      -- 	capabilities = capabilities,
      -- 	filetypes = {
      -- 		"templ",
      -- 		"html",
      -- 		"css",
      -- 		"javascriptreact",
      -- 		"typescriptreact",
      -- 		"javascript",
      -- 		"typescript",
      -- 		"jsx",
      -- 		"tsx",
      -- 	},
      -- 	root_dir = require("lspconfig").util.root_pattern(
      -- 		"tailwind.config.js",
      -- 		"tailwind.config.cjs",
      -- 		"tailwind.config.mjs",
      -- 		"tailwind.config.ts",
      -- 		"postcss.config.js",
      -- 		"postcss.config.cjs",
      -- 		"postcss.config.mjs",
      -- 		"postcss.config.ts",
      -- 		"package.json",
      -- 		"node_modules",
      -- 		".git"
      -- 	),
      -- })
      lspconfig.templ.setup({
        capabilities = capabilities,
        filetypes = { "templ" },
      })

      if not configs.ts_ls then
        configs.ts_ls = {
          default_config = {
            cmd = { "typescript-language-server", "--stdio" },
            capabilities = capabilities,
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "html",
            },
            root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", ".git"),
            single_file_support = true,
          },
        }
      end
      lspconfig.ts_ls.setup({
        -- capabilities = capabilities,
        -- cmd = { "typescript-language-server", "--stdio" },
        -- filetypes = {
        --   "javascript",
        --   "javascriptreact",
        --   "typescript",
        --   "typescriptreact",
        --   "html",
        -- },
        -- root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", ".git"),
        -- single_file_support = true,
      })
      lspconfig.eslint.setup({
        capabilities = capabilities,
      })
			lspconfig.cmake.setup({
				capabilities = capabilities,
			})
			lspconfig.fortls.setup({
				capabilities = capabilities,
				root_dir = require("lspconfig").util.root_pattern("*.f90"),
			})
			lspconfig.purescriptls.setup({
				capabilities = capabilities,
				filetypes = { "purescript" },
				settings = {
					purescript = {
						addSpagoSources = true,
					},
				},
				flags = {
					debounce_text_changes = 150,
				},
			})
			lspconfig.ols.setup({
				capabilities = capabilities,
				root_dir = require("lspconfig").util.root_pattern("*.odin"),
			})
			lspconfig.ocamllsp.setup({
				capabilities = capabilities,
				cmd = { "ocamllsp", "--stdio" },
				filetypes = { "ocaml", "reason" },
				root_dir = require("lspconfig").util.root_pattern("*.opam", "esy.json", "package.json"),
			})
			if not configs.roc_ls then
				configs.roc_ls = {
					default_config = {
						cmd = { "roc_language_server", "--stdio" },
						capabilties = capabilities,
						filetypes = {
							"roc",
						},
						single_file_support = true,
					},
				}
			end
			lspconfig.roc_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.gdscript.setup({
				capabilities = capabilities,
				filetypes = { "gd", "gdscript", "gdscript3" },
			})
			lspconfig.astro.setup({
				capabilities = capabilities,
			})
			lspconfig.nil_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.sqlls.setup({
				capabilities = capabilities,
			})
			lspconfig.intelephense.setup({
				capabilities = capabilities,
			})
			lspconfig.texlab.setup({
				capabilities = capabilities,
			})
			lspconfig.zls.setup({
				capabilities = capabilities,
				cmd = { "zls" },
			})
			lspconfig.hls.setup({
				capabilities = capabilities,
				single_file_support = true,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				-- cmd = { "lua_ls" },
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- Recognize 'vim' as a global variable
						},
						workspace = {
							library = {
								vim.api.nvim_get_runtime_file("", true),
								"${3rd}/love2d/library",
							}, -- Include Neovim runtime files
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			lspconfig.wgsl_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.prismals.setup({
				capabilities = capabilities,
			})
			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})
			-- lspconfig.html.setup({
			--   capabilities = capabilities,
			--   single_file_support = true,
			--   filetypes = {
			--     "templ",
			--     "html",
			--     "php",
			--     "css",
			--     "javascriptreact",
			--     "typescriptreact",
			--     "javascript",
			--     "typescript",
			--     "jsx",
			--     "tsx",
			--   },
			-- })
			-- lspconfig.htmx.setup({
			--   capabilities = capabilities,
			--   single_file_support = true,
			--   filetypes = { "html", "templ" },
			-- })
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
				single_file_support = true,
				filetypes = {
					"templ",
					"html",
					"css",
					"php",
					"javascript",
					"javascriptreact",
					"typescriptreact",
					"typescript",
					"jsx",
					"tsx",
				},
			})
			-- lspconfig.tailwindcss.setup({
			-- 	capabilities = capabilities,
			-- 	filetypes = {
			-- 		"templ",
			-- 		"html",
			-- 		"css",
			-- 		"javascriptreact",
			-- 		"typescriptreact",
			-- 		"javascript",
			-- 		"typescript",
			-- 		"jsx",
			-- 		"tsx",
			-- 	},
			-- 	root_dir = require("lspconfig").util.root_pattern(
			-- 		"tailwind.config.js",
			-- 		"tailwind.config.cjs",
			-- 		"tailwind.config.mjs",
			-- 		"tailwind.config.ts",
			-- 		"postcss.config.js",
			-- 		"postcss.config.cjs",
			-- 		"postcss.config.mjs",
			-- 		"postcss.config.ts",
			-- 		"package.json",
			-- 		"node_modules",
			-- 		".git"
			-- 	),
			-- })
			lspconfig.templ.setup({
				capabilities = capabilities,
				filetypes = { "templ" },
			})

			if not configs.ts_ls then
				configs.ts_ls = {
					default_config = {
						cmd = { "typescript-language-server", "--stdio" },
						capabilties = capabilities,
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"html",
						},
						root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", ".git"),
						single_file_support = true,
					},
				}
			end
			lspconfig.ts_ls.setup({
				-- capabilties = capabilities,
				-- cmd = { "typescript-language-server", "--stdio" },
				-- filetypes = {
				--   "javascript",
				--   "javascriptreact",
				--   "typescript",
				--   "typescriptreact",
				--   "html",
				-- },
				-- root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", ".git"),
				-- single_file_support = true,
			})
			lspconfig.eslint.setup({
				capabilties = capabilities,
			})

			require("lspconfig").clangd.setup({
				cmd = {
					"clangd",
					"--background-index",
					"--pch-storage=memory",
					"--all-scopes-completion",
					"--pretty",
					"--header-insertion=never",
					"-j=4",
					"--inlay-hints",
					"--header-insertion-decorators",
					"--function-arg-placeholders",
					"--completion-style=detailed",
				},
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_dir = require("lspconfig").util.root_pattern("src"),
				init_option = { fallbackFlags = { "-std=c++2a" } },
				capabilities = capabilities,
				single_file_support = true,
			})

			function get_python_path()
				-- Check if there's an active virtual environment
				local venv_path = os.getenv("VIRTUAL_ENV")
				if venv_path then
					return venv_path .. "/bin/python3"
				else
					-- get os name
					local os_name = require("utils").get_os()
					-- get os interpreter path
					if os_name == "windows" then
						return "C:/python312"
					elseif os_name == "linux" then
						return "/usr/bin/python3"
					else
						return "/Library/Frameworks/Python.framework/Versions/3.11/bin/python3"
					end
					-- Fallback to global Python interpreter
				end
			end

			lspconfig.pyright.setup({})

      -- lspconfig.pylsp.setup({
      --   cmd = { "pylsp" },
      --   capabilities = capabilities,
      --   root_dir = function(fname)
      --     local root_files = {
      --       'pyproject.toml',
      --       'setup.py',
      --       'setup.cfg',
      --       'requirements.txt',
      --       'Pipfile',
      --     }
      --     return util.root_pattern(unpack(root_files))(fname)
      --         or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
      --   end,
      --   single_file_support = true,
      --   -- settings = {
      --   --   python = {
      --   --     pythonPath = get_python_path(),
      --   --   },
      --   -- },
      -- })

      lspconfig.marksman.setup({
        capabilities = capabilities,
      })
      lspconfig.gleam.setup({
        capabilities = capabilities,
      })
      lspconfig.nim_langserver.setup({
        capabilities = capabilities,
      })
      lspconfig.omnisharp.setup({
        capabilities = capabilities,
        cmd = { "OmniSharp" },
      })
      lspconfig.fennel_ls.setup({
        capabilities = capabilities,
        cmd = { "fennel-ls" },
      })
      lspconfig.rescriptls.setup({
        capabilities = capabilities,
        cmd = { "rescript-language-server", "--stdio" },
        root_dir = require("lspconfig").util.root_pattern("rescript.json"),
      })

      lspconfig.julials.setup({
        capabilities = capabilities,
        -- cmd = { "julia-lsp" },
        cmd = {
          "julia",
          "--project=" .. "~/.julia/environments/lsp/",
          "--startup-file=no",
          "--history-file=no",
          "-e", [[
            using Pkg
            Pkg.instantiate()
            using LanguageServer
        depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
        project_path = let
            dirname(something(
                ## 1. Finds an explicitly set project (JULIA_PROJECT)
                Base.load_path_expand((
                    p = get(ENV, "JULIA_PROJECT", nothing);
                        p === nothing ? nothing : isempty(p) ? nothing : p
                    )),
                        ## 2. Look for a Project.toml file in the current working directory,
                        ##    or parent directories, with $HOME as an upper boundary
                        Base.current_project(),
                        ## 3. First entry in the load path
                        get(Base.load_path(), 1, nothing),
                        ## 4. Fallback to default global environment,
                        ##    this is more or less unreachable
                    Base.load_path_expand("@v#.#"),
                ))
            end
                    @info "Running language server" VERSION pwd() project_path depot_path
                    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
        server.runlinter = true
            run(server)
        ]]
        },
        on_attach = function(client, bufnr)
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        end,
        root_dir = require("lspconfig").util.root_pattern("*.jl"),
      })
      lspconfig.c3_lsp.setup({
        capabilities = capabilities,
        cmd = { "c3lsp" },
        root_dir = require("lspconfig").util.root_pattern({ "project.json", "*.c3" }),
      })
    end,
  },
}
