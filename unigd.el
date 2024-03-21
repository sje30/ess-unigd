(defun ess-unigd-start ()
  "Start a unigd device within ESS."
  (interactive)
  ;; start hgd() device in *R*
  (with-temp-buffer
    (insert "require(httpgd)\n")
    (insert "hgd(port=5900, token=FALSE)\n")
    (ess-eval-buffer))
  ;; start the perl script that polls httpgd() and stores the latest plot
  ;; in latest.svg
  (make-comint "unigd-watcher" "./check_outputs.pl")
  ;; go to latest.svg, and ensure that (a) it auto-reverts and (b)
  ;; when it is killed, it also kills the comint buffer running the perl script.
  (find-file "latest.svg")
  (auto-revert-mode 1)
  (add-hook 'kill-buffer-hook 'clean-up-watcher 0 t))

(defun clean-up-watcher ()
  "Kill the comint buffer *unigd-watcher* when svg is removed."
  (when (get-buffer "*unigd-watcher*")
    (let ((kill-buffer-query-functions nil))
      (kill-buffer (get-buffer "*unigd-watcher*")))))

