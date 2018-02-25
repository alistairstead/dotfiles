;;; Config Layer

(setq config-packages
  '(
     ;; Elsewhere-owned packages with trivial config
     ispell
     projectile
     yasnippet
     neotree
     magithub
     editorconfig


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
  (global-set-key (kbd "C-SPC") 'hippie-expand))

(defun config/init-magithub ()
  (use-package magithub
    :after magit
    :ensure t
    :config (magithub-feature-autoinject t)))

(defun config/init-editorconfig ()
  (editorconfig-mode t)
  )

(defun config/post-init-neotree ()
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (setq neo-smart-open t)

  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  )


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
