;;; Config Layer

(setq config-packages
  '(
     ;; Elsewhere-owned packages with trivial config
     ispell
     projectile
     yasnippet
     magit
     magithub
     editorconfig
     neotree

     ;; Elsehwere-owned packages
     (avy-config      :location local)
     (eshell-config   :location local)
     (evil-config     :location local)
     (ivy-config      :location local)
     (org-config      :location local)
     ))


;;; Minor Config

(defun config/post-init-ispell ()
  (setq ispell-program-name
    "aspell"))

(defun config/post-init-projectile ()
  (setq projectile-enable-caching
    t)
  (setq projectile-indexing-method
    'native))

(defun config/pre-init-yasnippet ()
  (spacemacs|use-package-add-hook yasnippet
    :post-init
    (global-set-key (kbd "C-SPC") 'hippie-expand)
    ))

(defun config/pre-init-magit ()
  (spacemacs|use-package-add-hook magit
    :post-init
    (setq magit-repository-directories '("~/src/"))
    ))


(defun config/init-magithub ()
  (use-package magithub
    :after magit
    :ensure t
    :config (magithub-feature-autoinject t)))

(defun config/init-editorconfig ()
  (use-package editorconfig
    :config
    (editorconfig-mode t)
    ))

(defun config/pre-init-neotree()
  (spacemacs|use-package-add-hook neotree
    :post-init
    (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
    (setq projectile-switch-project-action 'neotree-projectile-action)
    (setq neo-smart-open t)

    (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
    (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
    (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
    (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
    ))


;;; Local Config

(defun config/init-avy-config ()
  (use-package avy-config
    :after avy macros))

(defun config/init-eshell-config ()
  (use-package eshell-config
    :after evil macros))

(defun config/init-evil-config ()
  (use-package evil-config
    :after evil macros))

(defun config/init-gnus-config ()
  (use-package gnus-config
    :after gnus))

(defun config/init-ivy-config ()
  (use-package ivy-config
    :after ivy macros))

(defun config/init-org-config ()
  (use-package org-config
    :after org macros))
