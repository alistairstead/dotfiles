;;; Langs Packages

(setq langs-packages
  '(js-mode
   add-node-modules-path
   ))

(defun langs/init-add-node-modules-path ()
  (use-package add-node-modules-path :ensure )
  )

(defun langs/post-init-add-node-modules-path ()
  (with-eval-after-load 'js-mode
    '(add-hook 'js-mode-hook #'add-node-modules-path))
  )
