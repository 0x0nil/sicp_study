;; 练习3.2 在对应用程序做软件测试时，能够统计出在计算过程中某个给定过程被
;; 调用的次数常常很有用处。请写出一个过程make-monitored,它以一个过程f作为
;; 输入，该过程本身有一个输入，make-monitored返回的结果是第三个过程，比如
;; mf，它将用一个内部计数器维持着自己被调用的次数。如果mf的输入是特殊符号
;; how-many-calls?,那么mf就返回内部计数器的值；如果输入是特殊符号
;; reset-count,那么mf就将计数器重新设置为0；对与任何其他输入，mf将返回过
;; 程应用于这一输入的结果。并将计数器加一。例如，我们可能以下面的方式
;; 做出过程sqrt的一个受监视的版本：
;; (define s (make-monitored sqrt))
;;
;; (s 100)
;; 10
;; 
;; (s 'how-many-calls?)
;; 1


(define (make-monitored-error proc)
  (let ((n 0))
    (define (how-many-calls?) n)
    (define (reset-count) (set! n 0))
    (define (mf m)
      (cond ((eq? m 'how-many-calls?) how-many-calls?)
            ((eq? m 'reset-count) reset-count)
            (else (begin (set! n (+ n 1)) (proc m)))))
    mf))

(define se (make-monitored-error sqrt))

(se 100)

(se 'how-many-calls?)
;; 这个解法在(se 'how-many-calls?)和(se 'reset-count)时会时错误的。为什么？
;; 因为我这里参照了银行账户那个例子，mf 返回的是一个函数，因为它是
;; ((acc 'withdraw) 50),所以它要返回一个函数，而现在这里是(se 100)
;; (se 'how-many-calls?)这样调用了，所以它和上面返回一个过程的话，就没有
;; 表达式对这个过程求值了。所以返回的应该是一个表达式。如下面的解

(define (make-monitored proc)
  (let ((n 0))
    (define (how-many-calls?) n)
    (define (reset-count) (set! n 0))
    (define (mf m)
      (cond ((eq? m 'how-many-calls?) (how-many-calls?))
            ((eq? m 'reset-count) (reset-count))
            (else (begin (set! n (+ n 1)) (proc m)))))
    mf))

(define s (make-monitored sqrt))

(s 100)

(s 'how-many-calls?)

