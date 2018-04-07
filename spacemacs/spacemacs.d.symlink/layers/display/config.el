(add-hook 'prog-mode-hook 'rainbow-mode)


;;; spacemacs-dark

(setq
 display/spacemacs-dark-theming
 `(spacemacs-dark
   (company-tooltip-common
    :inherit company-tooltip :weight bold :underline nil)
   (company-tooltip-common-selection
    :inherit company-tooltip-selection :weight bold :underline nil)

   (font-lock-comment-face :foreground "#586e75" :italic t :weight normal)
   (avy-background-face :foreground "#586e75" :italic nil)
   (font-lock-doc-face :foreground "#2aa198" :italic t :weight normal)

   ;; Makes matching parens obvious
   (sp-show-pair-match-face :inherit sp-show-pair-match-face
                            :background "#586e75")

   ;; active modeline has no colors
   (mode-line :inherit mode-line :background "#000"
              :box nil :underline nil :overline nil)
    (mode-line-inactive :inherit mode-line :background "#000"
                       :box nil :underline nil :overline nil)
    (spaceline-highlight-face :inherit mode-line :background "#000")
    (powerline-active1 :inherit mode-line :background "#000")
    (powerline-active2 :inherit mode-line :background "#000")

   ;; Inactive modeline has tint
    (powerline-inactive2 :inherit powerline-inactive1 :background "#000")

   ;; Org and outline header updates
   (outline-1 :height 1.25
              :foreground "#C3A29E"
              :weight ,(if linux? 'normal 'ultra-bold)
              :italic nil
              :underline t)

   (outline-2 :height 1.15
              :foreground "#8D6B94"
              :weight ,(if linux? 'normal 'ultra-bold)
              :italic nil
              :underline t)

   (outline-3 :height 1.15
              :foreground "#8C5F66"
              :weight ,(if linux? 'normal 'ultra-bold)
              :italic nil
              :underline t)

   (org-level-1 :height 1.25
                :inherit nil
                :foreground "#C3A29E"
                :weight ,(if linux? 'normal 'ultra-bold)
                :italic nil
                :underline t)

   (org-level-2 :height 1.15
                :inherit nil
                :foreground "#8D6B94"
                :weight ,(if linux? 'normal 'ultra-bold)
                :italic nil
                :underline t)

   (org-level-3 :height 1.15
                :inherit nil
                :foreground "#8C5F66"
                :weight ,(if linux? 'normal 'ultra-bold)
                :italic nil)

   (org-block-begin-line :height 1.05 :foreground "#576e75"
                         :box t :weight bold)
   (org-block-end-line :height 1.05 :foreground "#576e75"
                       :box t :weight bold)))

;;; Set Theme Changes

(setq theming-modifications
  (list
    display/spacemacs-dark-theming
    ))
