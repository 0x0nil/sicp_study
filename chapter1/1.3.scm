;; 练习1.3 定义一个过程，它以三个数为参数，返回其中较大的两个数之和。

(define (max-sum x y z)
  (cond ((and (<= x y) (<= x z)) (+ y z))
        ((and (<= y x) (<= y z)) (+ x z))
        (else (+ x y))))

(max-sum 4 7 9)
