;; 请定义出过程reverse，它以一个表为参数，返回的表中所包含的
;; 元素与参数表相同，但排列顺序与参数相反:
;; (reverse (list 1 4 9 16 25))
;; (25 16 9 4 1)

;; 1
;;(define (reverse items)
;;  (if (null? items)
;;    nil
;;    (cons (reverse (cdr items)) (car items))))

;; 2
;;(define (reverse items)
;;  (if (null? (cdr items))
;;    (car items)
;;    (cons (reverse (cdr items)) (car items))))

;; 3
(define (reverse items)
  (define (iter old new)
    (if (null? old)
      new
      (iter (cdr old) cons((car old) new))))
  (iter items '()))

;; test

(reverse (list 1 4 9 16 25))

;; 不知道方法1 为什么不行提示是：;Unbound variable: nil
;; 但是sicp中的例子用的是nil，疑惑
;; 方法2的结果也是怪怪的： ((((25 . 16) . 9) . 4) . 1)
;; 并不是想要的(25 16 9 4 1).
;; why?
