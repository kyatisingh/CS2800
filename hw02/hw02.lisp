; **************** BEGIN INITIALIZATION FOR ACL2s B MODE ****************** ;
; (Nothing to see here!  Your actual file is after this initialization code);

#|
Pete Manolios
Fri Jan 27 09:39:00 EST 2012
----------------------------

Made changes for spring 2012.


Pete Manolios
Thu Jan 27 18:53:33 EST 2011
----------------------------

The Beginner level is the next level after Bare Bones level.

|#

; Put CCG book first in order, since it seems this results in faster loading of this mode.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading the CCG book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "ccg/ccg" :uncertified-okp nil :dir :acl2s-modes :ttags ((:ccg)) :load-compiled-file nil);v4.0 change

;Common base theory for all modes.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s base theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "base-theory" :dir :acl2s-modes)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s customizations book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "custom" :dir :acl2s-modes :uncertified-okp nil :ttags :all)

;Settings common to all ACL2s modes
(acl2s-common-settings)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading trace-star and evalable-ld-printing books.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "trace-star" :uncertified-okp nil :dir :acl2s-modes :ttags ((:acl2s-interaction)) :load-compiled-file nil)
(include-book "hacking/evalable-ld-printing" :uncertified-okp nil :dir :system :ttags ((:evalable-ld-printing)) :load-compiled-file nil)

;theory for beginner mode
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s beginner theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "beginner-theory" :dir :acl2s-modes :ttags :all)


#+acl2s-startup (er-progn (assign fmt-error-msg "Problem setting up ACL2s Beginner mode.") (value :invisible))
;Settings specific to ACL2s Beginner mode.
(acl2s-beginner-settings)

; why why why why 
(acl2::xdoc acl2s::defunc) ; almost 3 seconds

(cw "~@0Beginner mode loaded.~%~@1"
    #+acl2s-startup "${NoMoReSnIp}$~%" #-acl2s-startup ""
    #+acl2s-startup "${SnIpMeHeRe}$~%" #-acl2s-startup "")


(acl2::in-package "ACL2S B")

; ***************** END INITIALIZATION FOR ACL2s B MODE ******************* ;
;$ACL2s-SMode$;Beginner
#|

CS 2800 Homework 2 - Fall 2016

This homework is done in groups. The rules are:

 * ALL group members must submit the homework file (this file).
 
 * Do not rename this file.  There will be a 10 point penalty for this.

 * The file submitted must be THE SAME for all group members (we use this
   to confirm that alleged group members agree to be members of that group)

 * You must list the names of ALL group members below, using the given
   format. If you fail to follow these instructions, it costs us time and
   it will cost you points, so please read carefully.

The format should be: FirstName1 LastName1, FirstName2 LastName2, ...
For example:
Names of ALL group members: David Sprague, Jaideep Ramachandran

There will be a 10 pt penalty if your names do not follow this format.
Names of ALL group members: Laura Romero, Khyati Singh

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw02.lisp

- make sure you are in BEGINNER mode. This is essential! Note that you can
  only change the mode when the session is not running, so set the correct
  mode before starting the session.

- insert your solutions into this file where indicated (usually as "...")

- only add to the file. Do not remove or comment out anything pre-existing.

- make sure the entire file is accepted by ACL2s. In particular, there must
  be no "..." left in the code. If you don't finish all problems, comment
  the unfinished ones out. Comments should also be used for any English
  text that you may add. This file already contains many comments, so you
  can see what the syntax is.

- when done, save your file and submit it as hw02.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file.

Instructions for programming problems:

For each function definition, you must provide both contracts and a body.

You must also ALWAYS supply your own tests. This is in addition to the
tests sometimes provided. Make sure you produce sufficiently many new test
cases. This means: cover at least the possible scenarios according to the
data definitions of the involved types. For example, a function taking two
lists should have at least 4 tests: all combinations of each list being
empty and non-empty.

Beyond that, the number of tests should reflect the difficulty of the
function. For very simple ones, the above coverage of the data definition
cases may be sufficient. For complex functions with numerical output, you
want to test whether it produces the correct output on a reasonable
number of inputs.

Use good judgment. For unreasonably few test cases we will deduct points.

We will use ACL2s' check= function for tests. This is a two-argument
function that rejects two inputs that do not evaluate equal. You can think
of check= roughly as defined like this:

(defunc check= (x y)
  :input-contract (equal x y)
  :output-contract (equal (check= x y) t)
  t)

That is, check= only accepts two inputs with equal value. For such inputs, t
(or "pass") is returned. For other inputs, you get an error. If any check=
test in your file does not pass, your file will be rejected.

|#

#|

Since this is our first programming exercise, we will simplify the
interaction with ACL2s somewhat: instead of asking it to formally *prove*
the various conditions for admitting a function, we will just require that
they be *tested* on a reasonable number of inputs. This is achieved using
the following directive (do not remove it!):

|#

:program
#|

Notes:

1. Testing is cheaper but less powerful than proving. So, by turning off
proving and doing only testing, it is possible that the functions we are
defining cause runtime errors even if called on valid inputs. In the future
we will require functions complete with admission proofs, i.e. without the
above directive. For this first homework, the functions are simple enough
that there is a good chance ACL2s's testing will catch any contract or
termination errors you may have.

2. The tests ACL2s runs test only the conditions for admitting the
function. They do not test for "functional correctness", i.e. does the
function do what it is supposed to do? ACL2s has no way of telling what
your function is supposed to do. That is what your own tests are for.

|#

#|
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 Part I: Sets, subsets and lists.
 This following section deals with functions involving lists in general.
 Some functions you write may be useful in subsequent functions.
 In all cases, you can define your own helper functions if that simplifies
 your coding
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Define
; all-identp: List -> Boolean
;
; (all-identp l) returns t if all elements in l are the same and nil otherwise.
; A helper function can be used but it is not strictly necessary.

(defunc all-identp (l)
  :input-contract (listp l)
  :output-contract (booleanp (all-identp l))
  ...)
  
(check= (all-identp '(1))   t)
(check= (all-identp '(1 a)) nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define
; sublist-start: List x Nat -> List
;
; (sublist-start l size) returns the sublist of list l of length size 
; starting with the first element. If size > the length of l,  return
; the entire list.
(defunc sublist-start (l size)
  :input-contract (and (listp l)(natp size))
  :output-contract (listp (sublist-start l size))
  ...)

(check= (sublist-start '(1 2 3 4) 2) '(1 2))
(check= (sublist-start '(1 2 3 4) 0) nil)
(check= (sublist-start '(1 2 3 4) 5) '(1 2 3 4))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define
; sublist: List x Nat x Nat -> List
;
; (sublist l start end) returns the sublist of list l starting with element start
; and ending with elment end (inclusive). If start > end then return nil.
(defunc sublist (l start end)
  :input-contract (and (listp l)(natp start)(natp end))
  :output-contract (listp (sublist l start end))
  ...)

(check= (sublist '(1 2 3 4) 2 3) '(3 4))
(check= (sublist '(1 2 3 4) 2 2) '(3))
(check= (sublist nil 1 1) nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define
; max-ident-sublist: List -> Nat
;
; (max-ident-sublist l) returns the size of the largest sublist of identical
; elements (without removing or re-arranging elements in l.
; HINT: Note that if l does not just have the same element througout, you can 
; calculate max-ident-sublist on two slightly smaller sublists of l to
; find your answer. Notice the functions we've already written.
(defunc max-ident-sublist (l)
  :input-contract (listp l)
  :output-contract (natp (max-ident-sublist l))
  ...)

(check= (max-ident-sublist '(1 2 3 3 3 4)) 3)
(check= (max-ident-sublist '(a c b b c d c)) 2)
(check= (max-ident-sublist nil) 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define
; has-elementp: Any x List -> Boolean
;
; (has-elementp e l) returns true if and only if element e can be
; found as a top level element in l (in other words you don't have
; to recursively search lists within l).
(defunc has-elementp (e l)
  :input-contract (listp l)
  :output-contract (booleanp (has-elementp e l))
  ...)

(check= (has-elementp 'a '(b c a)) t)
(check= (has-elementp 'a '(b c d)) nil)
(check= (has-elementp 'a '(b c (a b c))) nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define
; remove-element: Any x List -> Boolean
;
; (remove-element e l) returns list l with the first occurance of e removed
; Unlike del or other functions we may define later, e must be in l to start.
(defunc remove-element (e l)
  :input-contract (and (listp l)(has-elementp e l))
  :output-contract (listp (remove-element e l))
  ...)

(check= (remove-element 'a '(b c a)) '(b c))
(check= (remove-element 'a '(a b c a)) '(b c a))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define
; permutationp (l1 l2)
;
; (permutationp l1 l2) returns true iff l2 is a rearrangement of l1.  
; Thus each element in l1 is also in l2 (even if there are duplicates) 
; and the reverse is also true.
; NOTE: if l1 and l2 and identical, they are still considered a permutation
; of each other
(defunc permutationp (l1 l2)
  :input-contract (and (listp l1)(listp l2))
  :output-contract (booleanp (permutationp l1 l2))
  ...)

(check= (permutationp '(1 2) '(2 1))   t)
(check= (permutationp '(1 3) '(3 1 1)) nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define
; set-intersect(l1 l2)
;
; (set-intersect l1 l2) returns a list of elements found in both lists
; l1 and l2. The intersect list can have duplicates if you want since
; we can define a set as a list where order and duplicates are ignored.
; Duplicates can also be removed if you want.
(defunc set-intersect(l1 l2)
  :input-contract (and (listp l1)(listp l2))
  :output-contract (listp (set-intersect l1 l2))
  ...)

(check= (set-intersect '(a b c d e) '(a c e g i)) '(a c e))
(check= (set-intersect '(a b c d e) nil) nil)

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Part II: Discrete Math Fun
Below are a set of functions that you might find useful later
in the term. These help you do discrete arithmetic like you 
did in CS 1800. You will also set the precision of a rational number
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define
; rem-similar: Nat x Nat-{0} -> Nat
;
; (rem-similar x y) returns the remainder of the integral division of 
; x by y assuming that x and y are relatively the same size.
; This is a helper method for (rem x y)
(defunc rem-similar (x y)
  :input-contract (and (natp x)(posp y))
  :output-contract (natp (rem-similar x y))
  ...)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define
; rem-smally: Nat x Nat-{0} -> Nat
;
; (rem-smally x y) returns the remainder of the integral division of 
; x by y assuming that y is relatively small compared to x.
; This is a helper method for (rem x y)
(defunc rem-smally (x y)
  :input-contract (and (natp x)(posp y))
  :output-contract (natp (rem-smally x y))
  ...)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rem: Nat x Nat-{0} -> Nat
;
; (rem x y) returns the remainder of the integral division of x by y.
; The labs should help with this definition, HOWEVER, note that for
; some numbers like x = 100000000 and y =11 one method is better.
; Thus we will make two definitions:
; For x and y being approximately the same size we use (rem-similar)
; since it is more efficient.
; For small values of y (and arbitrarily large x values), use rem-smally
; Fill in these function above.  If you are curious, try calling
; (rem-smally 5000000000 4999999) and (rem-similar 5000000000 3)
; and see why we need 2 approaches.
(defunc rem (x y)
  :input-contract (and (natp x)(posp y))
  :output-contract (natp (rem x y))
  (if (< y (/ x y))
    (rem-smally x y)
    (rem-similar x y)))
  
(check= (rem 2 4) 2)
(check= (rem 4 2) 0)
(check= (rem 16 1) 0)
(check= (rem 1234567 10) 7)
(check= (rem 123 48) 27)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define
;; nat/: Nat x Nat-{0} -> Nat
;;
;; (nat/ x y) returns the result of integer division of x by y.
;; That is, it returns the integer part of x/y (so 7/3 = 2),
;; which is a natural number. See the examples below.
;;
;; Hint: this is a non-recursive one-liner.

(defunc nat/ (x y)
  :input-contract (and (natp x) (posp y))
  :output-contract (natp (nat/ x y))
 ...)

(check= (nat/ 10 2) 5)
(check= (nat/ 11 2) 5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions provided for you to simplify your life.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; abs: Rationalp -> Rationalp >= 0
;
; Calculates the absolute value of a rational number
(defunc abs (r)
  :input-contract (rationalp r)
  :output-contract (and (rationalp (abs r))(>= (abs r) 0)) 
  (if (< r 0)
    (unary-- r)
    r))

(check= (abs -3/2) 3/2)
(check= (abs 3/2) 3/2)
(check= (abs -3456778/2) 3456778/2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; floor: Rational -> Integer
;;
;; (floor r) returns the closest integer less than rational r 
;; (if r is an integer return r).
(defunc floor (r)
  :input-contract (rationalp r)
  :output-contract (integerp (floor r))
  (let* ((absnum (abs (numerator r)))
         (denom (denominator r))
         (posfloor (nat/ absnum denom)))
    (cond ((integerp r)   r)
          ((< (numerator r) 0)         (- (unary-- posfloor) 1))
          (t                           posfloor))))


(check= (floor 4/3) 1)
(check= (floor 3/4) 0)
(check= (floor 2) 2)
(check= (floor -2) -2)
(check= (floor -4/3) -2)
(check= (floor 0) 0)
(check= (floor 24/5) 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define
; round: Rational -> Integer
;
; (round r) takes a rational number r and rounds it up or down depending
; on the value.  For simplicity, you can round down for <= x.5
; and round up for all number > x.5.  
; Try to avoid repeatedly performing the same calculations, provided 
; we cover "let" in class before the due date
(defunc round (r)
  :input-contract (rationalp r)
  :output-contract (integerp (round r))
  ...)
(check= (round 4/3) 1)
(check= (round 3/4) 1)

;; Given that we need to convert a rational to a "decimal" number (below),
;; we need a hard lower limit on the number of decimal places
;; otherwise numbers like 1/3 wouldn't work.  *min-lsp* stands
;; for minimum least significant position and effectively means
;; we can store up to 6 positions smaller than the decimal point.
(defconst *min-lsp* -6)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define
;; set-precision: Rational x Integer -> Rational
;;
;; (set-precision r dig) returns the value of a rational number r 
;; altered to set the precision indicated by integer dig. 
;; Dig can be considered the least  significant power of 10 position 
;; (like in scientific notation) in the returned value that is not 0. 
;; Thus (set-precision 1234/100 1) returns 10....12.34 with all positions
;; less than 10^1 set to 0 give you 10.
;; (set-precision 1234/100 -1) returns 12.3
;; and (set-precision 1234/100 0) returns 12.
;; See the check= tests for other examples.
;; HINT: Start with small magnitude positive dig values 
;; first to get a feel for how the function works.
(defunc set-precision (r dig)
  :input-contract (and (rationalp r)(integerp dig)(> dig *min-lsp*))
  :output-contract (rationalp (set-precision r dig))
  ...)

;; Note: For the time being, you need to determine that your algorithm
;; works by checking against another rational number or as a list of integers 
;; like in Part III (not by printing out the decimal number in a nice format). 
;; We can improve on this next homework.
(check= (set-precision 1234/100 1) 10) ; 12.34 rounding at the 10s position
(check= (set-precision 1234/100 0) 12) ; 12.34 rounding at 1s position.
(check= (set-precision 1234/100 -1) 123/10) ; 12.35 rounded at the 0.1s position
(check= (set-precision -22/20 0) -1) ; -1.1 rounded at the 1s position 

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 Part III: Rationals to Decimal
 So let's try to get set-precision in a better format for testing
 You will simply return a list of 2 numbers and a +/- flag, the first being the
 the integer value of the rational (ir) (clipping out values after the decimal point)
 and the second being values after the decimal point (dr) to a maximum precision.
 Hint: Once  you have ir, you can get dr by taking the difference
 between r and ir.  What would multiplying that number do?  How about multiplying it
 by 10000?  dr can be an integer even if it represents a value < 1.
 dr values not 0 should always have the same length.
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#

;; A constant you may find useful for your function below.
(defconst *dec-shifter* 1000000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define 
;; rational-to-dec (r): Rational -> List (not empty)
;;
;; Takes a rational number r and returns a 3 element list with a +/- sign
;; and a pair of integers.
;; The first integer represents the whole number portion of r
;; while the second integer is the decimal representation of
;; the rest of r up to 6 decimal places.
;; The sign (denoted like "+") is used to handle the first integer 
;; being 0 (and thus has no sign)
;; Hint: Helper functions will make coding easier. For a number like
;; -12.345, I handled the "-" 12 and 345 separately.
(defunc rational-to-dec (r)
  :input-contract (rationalp r)
  :output-contract (and (listp (rational-to-dec r))
                        (not (endp (rational-to-dec r))))
  ...)
(check= (rational-to-dec -11/3) '("-" 3 666666)) ;-3.6 repeating
(check= (rational-to-dec 4/5) '("+" 0 800000)) ;0.8

;; Now let's check our set-precision method in a better format. 
;; Add at least 2 more tests.
(check= (rational-to-dec (set-precision -1/3 -4)) '("-" 0 333300)) ; 0.3333