;; 练习3.14 下面的过程相当有用，但也有些费解：

(define (mystery x)
  (define (loop x y)
    (if (null? x)
      y
      (let ((temp (cdr x)))
        (set-cdr! x y)
        (loop temp x))))
  (loop x '()))

;; loop里用一个“临时”变量temp保存x的cdr原来的值，因为下一行里面的set-cdr!将
;; 破坏这个cdr。请一般性的解释mystery做了些什么。假定v通过
;; (define v (list 'a 'b 'c))定义，请画出v约束的表对应的盒子指针图形。假定现在
;; 求值(define w (mystery v))请画出求值这个表达式之后结构v和w的盒子指针图形。
;; v和w打印出来的是什么？

;; 解：
;; 这确实是有些费解，特别是loop过程。使用例子演示了一下才知道它所做的东西。
;; (loop x y)所做的东西就是不停的从x表中取出第一个元素放到y表中的表头位置，
;; 直到x为空表。
;; 那么(myster x)做的就是把一个表倒转。v在(define w (mystery x))之前打印为
;; (a b c) 在(define w (mystery x))之后打印为(a)。w打印为(c b a)。
