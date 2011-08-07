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
;; 这个使用(define nil '())可以解决，难道sicp就是这样做的?
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
;;   1 一个list的reverse等于这个list的car添加到这个list的cdr的reverse的末尾。
;;   2 空list的reverse是空list
;; 这个描述看起来很简单可行，但是为了描述这个问题，我们引入了一个新的问题。
;; 把一个元素添加到一个list的末尾这样的函数add-tail
;;
;; 那么我先有一个新的问题了，描述add-tail。描述这个之前，我们先来看看list
;; 的结构。
;; 1 list是有cons的嵌套组成的，car指向当前节点的值，cdr指向这个节点的下一个节点。
;;   所以这是一个单向的链表，指提供了car和cdr这两个操作来放问这个链表，访问只能
;;   使用这两个操作顺序的访问链表。
;; 2 list是通过cons来构造的，是从list的最后一个节点起从尾到头嵌套构造的。
;; 3 最后还有一点要注意的是list的通过cons构造的时候，最后一个节点的cdr要是nil。
;;
;; 根据上面几点，可以知道，要在list前面增加一个元素比较容易，因为list可以看做是表头
;; 节点，增加一个节点，然后把这个节点的下一节点指向原来的表头节点就行了。
(define (add-header items item)
  (cons item items))

;; 但是要在list的末尾加一个节点就没这么容易了，因为list没有记录表尾节点，所以要遍历
;; 这个表到达表尾才知道。add-tail 的描述如下
;; 1 在表items末尾增加一个item，等于在items的cdr后面加一个item，然后再这个结果的
;;   前面在加上一个items的car
;; 2 当items是空表的时候返回(list item)
(define (add-tail items item)
  (if (null? items)
    (add-header items item)
    (add-header (add-tail (cdr items) item) (car items))))

;; 记得前面我们引入了一个问题，现在这里刚好就是那个问题了。那么
(define (reverse4 items)
  (if (null? items)
    '()
    (add-tail (reverse4 (cdr items)) (car items))))

(display (reverse3 (list 1 4 9 16 25)))
(display newline)

;; 问题解决了。

;; 在做练习2.22的时候又一次发现了这个问题，
;; 使用car和cdr只能从list的第一个元素开始顺序的访问list中的元素，
;; 使用用cons只能总list的最后一个元素开始构造list。所以当你使顺序访问得到的元素
;; 使用cons嵌套构造list的时候，顺序就反过来了。这样描述应该就更清楚了，不过这里
;; 要的是反转，而2.22要的却是不反转。但是都要用到上面这个本质。
