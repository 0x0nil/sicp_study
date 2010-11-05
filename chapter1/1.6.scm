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
;; 应该是无限循环了，看了一下练习1.5那题对if的描述(无论采用正则序或应
;; 用序，假定特殊形式if的求值规则总是一样的，其中的谓词部分先行求值，
;; 根据其结果确定后来求值的子表达式部分.)
;; 但函数new就不是这样的了，在采用正则序的时候会先展开在求值，在采用
;; 应用序的时候会边展开边求值参数。
;; 所以在使用应用序的时候会去求值new-if的参数(sqrt_iter (improve guess x) x))
;; 而这个求值有要调用new-if，进而导致无限循环。
;; 
;; if与new-if的区别就是if可以避免对某些无法求出的值求值。
;; 
;; 按照这个思路，那么在正则序中应该不会出现问题，我还没装正则序的解释器。
;; 去装一个试试。

;;(sqrt (+ 100 37))

;;(sqrt (+ (sqrt 2) (sqrt 3)))

;;(square (sqrt 1000))
