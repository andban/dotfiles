;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; .emacs.d/init.el
;;
;; Main Emacs configuration file
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; make sure essential directories are present
(let* ((subdirs '("backups" "snippets" "ac-dict"))
       (fulldirs (mapcar (lambda (d) (concat user-emacs-directory d)) subdirs)))
  (dolist (dir fulldirs)
    (when (not (file-exists-p dir))
      (message "creating directory: %s" dir)
      (make-directory dir))))

; move custom emacs configurations out of this file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;;
;; initialize package manager
;;

(require 'package)

(setq required-packages '(ag
                          auto-complete
                          ac-c-headers
                          ac-etags
                          ac-js2
                          cider
                          clojure-mode
                          dash-at-point
                          diminish
                          emmet-mode
                          enh-ruby-mode
                          fill-column-indicator
                          flx-ido
                          flycheck
                          flymake-ruby
                          git-gutter
                          go-mode
                          grizzl
                          handlebars-mode
                          highlight-indentation
                          highlight-parentheses
                          ido-vertical-mode
                          jedi
                          magit
                          markdown-mode
                          multi-term
                          mustache-mode
                          paredit
                          projectile
                          python-environment
                          python-mode
                          rainbow-delimiters
                          s
                          smartparens
                          soft-charcoal-theme
                          soft-morning-theme
                          sr-speedbar
                          theme-changer
                          web-mode
                          yasnippet))

;;add melpa repository
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;add marmalade repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

;;if we have an old emacs version, add the gnu repository too
(when (< emacs-major-version 24)
  (add-to-list 'package-archives
               '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;;fetch package list if not available
(unless package-archive-contents
  (package-refresh-contents))

;;install missing packages
(dolist (package required-packages)
  (unless (package-installed-p package)
    (package-install package)))


;;
;; basics
;;

(if (equal "abannach" user-login-name)
    (setq user-mail-address "andreas.bannach@igd.fraunhofer.de")
  (setq user-mail-address "andreas@borntohula.de"))


;;skip the advertisement
(setq inhibit-startup-message t)

;;use utf-8 ...
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

;;save on compile
(setq compilation-ask-about-save nil)

;;using 'y' and 'n' instead of 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

;;setup backup directory
;;setup central backup directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;;make backups of version controled files too
(setq vc-make-backup-files t)

;;open compressed files
(auto-compression-mode t)

;;enable window navigation using Shift+<cursor key>
(windmove-default-keybindings)

;;enable external clipboard
(setq x-select-enable-clipboard t)

(require 'sr-speedbar)
(setq speedbar-show-unknown-file t)
(setq speedbar-use-images nil)
(setq sr-speedbar-right-side nil)

                                        ; delete current selection on insert
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)
(delete-selection-mode 1)

                                        ; highlight searches
(setq search-highlight t)

;; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 100)

;;movement
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)

(setq default-tab-width 2)
(set-default 'indent-tabs-mode nil)
(setq visible-bell 'top-bottom)

(require 'icomplete)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'fill-column-indicator)
(setq fci-rule-column 80)

;;
;; shell
;;
(require 'multi-term)
(setq multi-term-program "/bin/zsh")

(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))
(add-hook 'term-mode-hook (lambda ()
                            (yas-minor-mode -1)))
;;
;; appearance
;;

(setq calendar-location-name "Darmstadt, Germany") 
(setq calendar-latitude 49.52)
(setq calendar-longitude 8.38)

;;minimize ui
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;remove mode line clutter
(require 'diminish)
                                        ;(eval-after-load "smartparens" '(diminish 'smartparens-mode))
(eval-after-load "git-gutter" '(diminish 'git-gutter-mode))
(require 'theme-changer)
(change-theme 'soft-morning 'soft-charcoal)
;;(load-theme 'soft-morning)
;;(set-default-font "Menlo-13")
(set-default-font "Source Code Pro-13")

;;highlight current line
(global-hl-line-mode 1)

;; highlight paretheses
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

                                        ;(smartparens-global-mode t)

(require 'rainbow-delimiters nil)
(rainbow-delimiters-mode 1)

(require 'fill-column-indicator)

;;
;; ido
;;
(require 'flx-ido)
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-case-fold nil
      ido-auto-merge-work-directories-length -1
      ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-max-prospects 10)

(ido-everywhere 1)
(setq ido-use-faces nil)

(require 'ido-vertical-mode)
(ido-vertical-mode)
(setq ido-vertical-define-keys 'C-n-C-o-up-down-left-right)

(flx-ido-mode 1)

;;support for recent files
                                        ;(require 'recentf)
                                        ;(recentf-mode 1)


;;
;; projectile
;;
(require 'projectile)
(require 'grizzl)

(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-indexing-method 'grizzl)

;;cmd-p for find in project
(global-set-key (kbd "s-p") 'projectile-find-file)
;;cmd-b for find buffer
(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)


;;
;; VCS
;;
(require 'git-gutter)
(global-git-gutter-mode t)

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(autoload 'magit-status "magit" nil t)
(global-set-key "\C-ci" 'magit-status)

(eval-after-load 'magit-status 
  '((defun magit-quit-session ()
      "Kill the magit buffer and restores the previous window configuration"
      (interactive)
      (kill-buffer)
      (jump-to-register :magit-fullscreen))
    (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)
    
    (defun magit-toggle-whitespace ()
      (interactive)
      (if (member "-w" magit-diff-options)
          (magit-dont-ignore-whitespace)
        (magit-ignore-whitespace)))
    (defun magit-ignore-whitespace ()
      (interactive)
      (add-to-list 'magit-diff-options "-w")
      (magit-refresh))
    
    (defun magit-dont-ignore-whitespace ()
      (interactive)
      (setq magit-diff-options (remove "-w" magit-diff-options))
      (magit-refress))
    (define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace)))


;;
;; auto complete
;;
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-delay 0.5)
(setq ac-auto-start 2)
(setq ac-ignore-case nil)
(ac-flyspell-workaround)

(setq ac-etags-requires 1)
(eval-after-load "etags"
  '(progn (ac-etags-setup)))


;;
;; snippets
;;
(require 'yasnippet)
(yas/initialize)
(add-to-list 'ac-sources 'ac-sources-yasnippet)

;;
;; mac os setup
;;
(when (equal system-type 'darwin)
  (setq mac-option-modifier 'nil)
  (setq mac-command-modifier 'super)
  (setq mac-function-modifier 'meta)

  (require 'dash-at-point)
  (global-set-key "\C-cd" 'dash-at-point))

;;
;; python
;;
(require 'highlight-indentation)
                                        ;(require 'ac-python)
                                        ;(eval-after-load 'auto-complete
                                        ;  '(add-to-list 'ac-modes 'python-mode))
(setq jedi:complete-on-dot t)

(autoload 'python-mode "python-mode")
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))

()
(add-hook 'python-mode-hook 
          (lambda()
            (jedi:setup)
            (highlight-indentation-current-column-mode)))

;;
;; ruby
;;

(autoload 'enh-ruby-mode "enh-ruby-mode" "Enhanced Ruby Mode" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))

(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

(add-hook 'enh-ruby-mode-hook
          (lambda()
            (setq fci-rule-column 80)
            (fci-mode)
            (flymake-ruby-load)
            (highlight-indentation-current-column-mode)))

(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))


;;
;; javascript and web stuff
;;
(autoload 'js2-mode "js2-mode" "JavaScript Mode" t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))
(add-to-list 'magic-mode-alist '("#!/usr/bin/env node" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.bowerrc\\'" . js2-mode))

(setq ac-js2-evaluate-calls t)
(add-hook 'js2-mode-hook 'ac-js2-mode)

(autoload 'web-mode "web-mode")
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))

(defun customize-web-mode ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'customize-web-mode)

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'emmet-mode-hook (lambda (setq emmet-indentation 2)))

(setq emmet-move-cursor-between-quotes t)


;;
;; elisp
;;
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)


;;
;; c modes
;;
(require 'cc-vars)
(require 'ac-c-headers)

(autoload 'c-mode "cc-mode" "C Editing Mode" t)
(autoload 'c++-mode "cc-mode" "C++ Editing Mode" t)
(autoload 'objc-mode "cc-mode" "Objective-C Editing Mode" t)
(autoload 'java-mode "cc-mode" "Java Editing Mode" t)
(add-to-list 'auto-mode-alist '("\\.c\\'"   . c-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'"   . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))

(defconst andban-c-style
  '((c-recognize-knr-p . nil)
    (c-basic-offset . 4)
    (indent-tabs-mode . nil)
    (c-comment-only-line-offset . 0)
    (c-comment-continuation-start . "* ")
    (c-auto-newline . t)

    (c-hanging-braces-alist . ((defun-open after)
                               (defun-close before after)
                               (class-open after)
                               (class-close before after)
                               (inexpr-class-open after)
                               (inexpr-class-close before)
                               (namespace-open after)
                               (inline-open after)
                               (inline-close before after)
                               (block-open after)
                               (block-close . c-snug-do-while)
                               (extern-lang-open after)
                               (extern-lang-close after)
                               (statement-case-open after)
                               (substatement-open after)))
  
    (c-hanging-braces-alist ((defun-open after)
                             (defun-close before after)
                             (class-open after)
                             (class-close before after)
                             (inexpr-class-open after)
                             (inexpr-class-close before)
                             (namespace-open after)
                             (inline-open after)
                             (inline-close before after)
                             (block-open after)
                             (block-close . c-snug-do-while)
                             (extern-lang-open after)
                             (extern-lang-close after)
                             (statement-case-open after)
                             (substatement-open after)))
    
    (c-hanging-colons-alist . ((case-label)
                               (label after)
                               (access-label after)
                               (member-init-intro before)
                               (inher-intro)))

    (c-offsets-alist . ((string . 0)
                        (innamespace . -)
                        (knr-argdecl-intro . 0)
                        (inline-open . 0)
                        (access-label . -)
                        (case-label . +)
                        (block-open . 0)
                        (substatement-open . 0)
                        (statement-case-open . 0)
                        (statement-case-intro . +)
                        (arglist-close . c-lineup-close-paren)
                        (inextern-lang . 0))))
  "Andban C Style")

(defun apply-andban-c-style ()
  "setup custom c(++) style"
  (interactive)
  (make-local-variable 'tab-always-indent)
  (setq c-tab-always-indent t)
  (c-add-style "andban" andban-c-style))

(defun make-newline-indent ()
  (interactive)
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-base-map [ret]  'newline-and-indent))

;(add-hook 'c-mode-common-hook 'apply-andban-c-style)
(setq c-default-style "linux"
      c-basic-offset 2)
(add-hook 'c-mode-common-hook 'make-newline-indent)


;(add-hook 'c-mode-hook
;          (lambda ()
;            (add-to-list 'ac-sources 'ac-source-c-headers)
;            (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))
