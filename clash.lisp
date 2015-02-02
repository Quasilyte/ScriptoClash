; Author: Quasilyte

; Вернуть ascii код первого символа строки str.
(defmacro ascii0 (str)
  `(char-code (char ,str 0)))

; Для упрощения обращения к 0 элементу массива *map*.
(defmacro words ()
  (aref *map* 0))

; Для упрощения обращения к 1 элементу массива *map*.
(defmacro nums ()
  (aref *map* 1))

(defun fread(name lines callback)
  (setq arr (make-array `(,lines)))
  (setq i 0)
  (with-open-file (file name :direction :input)
    (loop for line = (read-line file nil)
          while line do
            (setf (funcall callback (aref arr i)) line)
            (incf i)))
  arr)

(defvar *map* (make-array '(2)))
(setf (aref *map* 0) (fread "input/file1.txt" 69 nil))
(setf (aref *map* 1) (fread "input/file2.txt" 70 nil))

(defvar maxLen 0)
(defvar minLen 255)
(defvar *spell* "")

(loop for i from 0 to 68 do
  (setq len (length (aref (words) i)))
  (if (> len maxLen) (setf maxLen len)
    (if (< len minLen) (setf minLen len)))
  ; Сборка "заклинания".
  (setq ch (ascii0 (aref (words) i)))
  (if (and (>= ch 97) (<= ch 101))
    (setf *spell* (concatenate 'string *spell* (aref (words) i) "_"))))

(defvar sum 0)
(defvar bound (/ (length (nums)) 2))
(defvar slice1(make-array bound :displaced-to (nums) :displaced-index-offset 0))
(defvar slice2(make-array bound :displaced-to (nums) :displaced-index-offset 35))

(print slice1)
; (loop for i from 0 to (decf bound) do
;   (setf (aref slice1 i) (sqrt (* (aref slice1 i) (aref slice2 i))))
;   (setf sum (+ sum (aref slice1 i)))
; )

(print sum)
; (setq array2 (make-array 4 :displaced-to myarray :displaced-index-offset 2))
; (loop)

