;; 练习1.34 假定我们定义了：
;; (define (f g) (g 2))
;; 而后就有：
;; (f square)
;; 4
;;
;; (f (lambda (z) (* z (+ z 1))))
;; 6
;;
;; 如果我们(坚持)要求解释器去求值(f f),那么会发生什么情况呢？请给出解释。

(define (f g) (g 2))

(f square)

(f (lambda (z) (* z (+ z 1))))

;; 解：
;; 我没思考会得到什么发生什么情况，而是直接到mit-scheme中试了试。
;; 结果是：The object 2 is not applicable
;; 就是说2不是一个过程。
;; 因为(g 2) 的时候g要是一个运算符。
