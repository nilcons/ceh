(unless (file-exists-p "/nix/var/nix/profiles/ceh/emacs/installed_derivations/2jb7sld8n90swcss5cdlpbvrs0h42s8i-ProofGeneral-4.1")
  (shell-command "/opt/ceh/bin/ceh_nixpkgs_install_for_emacs emacs24Packages.proofgeneral 1.0pre23543_5ebaaeb yiin85prawm9imwfnpk9carh0lwahw6c-ProofGeneral-4.1.drv 2jb7sld8n90swcss5cdlpbvrs0h42s8i-ProofGeneral-4.1"))
(load "/nix/store/2jb7sld8n90swcss5cdlpbvrs0h42s8i-ProofGeneral-4.1/share/emacs/site-lisp/site-start.d/pg-init.el")
(add-hook 'coq-mode-hook
          (lambda ()
            (define-key coq-mode-map (kbd "<C-S-down>") 'proof-assert-next-command-interactive)
            (define-key coq-mode-map (kbd "<C-S-up>") 'proof-undo-last-successful-command)
            (define-key coq-mode-map (kbd "<C-S-right>") 'proof-goto-point)
            ))
