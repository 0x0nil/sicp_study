;; 练习2.17 请定义过程last-pair。它返回只包含给定（非空）表里面最后
;; 最后一个元素的表：
;; (last-pair (list 23 72 149 34))
;; (34)


(define (last-pair items)
  (if (null? (cdr items))
    (car items)
    (last-pair (cdr items))))

;; test
(last-pair (list 23 72 149 34))
(last-pair (list 66))

;; 主要就是要找的这个问题的描述
;; 找一个长度为n的表的最后一个元素，可以描述为：
;; 1 长度为n的表的最后一个元素，是除去表的第一个元素剩下的长度为n-1的表的
;; 最后一个元素
;; 2 当表的长度为1是，返回这个元素
