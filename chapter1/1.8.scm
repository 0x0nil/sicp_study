;; 练习1.8 求立方根的牛顿法基于如下事实，如果y是x的立方根的一个近似值
;; 那么下式将给出一个更好的近似值:
;; (x/(y*y) + 2*y)/3
;; 请利用这一公式实现一个类似平方根过程的求立方根的过程.(在1.3.4节里，
;; 我们将看到如何实现一般性的牛顿法，作为这些求平方根和立方根过程的
;; 抽象。)
;;
;; 解：

(define (good-enough? prev next)
  (< (abs (- prev next)) (* 0.001 next)))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) 
        (* 2 guess))
     3))

(define (cubic-root-iter prev next x)
  (if (good-enough? prev next)
    next
    (cubic-root-iter next (improve next x) x)))

(define (cubic-root x)
  (cubic-root-iter 1.1 1.0 x))

(cubic-root 8)

;; 题目中是实现一般性的牛顿法，作为这些求平方根和立方根过程的抽象，
;; 我猜想应该是把给一个更好的近似值的函数抽出来作为一个参数传递
;; 给这个一般性的牛顿法过程。
