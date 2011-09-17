;; 练习3.13 考虑下面的make-cycle过程，其中使用了练习3.12定义的last-pair过程：

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
;; 画出盒子指针图形，说明下面表达式创建起的z的结构：
(define z (make-cycle (list 'a 'b 'c)))

;; 如果我们试着去计算(last-pair z),那会是什么情况？

;; 解：
;; 创建起的z是一个环的结构。我们试着计算(last-pair z)的话，就是死循环。
