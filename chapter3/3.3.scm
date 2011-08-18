;; 练习3.3 请修改make-account过程，使它能创建一种带密码保护的账户。也就是说，
;; 应该让make-account以一个符号作为附加的参数，就像：
;; (define acc (make-account 100 'secret-password))
;; 这样产生的账户对象在接到一个请求时，只有同时提供了账户创建时给定的密码，
;; 它才能处理这一请求，否则就发一条抱怨信息：
;; ((acc 'secret-password 'withdraw) 40)
;; 60
;;
;; ((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"

(define (make-account balance password)
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
          (else (error "Unknow request -- MAKE-ACCOUNT"
                       m))))
  (define (password-dispatch p m)
    (if (eq? password p)
      (dispatch m)
      (error "Incorrect password")))
  password-dispatch)

(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)

;; ((acc 'some-other-password 'deposit) 50)

;; 不知道书中的例子中的error过程有什么作用，这里当输入不正确的密码或者请求时
;; 会出错而不是输出错误消息。
;; 这里的问题是，(acc 'some-other-password 'deposit) 返回的是一个函数，
;; 这个函数要是一个接受一个参数的函数，在这个函数里面要输出错误信息。改一下
;; 得到下面这样的。

(define (make-account balance password)
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
          (else (error "Unknow request -- MAKE-ACCOUNT"
                       m))))
  (define (incorrect-password amount)
    "Incorrect password")
  (define (password-dispatch p m)
    (if (eq? password p)
      (dispatch m)
      incorrect-password))
  password-dispatch)

(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)

((acc 'some-other-password 'deposit) 50)

;; 这样就可以在输入错误的密码的时候就可以和余额不足一样提示了。
