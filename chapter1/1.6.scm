;; 练习1.6 Alyssa P.Hackerk看不出为什么要将if提供为特殊形式，
;; 她问：“为什么我不能直接通过cond将它定义为一个常规过程呢？”
;; Alyssa的朋友Eva Lu Ator断言确实可以这样做，并定义了一个if
;; 的新版本：

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
;; Eva给Alyssa演示他的程序：
(new-if (= 2 3) 0 5)
;; 5
(new-if (= 1 1) 0 5)
;; 0

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x)
               x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))

;; 当Alyssa试着用这个过程去计算平方根时会发生什么事情呢？请给出解释。
(sqrt 1)

;; 解：我试着运行了这个程序，mit-scheme输出的是：
;; ;Aborting!: maximum recursion depth exceeded

;;(sqrt (+ 100 37))

;;(sqrt (+ (sqrt 2) (sqrt 3)))

;;(square (sqrt 1000))
