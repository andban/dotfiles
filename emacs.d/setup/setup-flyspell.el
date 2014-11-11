(require 'flyspell)

;; Use aspell for spell checking: brew install aspell --lang=en
(setq ispell-program-name "/usr/local/bin/aspell")

(setq ispell-list-command "--list")

(setq flyspell-issue-message-flg nil)
(add-hook 'web-mode-hook
          (lambda () (flyspell-prog-mode)))

(ac-flyspell-workaround)

(provide 'setup-flyspell)
