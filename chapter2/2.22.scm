;; 练习2.22 Louis Reasoner试图重写联系2.21的第一个square-list
;; 过程，希望使它能生成一个迭代的计算过程

(define nil '())

(define (square-list1 items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons ((lambda (x) (* x x)) (car things)) answer))))
  (iter items nil))

;; 但是很不幸，在这种方式定义出的square-list产生的结果表中，元素顺序
;; 正好与我们所需的相反，为什么?
;; Louis又试着修正其程序，交换了cons的参数：

(define (square-list2 items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons answer
                  ((lambda (x) (* x x)) (car things))))))
  (iter items nil))

;; 但是还是不行，请解释为什么？

;; 第一个方法得到的结果和我还所需的结果顺序刚好相反是因为和练习2.18
;; 中一样的原因，使用car和cdr只能从list的第一个元素开始顺序的访问
;; list中的元素，用cons只能总list的最后一个元素开始构造list。
;; 所以当你使顺序访问得到的元素使用cons嵌套构造list的时候，顺序就
;; 反过来了。
;; 第二个方法错误的原因是我在练习2.18的时候也说明过，就是使用cons
;; 构造list的时候要从list的最后一个元素开始往外嵌套cons。
;; 这是因为list的定义是，car得到的要是list的第一个元素，而cdr得到的是
;; 除去这个元素剩下的元素组成的list。就是说(cons a b)中的a要是一个元素，
;; 而b要是一个list或者是nil。而方法而刚好到过来了，所以它得到的不是一个list。
;; 而是一个序对。

;; 改成下面这样就行，要使用练习2.18中定义的把一个元素增加到list的尾部。

(define (add-header items item)
  (cons item items))

(define (add-tail items item)
  (if (null? items)
    (add-header items item)
    (add-header (add-tail (cdr items) item) (car items))))

(define (square-list3 items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (add-tail answer 
                      ((lambda (x) (* x x)) (car things))))))
  (iter items nil))

(display "\n")
(display (square-list3 (list 1 2 3 4 5)))
(display "\n")

;; 完成了.就是把一个元素加到list的末尾的问题。
