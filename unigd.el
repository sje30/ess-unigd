
(defun ess-unigd-start ()
  "Start a unigd device within ESS."
  (interactive)
  (with-temp-buffer
    (insert "require(httpgd)\n")
    (insert "hgd(port=5900, token=FALSE)\n")
    (ess-eval-buffer)
    (make-comint "unigd-watcher" "./check_outputs.pl")
    ;; go to latest.svg
    (find-file "latest.svg")
    (auto-revert-mode 1)
    (add-hook 'kill-buffer-hook 'clean-up-watcher 0 t)
    )
  )

(defun clean-up-watcher ()
  "Kill the watcher buffer if the svg is removed."
  (when (get-buffer "*unigd-watcher*")
    (let ((kill-buffer-query-functions nil))
      (kill-buffer (get-buffer "*unigd-watcher*")))))

;; (ess-unigd-start)

