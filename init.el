;; 2018-01-20: Created "customized" dotemacs file.
;; Ref: https://github.com/aaronbieber/dotfiles/blob/master/configs/emacs.d/init.el
;; 2018-01-22: Found out something else, the "use-package, ensure t" forces the package to
;;             load, increasing startup time, which is NOT desired unless I know the
;;             package should ALWAYS load.  The simpler "require" does NOT do this, but
;;             instead requires one to M-x <package-name> to invoke the mode. There is
;;             also something I can code known as "lazy loading" which could alleviate this.
;; 2018-04-17: Renamed to init.el to place in directory .emacs.d. As currently using Spacemacs
;;             this likely does not matter much, but saving it anyway in case I want
;;             to go with straight "vanilla" Evil mode.


;; ====================================================================================
;; Keep this section on top.
;; ====================================================================================
;; ------------------------------------------------------------------------------------
(setq debug-on-error t)
(setq debug-on-quit t)

(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)
;; ------------------------------------------------------------------------------------
;; 2018-01-23: Ref: https://blog.aaronbieber.com/2015/05/24/from-vim-to-emacs-in-fourteen-days.html
;;             Ref: https://github.com/jwiegley/use-package
;; This package allows for several option for loading packages. The function below (I think)
;; checks to see if the package is installed and if not, installed it.
;; Next, the "eval-when-compile" loads the package and allows its use.
;; use-package has several keywords providing options:
;;    :ensure        Causes the package to install automatically if not already present.
;;                   Note this does NOT force loading, just download and compile if not already present.
;;    :requires      Normal usage, ensures package will not load if required dependencies are not loaded
;;    :no-require    Delays load for configuration in "eval-after-load" hook (used in byte-compiling)
;;    :init          Execute code before a package is loaded
;;    :config        Execute code after a package is loaded
;;    :bind          Binds a key to primary commands for the package. This also DEFERS loading the
;;                   package until you actually use the key-binding.
;;    :bind-keymap   Binds a key-map (see documentation)
;;    :defer         Defer loading a package at startup; MAKE SURE to include a (bind-key) function
;;                   to activate the load
;;    :demand        Overrides the :defer and force loading to occur immediately.
;;    :hook          Allows adding functions onto hooks (whatever that means)
;;    :custom        Allows customization of package custom variables
;;    :load-path     Add a directory to the load-path


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; ====================================================================================
;; Keep this section on top.
;; ====================================================================================

;; ------------------------------------------------------------------------------------
;; 2018-01-24: starting to declutter .emacs file by putting each package's config into
;;             its own file in directory "config-lisp".
;; 2018-01-27: Revising all the config files to use the "use-package" forms as described above.
;; ------------------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/config-lisp/")
(load "ace-window-config.el")
;; (load "all-the-icons-dired-config.el")
(load "autopair-config.el")
(load "bind-key-config.el")

;; evil-leader must be loaded BEFORE evil so the binds have effect in all buffers.
(load "evil-leader-config.el")
(load "evil-config.el")
(load "evil-args-config.el")
;; No need for evil-escape load unless that all-comments file changes.
;; (load "evil-escape-config.el")
(load "evil-exchange-config.el")
(load "evil-extra-operator-config.el")
(load "evil-mc-config.el")
(load "evil-mc-extras-config.el")
(load "evil-numbers-config.el")
(load "evil-quickscope-config.el")
(load "evil-surround-config.el")
(load "evil-visualstar-config.el")
(load "goto-chg-config.el")
(load "neotree-config.el")
(load "undo-tree-config.el")
(load "yasnippet-config.el")

;; 20180120: For later
;; (add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

;; ------------------------------------------------------------------------------------
;; Essential settings.
(setq inhibit-splash-screen nil
      inhibit-startup-message nil
      inhibit-startup-echo-area-message t)
;; (menu-bar-mode -1)
;; (tool-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(show-paren-mode 1)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indicate-empty-lines t)
(setq-default indent-tabs-mode nil)

(setq visible-bell t)
(setq vc-follow-symlinks t)
(setq large-file-warning-threshold nil)
(setq split-width-threshold nil)
(setq custom-safe-themes t)
(column-number-mode t)
(setq tab-width 4)
(setq tramp-default-method "ssh")

;; ------------------------------------------------------------------------------------
(defun air--delete-trailing-whitespace-in-proc-and-org-files ()
  "Delete trailing whitespace if the buffer is in `prog-' or `org-mode'."
  (if (or (derived-mode-p 'prog-mode)
          (derived-mode-p 'org-mode))
      (delete-trailing-whitespace)))
(add-to-list 'write-file-functions 'air--delete-trailing-whitespace-in-proc-and-org-files)

;; ------------------------------------------------------------------------------------
(defvar backup-dir "~/.emacs.d/backups/")
(setq backup-directory-alist (list (cons "." backup-dir)))
(setq make-backup-files nil)

;; ------------------------------------------------------------------------------------
;;;; Org Mode Configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; (require 'init-org)

;; ------------------------------------------------------------------------------------
(add-to-list 'load-path (expand-file-name "periodic-commit-minor-mode" user-emacs-directory))
;;; Required by init-maps, so it appears up here.
(use-package tiny-menu
  :ensure t
  :commands (tiny-menu-run-item)
  :config
  (setq tiny-menu-items
        '(("reverts"      ("Revert"
                           ((?r "This buffer"     revert-buffer)
                            (?o "All Org buffers" org-revert-all-org-buffers))))
          ("org-things"   ("Org Things"
                           ((?t "Tag"       air-org-display-any-tag)
                            (?i "ID"        air-org-goto-custom-id)
                            (?k "Keyword"   org-search-view)
                            (?h "Headings"  helm-org-agenda-files-headings)
                            (?d "Directs"   air-org-display-directs)
                            (?m "Managers"  air-org-display-managers)
                            (?e "Engineers" air-org-display-engineers))))
          ("org-agendas"  ("Org Agenda Views"
                           ((?a "All"         air-pop-to-org-agenda-default)
                            (?r "Review"      air-pop-to-org-agenda-review)
                            (?h "Home"        air-pop-to-org-agenda-home)
                            )))
          ("org-links"    ("Org Links"
                           ((?c "Capture"      org-store-link)
                            (?l "Insert first" air-org-insert-first-link)
                            (?L "Insert any"   org-insert-link)
                            (?i "Custom ID"    air-org-insert-custom-id-link))))
          ("org-files"    ("Org Files"
                           ((?t "TODO"     (lambda () (air-pop-to-org-todo nil)))
                            (?n "Notes"    (lambda () (interactive) (air-pop-to-org-notes nil)))
                            (?v "Vault" (lambda () (interactive) (air-pop-to-org-vault nil))))))
          ("org-captures" ("Org Captures"
                           ((?c "Task/idea" air-org-task-capture)
                            (?t "Tickler"   air-org-tickler-capture)
                            (?n "Note"      (lambda () (interactive) (org-capture nil "n"))))))
          ("org-personal-captures" ("Org Personal Captures"
                                    ((?c "Task/idea" (lambda () (interactive (org-capture nil "h"))))
                                     (?n "Note" (lambda () (interactive (org-capture nil "o")))))))

          )))

;;; Larger package-specific configurations.
;; (require 'init-fonts)
;; (require 'init-gtags)
;; (require 'init-evil)
;; (require 'init-twitter)
;; (require 'init-maps)
;; (require 'init-w3m)
;; (require 'init-php)
;; (require 'init-flycheck)

;; ------------------------------------------------------------------------------------
;;; Utilities
(use-package s
  :ensure t
  :defer 1)
(use-package dash :ensure t)

;; --------------
(use-package dired+
  :ensure t)

;; --------------
(use-package helm-make
  :ensure t
  :config
  (global-set-key (kbd "C-c m") 'helm-make-projectile))

;; --------------
;; 2018-01-27: Oh, heck no!  Neotree is much better!
; (use-package dired
;   :config
;   (require 'dired-x)
;   (setq dired-omit-files "^\\.?#\\|^\\.[^.].*")

;   (defun air-dired-buffer-dir-or-home ()
;     "Open dired to the current buffer's dir, or $HOME."
;     (interactive)
;     (let ((cwd (or (file-name-directory (or (buffer-file-name) ""))
;                    (expand-file-name "~"))))
;       (dired cwd)))

;   (add-hook 'dired-mode-hook (lambda ()
;                                (dired-omit-mode t)
;                                ;; (all-the-icons-dired-mode t)))
;   (define-key dired-mode-map (kbd "RET")     'dired-find-alternate-file)
;   (define-key dired-mode-map (kbd "^")       (lambda () (interactive) (find-alternate-file "..")))
;   (define-key dired-mode-map (kbd "C-.")     'dired-omit-mode)
;   (define-key dired-mode-map (kbd "c")       'find-file)
;   (define-key dired-mode-map (kbd "/")       'counsel-grep-or-swiper)
;   (define-key dired-mode-map (kbd "?")       'evil-search-backward)
;   (define-key dired-mode-map (kbd "C-c C-c") 'dired-toggle-read-only))

;; --------------
(use-package helm
  :ensure t
  :diminish helm-mode
  :commands helm-mode
  :config
  (helm-mode 1)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-autoresize-mode t)
  (setq helm-buffer-max-length 40)
  (define-key helm-map (kbd "S-SPC") 'helm-toggle-visible-mark)
  (define-key helm-find-files-map (kbd "C-k") 'helm-find-files-up-one-level))

;; --------------
(use-package which-key
  :ensure t
  :diminish ""
  :config
  (which-key-mode t))

;; --------------
(use-package projectile
  :ensure t
  :defer 1
  :config
  (projectile-mode)
  (setq projectile-enable-caching t)
  (setq projectile-mode-line
        '(:eval
          (format " Proj[%s]"
                  (projectile-project-name)))))

;; --------------
(use-package magit
  :ensure t
  :defer t
  :config
  (setq magit-branch-arguments nil)
  (setq magit-push-always-verify nil)
  (setq magit-last-seen-setup-instructions "1.4.0")
  (magit-define-popup-switch 'magit-log-popup ?f "first parent" "--first-parent"))

;; --------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-scratch-message
   ";; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with \\[find-file] and enter the text in its buffer.

")
 '(package-selected-packages
   (quote
    (org-edna autopair emacs-neotree neo-tree dired+ which-key yasnippet helm-make visual-fill-column tiny-menu evil-indent-textobject evil-jumper use-package evil-mc-extras evil-mc evil-lion evil-goggles evil-escape evil-commentary evil-tutor projectile neotree evil-vimish-fold evil-space evil-snipe evil-visualstar evil-args evil-extra-operator evil-exchange evil-mark-replace evil-matchit evil-surround evil-magit evil-leader powerline-evil org-evil treemacs-evil evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Make sure ESC quits everything!
;; Ref: https://stackoverflow.com/questions/8483182/evil-mode-best-practice#10166400
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)


;; Color cursor based on mode
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" box))
(setq evil-replace-state-cursor '("red" box))
(setq evil-operator-state-cursor '("red" hollow))
