;; 练习3.7 考虑如练习3.3所描述的，由make-account创建的带有密码的银行账户对象。
;; 假定我们的银行系统中需要一种提供公用账户的能力。请定义过程make-joint创建
;; 这种账户。make-joint应该有3个参数：第一个参数是有密码保护的账户；第二个
;; 参数是一个密码，它必须与那个已经定义的账户的密码匹配，已使make-joint操作
;; 能够继续下去；第三个参数是新的密码。make-joint用这一个新的密码创建起对原有
;; 账户的另一个访问途径。例如，如果peter-acc是一个具有密码open-sesame的银行
;; 账户，那么
;; (define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
;; 将使我们可以通过名字paul-acc和密码resebud对账户peter-acc做现金交易。你可能
;; 希望修改自己对练习3.3的解，加入这一个新功能。

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

(define (make-joint acc password new-password)
  (define (incorrect-password amount)
    "Incorrect password")
  (define (password-dispatch p m)
    (if (eq? new-password p)
      (acc password m)
      incorrect-password))
  password-dispatch)

(define peter-acc (make-account 100 'open-sesame))

((peter-acc 'open-sesame 'withdraw) 40)

(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))

((paul-acc 'rosebud 'withdraw) 40)
