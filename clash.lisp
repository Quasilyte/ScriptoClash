; Author: Quasilyte

(ext:run-shell-command "date +%s%N > buf/ts1 2>&1")

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
(setf (aref *map* 0) (fread "input/file1.txt" 150 #'str))
(setf (aref *map* 1) (fread "input/file2.txt" 500 #'int))

(defvar *spell* "")
(defvar *cs* 0)

(defvar maxLen 0)
(defvar minLen 255)

(loop for i from 0 to 149 do
  (setq len (length (aref (words) i)))
  (if (> len maxLen) (setf maxLen len)
    (if (< len minLen) (setf minLen len)))
  ; Сборка "заклинания".
  (setq ch (ascii0 (aref (words) i)))
  (cond ((and (>= ch 97) (<= ch 101))
    (setf *spell* (concatenate 'string *spell* (aref (words) i) "_"))
    (loop for c across (aref (words) i) do
      (if (or (char= #\a c) (char= #\e c) (char= #\i c) (char= #\o c) (char= #\u c))
        (incf *cs*))))))

(defvar *sum* 0.0)
(defvar bound (/ (length (nums)) 2))
(defvar slice1(make-array bound :displaced-to (nums) :displaced-index-offset 0))
(defvar slice2(make-array bound :displaced-to (nums) :displaced-index-offset 250))

; Действия над массивами (слайсами) чисел.
(loop for i from 0 to (decf bound) do
  (setf (aref slice1 i) (sqrt (* (aref slice1 i) (aref slice2 i))))
  (setf *sum* (+ *sum* (aref slice1 i)))
)

(defun acker (a b)
  (cond ((= 0 a) (+ b 1))
    ((and a (= 0 b)) (acker (- a 1) 1))
    ((and a b) (acker (- a 1) (acker a (- b 1))))))

(defvar *ackermann* (acker 3 3))

(ext:run-shell-command "date +%s%N > buf/ts2 2>&1")

(defvar *ts1* 0)
(defvar *ts2* 0)
(with-open-file (file "buf/ts1" :direction :input)
  (setf *ts1* (parse-integer (read-line file nil))))
(with-open-file (file "buf/ts2" :direction :input)
  (setf *ts2* (parse-integer (read-line file nil))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(format t "elapsed: ~f~%" (/ (- *ts2* *ts1*) 100000))
(format t "max length: ~d, min length ~d~%" maxLen minLen)
(format t "spell length: ~d, checksum: ~d~%" (length *spell*) *cs*)
(format t "sum ~d~%" *sum*)
(format t "ackermann: ~d~%" *ackermann*)
