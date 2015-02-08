; Author: Quasilyte

(defmacro unixts (f-name)
 `(with-open-file (f ,f-name :direction :output :if-exists :supersede)
    (sb-ext:run-program "date" '("+%s%N") :output f :search t)))

(defmacro ts-into (f-name dst)
 `(with-open-file (file ,f-name :direction :input)
    (setq ,dst (parse-integer (read-line file nil)))))

(defmacro f-into (f-name dst)
 `(with-open-file (f ,f-name)
    (let ((l (file-length f)))
      (setq ,dst (make-string l))
      (values ,dst (read-sequence ,dst f)))))

(defmacro ascii0 (str)
 `(char-code (char ,str 0)))

(defmacro w-process ()
 `(let ((l 0) (code #\0))
    (with-input-from-string (words rbuf)
      (loop for word = (read-line words nil)
        while word do
          (setq l (length word))
          (if (> l lmax) (setq lmax l)
            (if (< l lmin) (setq lmin l)))
          (setq code (ascii0 word))
          (cond ((and (>= code 97) (<= code 101))
            (setf spell (concatenate 'string spell word "_"))
            (loop for ch across word do
              (if (find ch *vowels*)
              (incf cs)))))))))

(defmacro d-conv ()
 `(let ((i -1))
    (with-input-from-string (nums rbuf)
    (loop for num = (read-line nums nil)
      while num do
        (setf (aref arr (incf i)) (parse-integer num))))))

(defmacro d-process ()
 `(let ((slice1 (make-array 250 :displaced-to arr :displaced-index-offset 0))
  (slice2 (make-array 250 :displaced-to arr :displaced-index-offset 250)))
    (loop for i from 0 to 249 do
      (setq sum (+ sum (sqrt (* (aref slice1 i) (aref slice2 i))))))))

(defvar *vowels* '(#\a #\e #\i #\o #\u))

(defun acker (a b)
  (cond ((= 0 a) (+ b 1))
    ((and a (= 0 b)) (acker (- a 1) 1))
    ((and a b) (acker (- a 1) (acker a (- b 1))))))

(defun main()
  (let ((rbuf "") (spell "") (cs 0)
  (lmax 0) (lmin 99) (sum 0.0)
  (ts1 0.0) (ts2 0.0) (arr (make-array 500)) (ackermann 0))
    (unixts "buf/ts1")
    (f-into "input/file1.txt" rbuf)
    (w-process)
    (f-into "input/file2.txt" rbuf)
    (d-conv)
    (d-process)
    (setq ackermann (acker 3 3))
    (unixts "buf/ts2")
    (ts-into "buf/ts1" ts1)
    (ts-into "buf/ts2" ts2)
    (format t "elapsed: ~f~%" (/ (- ts2 ts1) 100000))
    (format t "max length: ~d, min length ~d~%" lmax lmin)
    (format t "spell length: ~d, checksum: ~d~%" (length spell) cs)
    (format t "sum ~d~%" sum)
    (format t "ackermann: ~d~%" ackermann)))

(main)
