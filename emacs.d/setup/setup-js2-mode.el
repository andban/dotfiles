
(add-hook 'js-mode-hook 'js2-minor-mode)

(eval-after-load "js2-mode"
  '(progn
     (setq js2-missing-semi-one-line-override t)
     (setq-default js2-basic-offset 4)))
