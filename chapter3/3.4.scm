;; 练习3.4 请修改练习3.3中的make-account过程，加上另一个局部状态变量，使得
;; 如果一个账户被用不正确的密码连续访问了7次，它将调用过程call-the-cops
;; （叫警察）。

(define (make-account balance password)
  (let ((incorrect-password-count 7))
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
    (define (call-the-cops) "call-the-cops")
    (define (incorrect-password amount)
      (set! incorrect-password-count (- incorrect-password-count 1))
      (if (<= incorrect-password-count 0)
        (call-the-cops)
        "Incorrect password"))
    (define (password-dispatch p m)
      (if (eq? password p)
        (dispatch m)
        incorrect-password))
    password-dispatch))

(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)

(define (test proc m n)
  (if (= n 0)
    #t
    (begin (display "\n") (display (proc m)) (test proc m (- n 1)))))

(test (acc 'some-other-password 'deposit) 40 7)

;; 不知道let的写法为什么要(let ((name value)) (body))这样写，((name value))。
;; 这里写了个test，写得好像很别扭，不知道更好的写法要怎么写。
