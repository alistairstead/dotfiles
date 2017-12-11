;; Eshell popup
(evil-global-set-key 'normal (kbd "C-e") 'spacemacs/shell-pop-ansi-term)
(evil-global-set-key 'insert (kbd "C-e") 'spacemacs/shell-pop-ansi-term)

;; Outline navigation
(evil-define-key '(normal visual motion) outline-minor-mode-map
  "gh" 'outline-up-heading
  "gj" 'outline-forward-same-level
  "gk" 'outline-backward-same-level
  "gl" 'outline-next-visible-heading
  "gu" 'outline-previous-visible-heading)

(evil-define-key '(normal visual) outline-minor-mode-map
  "C-h" 'evil-window-left
  "C-j" 'evil-window-down
  "C-k" 'evil-window-up
  "C-l" 'evil-window-right)

(spacemacs/set-leader-keys
  "nj" 'outline-move-subtree-down
  "nk" 'outline-move-subtree-up
  "nh" 'outline-promote
  "nl" 'outline-demote)
