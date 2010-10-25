;; 练习1.5 Ben Bitdidlle发明了一种检测方法，能够确定解释器究竟采用哪种序求值，
;; 是采用应用序，还是采用正则序。他定义了下面连个过程：

(define (p) (p))

(define (test x y)
  (if (= x 0)
    0
    y))
;; 而后他求值下面的表达式：
(test 0 (p))

;; 如果某个解释器采用的是应用序求值，Ben会看到什么样的情况？ 如果解释器采用
;; 正则序求值他有会看到什么情况？请对你的回答做出解释。（无论采用正则序或者
;; 应用序，假定特殊形式if的求值规则总是一样的。其中的谓词部分先行求值，根据
;; 其结果确定随后求值的子表达式部分。)

;; 解：这要看对正则序和应用序的定义，在书中找到，“完全展开而后规约的求值
;; 模型为正则序求值”，“先求值参数而后应用的方式为应用求值模型”。
;; 按照这样说，正则序应该不能给出结果，因为展开p的时候会变为无限展开，而应该
;; 序则不会，所以，正则序会出现死循环，而应用序能得到结果0
