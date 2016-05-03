; taken from http://stackoverflow.com/questions/25791605/emacs-how-do-i-create-a-new-empty-buffer-whenever-creating-a-new-frame

(defun new-empty-buffer ()
  "Create a new frame with a new empty buffer."
  (interactive)
  (switch-to-buffer (generate-new-buffer "untitled")))

(provide 'new-empty-buffer)
