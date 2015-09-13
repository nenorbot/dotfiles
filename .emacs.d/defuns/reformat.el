(defun reformat ()
  (interactive)
  (indent-region (point-min) (point-max)))

(provide 'reformat)
