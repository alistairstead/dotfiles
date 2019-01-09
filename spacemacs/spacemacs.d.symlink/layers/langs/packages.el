;;; Langs Packages


(setq langs-packages
  '(
     prettier-js
     elm-yasnippets
     elixir-yasnippets
     ))

(defun langs/init-prettier-js ()
  (use-package prettier-js
    :config
    (add-hook 'js2-mode-hook 'prettier-js-mode)
    (add-hook 'web-mode-hook 'prettier-js-mode)
    ))

(defun langs/init-elm-yasnippets ()
  (use-package elm-yasnippets))

(defun langs/init-elixir-yasnippets ()
  (use-package elixir-yasnippets))
