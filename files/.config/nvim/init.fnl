(fn ensure [user repo]
  (let [install-path (string.format "%s/site/pack/packer/start/%s"
                                    (vim.fn.stdpath :data) repo)]
    (when (> (vim.fn.empty (vim.fn.glob install-path)) 0)
      (vim.api.nvim_command (string.format "!git clone https://github.com/%s/%s %s"
                                           user repo install-path))
      (vim.api.nvim_command (string.format "packadd %s" repo)))))

(ensure :wbthomason :packer.nvim)
(ensure :Olical :aniseed)

(tset vim.g "aniseed#env" {:module :dotfiles.init :compile true})

