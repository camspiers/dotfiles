# Neovim Configuration (Cam Spiers)
## Dependencies

| Dependency              | Description                                    |
| ----------------------- | ---------------------------------------------- |
| Neovim                  | Untested in Vim                                |
| vim-plug                | Plugin Manger                                  |
| Yarn                    | Required by Plugins                            |
| Git                     | Required by Plugins                            |
| python3 support         | Required by Plugins                            |
| font with devicons      | Devicons in statusline                         |
| Fuzzy Finder (fzf)      | Search                                         |
| ripgrep                 | Search                                         |
| bat                     | Search Previews                                |
| tmux                    | Open Projects                                  |
| tmuxinator              | Open Projects                                  |
| tmuxinator-fzf-start.sh | Open Projects                                  |
| timer                   | Pomodoro timer (https://github.com/rlue/timer) |
| lazygit                 | Git terminal interfact                         |
| lazydocker              | Docker terminal interface                      |


## Plugins

### Importance

| Level | Meaning                                        |
| ----- | --------------------------                     |
| 1     | Critically relied on                           |
| 2     | Strongly relied on                             |
| 3     | Moderately relied on                           |
| 4     | Nice to have                                   |
| 5     | Not yet learned or found particularly integral |
| 6     | Barely am aware I use it                       |

### Stable (with respect to my usage)

| Plugin                                                                                | Description                            | Customized | Importance |
| ------------------------------------------------------------------------------------- | ----------------                       | --         | --         |
| [tpope/vim-sensible](tpope/vim-sensible)                                              | Sensible defaults                      | No         | 1          |
| [wincent/terminus](https://github.com/wincent/terminus)                               | Defaults for mouse and cursor          | No         | 1          |
| [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)                 | Statusline                             | Yes        | 1          |
| [vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)   | Themes for statusline                  | No         | 3          |
| [mhinz/vim-startify](https://github.com/mhinz/vim-startify)                           | Start screen                           | Yes        | 3          |
| [edkolev/tmuxline.vim](https://github.com/edkolev/tmuxline.vim)                       | Derive tmux theme from airline         | Yes        | 3          |
| [mhinz/vim-signify](https://github.com/mhinz/vim-signify)                             | Display git information in gutter      | No         | 3          |
| [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons)                   | Nice icons                             | No         | 4          |
| [psliwka/vim-smoothie](https://github.com/psliwka/vim-smoothie)                       | Better scrolling                       | No         | 4          |
| [Yggdroot/indentLine](https://github.com/Yggdroot/indentLine)                         | Indentation indication                 | Yes        | 3          |
| [chriskempson/base16-vim](https://github.com/chriskempson/base16-vim)                 | Themes                                 | No         | 1          |
| [blueyed/vim-diminactive](https://github.com/blueyed/vim-diminactive)                 | Dims inactive windows                  | Yes        | 4          |
| [justinmk/vim-dirvish](https://github.com/justinmk/vim-dirvish)                       | Replacement for netrw                  | No         | 1          |
| [fsharpasharp/vim-dirvinist](https://github.com/fsharpasharp/vim-dirvinist)           | Displays projections in dirvish buffer | No         | 5          |
| /usr/local/opt/fzf                                                                    | FZF Binary                             | No         | 1          |
| [junegunn/fzf](https://github.com/junegunn/fzf)                                       | FZF Core Functions                     | No         | 1          |
| [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)                               | FZF Vim integrations                   | Yes        | 1          |
| [jesseleite/vim-agriculture](https://github.com/jesseleite/vim-agriculture)           | Full options for Ripgrep               | Yes        | 1          |
| [airblade/vim-rooter](https://github.com/airblade/vim-rooter)                         |                                        |            |
| [tpope/vim-projectionist](https://github.com/tpope/vim-projectionist)                 |                                        |            |
| [c-brenn/fuzzy-projectionist.vim](https://github.com/c-brenn/fuzzy-projectionist.vim) |                                        |            |
| [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)   |                                        |            |
| [wincent/vcs-jump](https://github.com/wincent/vcs-jump)                               |                                        |            |
| [wincent/loupe](https://github.com/wincent/loupe)                                     |                                        |            |
| [romainl/vim-qf](https://github.com/romainl/vim-qf)                                   |                                        |            |
| [editorconfig/editorconfig-vim](https://github.com/editorconfig/editorconfig-vim)     |                                        |            |
| [prettier/vim-prettier](https://github.com/prettier/vim-prettier)                     |                                        |            |
| [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim)                             |                                        |            |
| [neoclide/coc-snippets](https://github.com/neoclide/coc-snippets)                     |                                        |            |
| [neoclide/coc-tsserver](https://github.com/neoclide/coc-tsserver)                     |                                        |            |
| [neoclide/coc-eslint](https://github.com/neoclide/coc-eslint)                         |                                        |            |
| [neoclide/coc-tslint](https://github.com/neoclide/coc-tslint)                         |                                        |            |
| [neoclide/coc-css](https://github.com/neoclide/coc-css)                               |                                        |            |
| [neoclide/coc-lists](https://github.com/neoclide/coc-lists)                           |                                        |            |
| [neoclide/coc-highlight](https://github.com/neoclide/coc-highlight)                   |                                        |            |
| [neoclide/coc-json](https://github.com/neoclide/coc-json)                             |                                        |            |
| [neoclide/coc-html](https://github.com/neoclide/coc-html)                             |                                        |            |
| [tomtom/tcomment_vim](https://github.com/tomtom/tcomment_vim)                         |                                        |            |
| [tpope/vim-surround](https://github.com/tpope/vim-surround)                           |                                        |            |
| [godlygeek/tabular](https://github.com/godlygeek/tabular)                             |                                        |            |
| [bkad/CamelCaseMotion](https://github.com/bkad/CamelCaseMotion)                       |                                        |            |
| [tpope/vim-repeat](https://github.com/tpope/vim-repeat)                               |                                        |            |
| [wincent/replay](https://github.com/wincent/replay)                                   |                                        |            |
| [AndrewRadev/splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim)             |                                        |            |
| [kkoomen/vim-doge](https://github.com/kkoomen/vim-doge)                               |                                        |            |
| [justinmk/vim-sneak](https://github.com/justinmk/vim-sneak)                           |                                        |            |
| [romainl/vim-cool](https://github.com/romainl/vim-cool)                               |                                        |            |
| [junegunn/vim-peekaboo](https://github.com/junegunn/vim-peekaboo)                     |                                        |            |
| [dstein64/vim-startuptime](https://github.com/dstein64/vim-startuptime)               |                                        |            |
| [noahfrederick/vim-composer](https://github.com/noahfrederick/vim-composer)           |                                        |            |
| [skanehira/docker-compose.vim](https://github.com/skanehira/docker-compose.vim)       |                                        |            |
| [vimwiki/vimwiki](https://github.com/vimwiki/vimwiki)                                 |                                        |            |
| [vim-vdebug/vdebug](https://github.com/vim-vdebug/vdebug)                             |                                        |            |
| [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)       |                                        |            |
| [samoshkin/vim-mergetool](https://github.com/samoshkin/vim-mergetool)                 |                                        |            |
| [prashantjois/vim-slack](https://github.com/prashantjois/vim-slack)                   |                                        |            |
| [xuhdev/vim-latex-live-preview](https://github.com/xuhdev/vim-latex-live-preview)     |                                        |            |
| [glacambre/firenvim](https://github.com/glacambre/firenvim)                           |                                        |            |
| [tpope/vim-eunuch](https://github.com/tpope/vim-eunuch)                               |                                        |            |
| [kassio/neoterm](https://github.com/kassio/neoterm)                                   |                                        |            |
| [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)                           |                                        |            |
| [tpope/vim-dadbod](https://github.com/tpope/vim-dadbod)                               |                                        |            |
| [tpope/vim-unimpaired](https://github.com/tpope/vim-unimpaired)                       |                                        |            |
| [rhysd/git-messenger.vim](https://github.com/rhysd/git-messenger.vim)                 |                                        |            |
| [inkarkat/vim-ingo-library](https://github.com/inkarkat/vim-ingo-library)             |                                        |            |
| [inkarkat/vim-spellcheck](https://github.com/inkarkat/vim-spellcheck)                 |                                        |            |
| [duggiefresh/vim-easydir](https://github.com/duggiefresh/vim-easydir)                 |                                        |            |
| [kshenoy/vim-signature](https://github.com/kshenoy/vim-signature)                     |                                        |            |
| [bfontaine/Brewfile.vim](https://github.com/bfontaine/Brewfile.vim)                   |                                        |            |
| [ekalinin/dockerfile.vim](https://github.com/ekalinin/dockerfile.vim)                 |                                        |            |
| [jwalton512/vim-blade](https://github.com/jwalton512/vim-blade)                       |                                        |            |
| [leafgarland/typescript-vim](https://github.com/leafgarland/typescript-vim)           |                                        |            |
| [lilyball/vim-swift](https://github.com/lilyball/vim-swift)                           |                                        |            |
| [peitalin/vim-jsx-typescript](https://github.com/peitalin/vim-jsx-typescript)         |                                        |            |
| [phalkunz/vim-ss](https://github.com/phalkunz/vim-ss)                                 |                                        |            |
| [StanAngeloff/php.vim](https://github.com/StanAngeloff/php.vim)                       |                                        |            |
| [tmux-plugins/vim-tmux](https://github.com/tmux-plugins/vim-tmux)                     |                                        |            |
 
### Trial (with respect to my usage)

| Plugin | Description |
| ------ | -------- |
| | |

## Mappings

This Neovim config is tailored towards PHP and JavaScript/TypeScript work
it uses the vim-plug plugin manager and requires the following tools:

| Source         | Tool                    | Description                   |
| -------------- | ----------------------- | ----------------------------- |
| External       | Neovim                  | Untested in Vim               |
| External       | vim-plug                | Plugin Manger                 |
| External       | Yarn                    | Required by Plugins           |
| External       | Git                     | Required by Plugins           |
| External       | python3 support         | Required by Plugins           |
| External       | font with devicons      | Devicons in statusline        |
| External       | Fuzzy Finder (FZF)      | Search                        |
| External       | ripgrep                 | Search                        |
| External       | bat                     | Search Previews               |
| External       | tmux                    | Open Projects                 |
| External       | tmuxinator              | Open Projects                 |
| External       | tmuxinator-fzf-start.sh | Open Projects                 |
| External       | timer                   | https://github.com/rlue/timer |
| External       | lazygit                 | Git terminal interfact        |
| External       | lazydocker              | Docker terminal interface     |
| Local          | tmux-fzf-kill.sh        | Tmux kill FZF interface       |
| Local          | tmux-fzf-switch.sh      | Tmux switch FZF interface     |
