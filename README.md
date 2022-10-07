# FirstPrelude
A replacement for Haskell's Prelude library (the standard library) designed for teaching beginners.

Recommend use with students:

    import Prelude()
    import FirstPrelude

The design goals are to simplify considerably the Prelude library so that basic functional programming can be taught without having to explain type classes; I have observed in several years of teaching Haskell that many beginner mistakes which in a language like ML would result in a clear error message instead result in an error message about a lack of type class instances. This is unfortunate as type classes cannot easily be taught immediately and so beginners are left without as much support until they learn more topics. `FirstPrelude` is designed to simplify away as much of this as possible by using very few type classes and making a few other simplifying choices. The goal is then for students to switch to regular Prelude late in the course. The changes here are:

* `Integer` is the only numeric type
* All arithmetic and comparison is monomorphised to `Integer` i.e., no `Eq`, `Num`, or `Ord` but all the previous operations are there just on `Integer`. This significantly simplifies error messages in beginner programs (i.e., no more `No instance of Num (a -> b)` style error messages).
* `Foldable` is expunged so there are only higher-order functions on lists
* `length :: [a] -> Integer` (not `Int` as in Prelude)
* Ranged- based list comprehensions still work (e.g., `[1..3]`) but only on `Integer`
* No `Monad` class but `return`, `>>=`, `>>`, `fail` are all provided monomorphised to `IO`
* Specialised `TypeError`s for `Show` on functions, e.g.

      > (+1)

      <interactive>:48:1: error:
          • Cannot show a function (yours is of type Integer -> Integer)

            Perhaps there is a missing argument?

          • In a stmt of an interactive GHCi command: print it

