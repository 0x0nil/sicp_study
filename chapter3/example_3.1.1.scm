;; 3.1.1 小节的例子

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount)) balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknow request -- MAKE-ACCOUNT" m))))
  dispatch)

(define acc (make-account 100))

((acc 'withdraw) 50)

((acc 'deposit) 60)

;; 当给这个账户发送一个错误的请求时并没会输出"Unknow request -- MAKE-ACCOUNT"
;; 而是会产生错误。error过程的作用是什么，这里要输出这个提示的话，要怎么
;; 做呢？
