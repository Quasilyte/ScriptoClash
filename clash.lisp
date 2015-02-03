; Author: Quasilyte

(ext:run-shell-command "date +%s%N")

; Вернуть ascii код первого символа строки str.
(defmacro ascii0 (str)
  `(char-code (char ,str 0)))

; Для упрощения обращения к 0 элементу массива *map*.
(defmacro words ()
  (aref *map* 0))

; Для упрощения обращения к 1 элементу массива *map*.
(defmacro nums ()
  (aref *map* 1))

; Callback, который ничего не делает.
(defun str (arg)
  arg)

; Callback, который берёт строку и возвращает integer.
(defun int (arg)
  (parse-integer arg))

; Считать весь файл в массив. Возвращает этот самый массив.
(defun fread(name lines callback)
  (setq arr (make-array `(,lines)))
  (setq i 0)
  (with-open-file (file name :direction :input)
    (loop for line = (read-line file nil)
          while line do
            (setf (aref arr i) (funcall callback line))
            (incf i)))
  arr)

(defvar *map* (make-array '(2)))
(setf (aref *map* 0) (fread "input/file1.txt" 69 #'str))
(setf (aref *map* 1) (fread "input/file2.txt" 70 #'int))

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

; Действия над массивами (слайсами) чисел.
(loop for i from 0 to (decf bound) do
  (setf (aref slice1 i) (sqrt (* (aref slice1 i) (aref slice2 i))))
  (setf sum (+ sum (aref slice1 i)))
)

; 0.010
(ext:run-shell-command "date +%s%N")
