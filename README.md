# FirstPrelude
A replacement for Haskell's Prelude library (the standard library) designed for teaching beginners.

Recommend use with students:

    import Prelude()
    import FirstPrelude

The design goals are to simplify considerably the Prelude library so that basic functional programming can be taught without having to explain type classes. Subsequently:

* `Integer` is the only numeric type
* All arithmetic and comparison is monomorphised to `Integer` i.e., no `Eq`, `Num`, or `Ord` but all the previous operations are there just on `Integer`. This significantly simplifies error messages in beginner programs (i.e., no more `No instance of Num (a -> b)` style error messages).
* `Foldable` is expunged so there are only higher-order functions on lists
* `length :: [a] -> Integer` (not `Int` as in Prelude)
* List comprehensions still work but only on `Integer`
* No `Monad` class but `return`, `>>=`, `>>`, `fail` are all provided monomorphised to `IO`
* Specialised `TypeError`s for `Show` on functions, e.g.

      > (+1)

      <interactive>:48:1: error:
          • Cannot show a function (yours is of type Integer -> Integer)
          • In a stmt of an interactive GHCi command: print it

