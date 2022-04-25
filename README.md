# FirstPrelude
A replacement for Haskell's Prelude library (the standard library) designed for teaching beginners.
The design goals are to simplify considerably the Prelude so that basic functional programming can be taught without having to explain type classes.
Subsequently:

* `Integer` is the only numeric type
* All arithmetic and comparison is monomorphism to `Integer`
* `Foldable` is expunged so there are only higher-order functions on lists
* `length :: [a] -> Integer` (not `Int` as in Prelude)
* No `Monad` class but `return`, `>>=`, `>>`, `fail` are all provided specialised on `IO`
* Specialised `TypeError`s for `Show` on functions, e.g.

      > (+1)

      <interactive>:48:1: error:
          • Cannot show a function (yours is of type Integer -> Integer)
          • In a stmt of an interactive GHCi command: print it
