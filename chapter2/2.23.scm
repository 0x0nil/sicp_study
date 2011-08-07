;; 练习2.23 过程for-each与map类似，它以一个过程和一个元素表
;; 为参数，但它并不返回结果的表，只是将这个过程从左到右应用
;; 与各元，将过程应用于元素的到的值都丢弃不用。
;; for-each通常用于那些执行了某些动作的过程，如打印等。看下面
;; 的例子：
;; (for-each (lambda (x) (newline) (display x)) (list 57 321 88))
;; 57
;; 321
;; 88
;; 由for-each的调用返回的值（上面没有显示）可以是某种任意的东西，
;; 例如逻辑值真，请给出一个for-each的实现。

(define (for-each proc items)
  (if (null? items)
    #t
    (begin (proc (car items)) (for-each proc (cdr items)))))

;; 我不知道如果在一个if的一个语句中执行两个过程，仅仅是执行这两个
;; 过程而已，他们的返回值是丢弃的。我忘记在哪里看到有begin这种用法了，
;; 而且我也不知道这种用法还有没有其他的什么意思了。现在暂时用着。
