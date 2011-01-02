;; 找函数的不同点

(define tolerance 0.00002)


(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))

(fixed-point cos 1.0)


(fixed-point (lambda (y) (+ (sin y) (cos y)))
             1.0)

;; 可以使用类似下面这种方法求平方跟，但是这一不动点的搜索不是收敛的，会重复
;; 猜测两个值，结果是进入无限循环。没完没了的猜测两个值，在答案的两边往复
;; 震荡。
;; (define (sqrt x)
;;  (fixed-point (lambda (y) (/ x y))
;;               1.0))
;; (sqrt 4)

;; 上面的问题可以使用一个在这两个猜测值之间选一个值来解决。
(define (average x y)
  (/ (+ x y) 2))
(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))

(sqrt 4)
