;; 练习1.11 函数f由如下规则定义：如果n<3,那么f(n) = n;如果n>=3,
;; 那么f(n) = f(n-1) + 2f(n-2) + 3f(n-3)。请写一个递归计算过程
;; 计算f的过程。再写一个采用迭代计算过程计算f的过程


;; 解：
;; 递归计算过程

(define (f-recursion n)
  (cond ((< n 3) n)
        (else (+ (f-recursion (- n 1))
                 (* 2 (f-recursion (- n 2)))
                 (* 3 (f-recursion (- n 3)))))))

(define (f n)
  (f-iteration 0 1 2 3 n))

(define (f-iteration a b c count n)
  (cond ((< n 3) n)
        ((> count n) c)
        ((f-iteration b c (+ (* 3 a) 
                             (* 2 b) c)
                      (+ count 1) n))))
