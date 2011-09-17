;; 练习3.12 下面是2.2.1节介绍过的拼接表的过程

(define (append x y)
  (if (null? x)
    y
    (cons (car x) (append (cdr x) y))))

;; append通过顺序将x的元素cons到y上的方式构造出一个新的表。过程append！与
;; append类似，但它是一个改变函数而不是一个构造函数。它将表拼接起来的方式
;; 是将两个表粘起来，修改x的最后一个序对，使它的cdr现在变成y（对空的x调用
;; append！将是一个错误）

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

;; 这里的last-pair是一个过程，它返回其参数中的最后一个序对：

(define (last-pair x)
  (if (null? (cdr x))
    x
    (last-pair (cdr x))))

;; 考虑下面的交互

(define x (list 'a 'b))
(define y (list 'c 'd))

(define z (append x y))
;; z
;; (a b c d)
(cdr x)
;; <response>

(define w (append! x y))
;; w
;; (a b c d)
(cdr x)
;; <response>

;; 其中缺少的那两个<response>是什么？请画出盒子指针图，解释你的回答。

;; 解：
;; 分别为(b)和(b c d)。因为是用append!改变了x结构。
