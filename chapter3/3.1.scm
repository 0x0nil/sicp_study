;; 练习3.1 一个累加器是一个过程，反复用数值参数去调用它，就会使它的各个参数
;; 累加到一个和数中。每次调用时累加器将返回当前的累加和。请写出一个生成累加
;; 器的过程make-accumulator，它所生成的没个累加器维持着一个独立的和。送给
;; make-accumulator的输入描述了有关和数的初始值，例如：
;; (define A (make-accumulator 5))
;;
;; (A 10)
;; 15
;;
;; (A 10)
;; 25

(define (make-accumulator n)
  (lambda (x) (begin (set! n (+ n x)) n)))

(define A (make-accumulator 5))
(A 10)
