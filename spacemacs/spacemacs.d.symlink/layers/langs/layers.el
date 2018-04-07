(configuration-layer/declare-layers
  '(
     ;; Personal layers
     macros
     ;; Spacemacs layers
     emacs-lisp
     elixir
     python
     (elm :variables
       elm-format-command "elm-format"
       elm-format-on-save t
       elm-sort-imports-on-save t
       )
     erlang
     ( html :packages
       ( not pug-mode slim-mode )
       )
     ( javascript :variables
       node-add-modules-path t )
     markdown
     php
     react
     ruby
     ruby-on-rails
     rust
     ( shell-scripts :packages
       ( not fish-mode ) )
     terraform
     yaml
     ))
