(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; el-get setup
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;; Ease of life
(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(add-hook 'before-save-hook 'whitespace-cleanup)
(setq default-directory "~/")
(setq command-line-default-directory "~/")
(el-get-bundle exec-path-from-shell
  (exec-path-from-shell-initialize))

(el-get-bundle expand-region)
(global-set-key (kbd "C-c h") 'hippie-expand)

;; Dired
(setq dired-listing-switches "-lt")
(el-get-bundle dired+)
(el-get-bundle tmtxt-async-tasks)
(el-get-bundle tmtxt-dired-async)
(define-key dired-mode-map (kbd "C-c C-r") 'tda/rsync)
(define-key dired-mode-map (kbd "C-c C-z") 'tda/zip)
(define-key dired-mode-map (kbd "C-c C-u") 'tda/unzip)
(define-key dired-mode-map (kbd "C-c C-a") 'tda/rsync-multiple-mark-file)
(define-key dired-mode-map (kbd "C-c C-e") 'tda/rsync-multiple-empty-list)
(define-key dired-mode-map (kbd "C-c C-d") 'tda/rsync-multiple-remove-item)
(define-key dired-mode-map (kbd "C-c C-v") 'tda/rsync-multiple)
(define-key dired-mode-map (kbd "C-c C-s") 'tmtxt/dired-async-get-files-size)
(define-key dired-mode-map (kbd "C-c C-q") 'tda/download-to-current-dir)
(define-key dired-mode-map (kbd "C-c C-l") 'tda/download-clipboard-link-to-current-dir)
(setq tda/download-command "wget -c -o")

;; Pangu
(el-get-bundle pangu-spacing
  (global-pangu-spacing-mode t)
  (setq pangu-spacing-real-insert-separtor t))
(setq pangu-spacing-real-insert-separtor t)

;; Backup http://stackoverflow.com/questions/151945
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; View setting
(el-get-bundle nord-emacs
  (load-theme 'nord t))
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq word-wrap t)
(setq inhibit-startup-screen t)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(setq warning-minimum-level :emergency)
(global-hl-line-mode +1)
(global-display-line-numbers-mode 1)
(column-number-mode t)
(size-indication-mode t)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
       (abbreviate-file-name (buffer-file-name))
       "%b"))))
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(set-frame-font "PT Mono 13" nil t)

;; Company-mode
(el-get-bundle company-mode
  (setq company-minimum-prefix-length 2)
  (setq company-idle-display 0.1)
  (setq company-tooltip-align-annotations t))

;; Racket
(el-get-bundle pos-tip)
(el-get-bundle racket-mode
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)
  (add-hook 'racket-mode-hook      #'company-mode)
  (add-hook 'racket-repl-mode-hook #'company-mode)
  (setq tab-always-indent 'complete))

(require 'racket-xp)
(add-hook 'racket-mode-hook #'racket-xp-mode)

(el-get-bundle paredit)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'racket-mode-hook           #'enable-paredit-mode)
(setq tab-always-indent 'complete)
(bind-keys :map paredit-mode-map
           ("{" . paredit-open-curly)
           ("}" . paredit-close-curly)
           ("M-[" . paredit-wrap-square)
           ("M-{" . paredit-wrap-curly))


(require 'eldoc)
(eldoc-add-command 'paredit-backward-delete 'paredit-close-round)

;; Markdown-mode
(el-get-bundle markdown-mode)
(setq markdown-fontify-code-blocks-natively t)

;; Magit and other git tools
(el-get-bundle '(magit git-timemachine diff-hl))
(global-diff-hl-mode t)

;; Abo-abo: ivy, swiper, counsel, ace-window
;; https://github.com/abo-abo/swiper
(el-get-bundle ace-window)
(global-set-key (kbd "M-o") 'ace-window)
(el-get-bundle swiper)
(ivy-mode t)
(setq ivy-initial-inputs-alist nil)
(setq enable-recursive-minibuffers t)
(setq ivy-use-selectable-prompt t)
(setq ivy-re-builders-alist `((t . ivy--regex-ignore-order)))
(setq ivy-use-vertual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; ESS
(el-get-bundle ESS)
