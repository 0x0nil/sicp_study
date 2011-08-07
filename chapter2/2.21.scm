;; 练习2.21 过程square-list以一个数值表为参数，返回
;; 每个数的平方构成的表:
;; (square-list (list 1 2 3 4))
;; (1 4 9 16)

(define nil '())

(define (square-list1 items)
  (if (null? items)
    nil
    (cons ((lambda (x) (* x x)) (car items))
          (square-list (cdr items)))))

(define (map proc items)
  (if (null? items)
    nil
    (cons (proc (car items))
          (map proc (cdr items)))))

(define (square-list2 items)
  (map (lambda (x) (* x x)) items))
