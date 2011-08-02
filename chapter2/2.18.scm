;; 请定义出过程reverse，它以一个表为参数，返回的表中所包含的
;; 元素与参数表相同，但排列顺序与参数相反:
;; (reverse (list 1 4 9 16 25))
;; (25 16 9 4 1)

;; 1
;;(define (reverse items)
;;  (if (null? items)
;;    nil
;;    (cons (reverse (cdr items)) (car items))))

;; 2
(define (reverse2 items)
  (if (null? (cdr items))
    (car items)
    (cons (reverse2 (cdr items)) (car items))))

;; 3
(define (reverse3 items)
  (define (iter old new)
    (if (null? old)
      new
      (iter (cdr old) (cons (car old) new))))
  (iter items '()))

;; test

(define newline "\n")
(display newline)
(display (reverse2 (list 1 4 9 16 25)))
(display newline)
(display (reverse3 (list 1 4 9 16 25)))
(display newline)

;; 不知道方法1 为什么不行提示是：;Unbound variable: nil
;; 但是sicp中的例子用的是nil，疑惑
;; 方法2的结果也是怪怪的： ((((25 . 16) . 9) . 4) . 1)
;; 并不是想要的(25 16 9 4 1).
;; why?
;; 
;; 3 是这是个迭代版，之前把3些错了，是因为些了类型这个样错误
;; (cons (1 2)) 这样的错误，在cons后面放了个括号，和c的语言
;; 搞晕了，但是脑袋里没有像写这个的，难道是手写习惯了，手自己去写的？
;; :-(
;;
;; 2 的错误现在知道了，只要是因为 (list 1 2 3) 是等于
;; (cons 1 (cons 2 (cons 3 '()))) 的，而不是等于
;; (cons (cons (cons 1 2) 3) 4) 的。
;; list 指的是这样的一个序列，这个序列只能通过car获得的一个元素，而不能
;; 通过cdr来获得它的一个元素。（最后一个元素有点特别）。
;; 
;; 也就是说car得到的是它的一个元素，cdr等到的是他的下一个剩下的所有元素。
;; 其实就是一个链表，car指向当前节点的所带的元素，cdr指向下一下节点。
;; 也可以这样说car得到的是这个节点上的指，cdr得到的是下一个节点指针，
;; 要等到下一个节点的只还要调用一次对下一个节点调用一次car。
;; 
;; 要使用递归的方式解这题，主要是要找到这个问题的递归描述。
