(require 'cc-vars)
;(require 'cc-mode)

(c-add-style 
 "andban-c-style"
 '("linux"
   (c-basic-offset . 4)
   (indent-tabs-mode . nil)
   (c-comment-only-line-offset . 0)
   (c-comment-continuation-start . "* ")
   (c-auto-newline . t)
   (c-cleanup-list . (scope-operator
                      defun-close-semi))
   (c-hanging-braces-alist ((substatement-open)
                            (block-close . c-snug-do-while)
                            (extern-lang-open after)
                            (extern-class-open after)
                            (inexpr-class-close before)))
   (c-offsets-alist . ((string . 0)
                       (innamespace . -)
                       (substatement-open . 0)
                       ;(substatement-intro . 0)
                       (knr-argdecl-intro . 0)
                       (inline-open . 0)
                       (access-label . -)
                       (case-label . 0)
                       (statement-case-open . 0)
                       (statement-case-intro . +)
                       (arglist-close . c-lineup-close-paren)
                       (inextern-lang . 0)))))

(add-to-list 'c-default-style '(c-mode   . "andban-c-style"))
(add-to-list 'c-default-style '(c++-mode . "andban-c-style"))

(require 'auto-highlight-symbol)
(defun andban-c-mode-common-hook ()
  (auto-highlight-symbol-mode 1)
  (setq c-hungry-delete-key t))

(add-hook 'c-mode-common-hook 'andban-c-mode-common-hook)


(add-to-list 'ac-omni-completion-sources
             (cons "\\." '(ac-source-semantic)))
(add-to-list 'ac-omni-completion-sources
             (cons "->" '(ac-source-semantic)))


(defconst eclipse-java-style
  '((c-basic-offset . 4)
    (c-comment-only-line-offset . (0 . 0))
    (c-offsets-alist . ((inline-open . 0)
                        (topmost-intro-cont . +)
                        (statement-block-intro . +)
                        (knr-argdecl-intro . 5)
                        (substatement-open . +)
                        (substatement-label . +)
                        (label . +)
                        (statement-case-open . +)
                        (statement-cont . +)
                        (arglist-intro . c-lineup-arglist-intro-after-paren)
                        (arglist-close . c-lineup-arglist)
                        (access-label . 0)
                        (inher-cont . c-lineup-java-inher)
                        (func-decl-cont . c-lineup-java-throws)
                        (arglist-cont-nonempty . ++))))
    "Eclipse Java Programming Style")

(c-add-style "eclipse-java-style" eclipse-java-style)
(add-to-list 'c-default-style '(java-mode . "eclipse-java-style"))

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 4
                                  tab-width 4
                                  indent-tabs-mode nil)
                            (setq c-comment-start-regexp "(@|/(/|[*][*]?))")
                            (modify-syntax-entry ?@ "< b" java-mode-syntax-table)))
                         

(provide 'setup-c-modes)
