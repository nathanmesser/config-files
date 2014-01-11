(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (add-to-list 'package-archives
;;            '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(clojure-mode haskell-mode nrepl puppet-mode less-css-mode json javadoc-help javap-mode jenkins-watch js2-mode ghc gitty gitconfig-mode cljsbuild-mode clojurescript-mode auto-complete ac-nrepl hippie-expand-haskell ess nrepl-ritz rainbow-delimiters)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; HANDLE ac-nrepl nrepl-interaction-mode problem
(setq nrepl-connected-hook (reverse nrepl-connected-hook))
(setq nrepl-hide-special-buffers t)
(setq nrepl-popup-stacktraces-in-repl t)
(setq nrepl-history-file "~/.emacs.d/nrepl-history")

 (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
 (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
 (eval-after-load "auto-complete"
   '(add-to-list 'ac-modes 'nrepl-mode))
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)

;; Some default eldoc facilities
(add-hook 'nrepl-connected-hook
(defun pnh-clojure-mode-eldoc-hook ()
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(nrepl-enable-on-existing-clojure-buffers)))
 
;; Repl mode hook
(add-hook 'nrepl-mode-hook 'subword-mode)
 
;;(define-key nrepl-interaction-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
;;(define-key nrepl-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
;;(define-key nrepl-interaction-mode-map (kbd "C-c C-a") 'nrepl-apropos)
;;(define-key nrepl-mode-map (kbd "C-c C-a") 'nrepl-apropos)

(load-file "/home/nathan/devtools/nrepl-inspect/nrepl-inspect.el")
(define-key nrepl-mode-map (kbd "C-c C-i") 'nrepl-inspect)

;; FROM CLOJURE SETUP RECOMMENDATIONS
;(setq-default inhibit-startup-screen t)

;; Of course, don't uncomment the line below -- doing so would
;; stop Emacs from helpfully leaving "foo~" (backup) files all
;; over the place.
;(setq make-backup-files nil)

;; Use only spaces (no tabs at all).
(setq-default indent-tabs-mode nil)

;; Always show column numbers.
(setq-default column-number-mode t)

;; Display full pathname for files.
(add-hook 'find-file-hooks
          '(lambda ()
             (setq mode-line-buffer-identification 'buffer-file-truename)))

;; For easy window scrolling up and down.
;(global-set-key "\M-n" 'scroll-up-line)
;(global-set-key "\M-p" 'scroll-down-line)

;; For easier regex search/replace.
(defalias 'qrr 'query-replace-regexp)

;; My own preference. Change or comment out the following lines if you like.
(load-theme 'deeper-blue t)
;(set-background-color "#383838")

;; END FROM CLOJURE SETUP RECOMMENDATIONS

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(save-place t nil (saveplace))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; HASKELL SETUP
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

   ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
   (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
   ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(add-hook 'haskell-mode-hook
          '(lambda ()
          (define-key haskell-mode-map (kbd "C-c l") 'inferior-haskell-load-file)))

;; ESS setup
(require 'ess-site)

;; MY KEY BINDINGS
(global-set-key (kbd "C-c d") 'kill-line)
(global-set-key (kbd "C-SPC") 'hippie-expand)

;; to setup tabs
(setq c-basic-indent 2)
(setq tab-width 4)
(setq indent-tabs-mode nil)
