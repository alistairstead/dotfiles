;;; Config Layer

(setq config-packages
      '(
        ;; Core
        evil

        ;; Org
        ob-async

        ;; Navigation
        avy
        outshine
        projectile
        neotree

        ;; Misc
        ispell
        magithub
        olivetti
        yasnippet

        ;; Large config sections
        (org-config :location local)
        ))

;;; Core
;;;; Evil

(defun config/post-init-evil ()
  (setq evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.1))

;;; Org-config

(defun config/init-org-config ()
  (use-package org-config
    :after org))

(defun config/init-ob-async ()
  (use-package ob-async
    :after org
    :config
    (add-to-list 'org-ctrl-c-ctrl-c-hook
                 'ob-async-org-babel-execute-src-block)))

;;; Navigation
;;;; Avy

(defun config/post-init-avy ()
  (setq avy-timeout-seconds 0.35))
  ;; (evil-global-set-key 'normal (kbd "s") 'avy-goto-char-timer)
  ;; (global-set-key (kbd "C-h") 'avy-pop-mark)
  ;; (global-set-key (kbd "C-l") 'evil-avy-goto-line))

;;;; Outshine

(defun config/init-outshine ()
  (use-package outshine
    :init
    (progn
      (spacemacs/set-leader-keys
        "nn" 'outshine-narrow-to-subtree
        "nw" 'widen)

      (let ((kmap outline-minor-mode-map))
        (define-key kmap (kbd "M-RET") 'outshine-insert-heading)
        (define-key kmap (kbd "<backtab>") 'outshine-cycle-buffer)))

    :config
    (progn
      ;; Narrowing works within the headline rather than requiring to be on it
      (advice-add 'outshine-narrow-to-subtree :before
                  (lambda (&rest args) (unless (outline-on-heading-p t)
                                    (outline-previous-visible-heading 1))))

      (add-hook 'outline-minor-mode-hook 'outshine-hook-function)
      (add-hook 'prog-mode-hook 'outline-minor-mode))))

;;;; NeoTree

(defun config/post-init-neotree ()
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (setq neo-smart-open t)

  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  )
  ;; (setq neo-vc-integration 'face))

;;;; Projectile

(defun config/post-init-projectile ()
  (setq projectile-enable-caching t))

;;; Misc
;;;; Ispell

(defun config/post-init-ispell ()
  (setq ispell-program-name "aspell"))

;;;; Magithub

(defun config/init-magithub ()
  (use-package magithub
    :after magit
    :ensure t
    :config (magithub-feature-autoinject t)))

;;;; Olivetti

(defun config/init-olivetti ()
  ;; Binding "SPC w o" is set in init.el, possible spacemacs bug with
  ;; spacemacs-base/frame.el binding overwriting setting the binding here.
  ;; The binding is only overwritten on my linux box.
  (use-package olivetti
    :config
    (advice-add 'spacemacs/toggle-maximize-buffer :after 'olivetti-end)))

;;;; Yasnippet

(defun config/pre-init-yasnippet ()
  (global-set-key (kbd "C-SPC") 'hippie-expand))
