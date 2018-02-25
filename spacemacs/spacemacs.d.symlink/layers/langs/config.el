;; Turn off js2 mode errors & warnings (we lean on eslint/standard)
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)

;; Elixir stuff
(add-to-list 'spacemacs-indent-sensitive-modes 'elixir-mode)


;; Elm stuff
(add-hook 'elm-mode-hook #'turn-off-elm-indent)

(add-to-list 'spacemacs-indent-sensitive-modes 'elm-mode)


;; PHP stuff
(setq
  php-mode-coding-style (quote psr2)
  php-template-compatibility nil
  flycheck-phpcs-standard "PSR2"
  )
