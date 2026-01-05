{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE ExplicitNamespaces #-}

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE TypeOperators #-}

-----------------------------------------------------------------------------
-- |
-- Module      :  FirstPrelude
-- Copyright   :  (c) University of Kent 2022
-- License     :  BSD-style
--
-- Maintainer  :  Dominic Orchard
-- Stability   :  experimental
-- Portability :  portable
--
-- FirstPrelude is a non-exhaustive replacement for Prelude aimed at
-- absolute beginners to Haskell. It largely tries to bypass the need
-- for type classes (arithmetic is specialised to Integers), it
-- provides some simplifications to Prelude, and provides some custom
-- error messages.
--
-----------------------------------------------------------------------------

module FirstPrelude (

    -- * Infrastructure
    ifThenElse,

    -- * Standard types

    -- ** Basic data types
    Bool(False, True),
    (&&), (||), not, otherwise,

    Maybe(Nothing, Just),
    maybe,

    Either(Left, Right),
    either,

    Char, String,
    eqChar, eqString,

    -- *** Tuples
    fst, snd, curry, uncurry,

    -- ** Basic comparators (specialised to Integer)
    -- and enumerations
    (==), (/=),
    (<), (<=), (>=), (>), max, min,
    succ, pred,
    enumFrom, enumFromThen,
    enumFromTo, enumFromThenTo,

    -- ** Numbers

    -- *** Just expose Integer and Int
    Integer, Int,

    -- *** Numeric operations
    (+), (-), (*), negate, abs, signum, fromInteger,
    quot, rem, div, mod, quotRem, divMod, toInteger,
    (^),

    -- ** Monads and functors
    fmap,
    (>>=), (>>), return,
    fail,

    -- ** Higher-order functions on lists
    foldr,     -- :: (a -> b -> b) -> b -> [a] -> b
    foldl,     -- :: (b -> a -> b) -> b -> [a] -> b

    -- ** Miscellaneous functions
    id, const, (.), flip, ($), until,
    asTypeOf, error, errorWithoutStackTrace, undefined,
    seq,

    -- * List operations
    and, or,
    List.map, (List.++), List.filter,
    List.head, List.last, List.tail, List.init, (List.!!),
    null, length,
    List.reverse,
    -- *** Scans
    List.scanl, List.scanl1, List.scanr, List.scanr1,
    -- *** Infinite lists
    List.iterate, List.repeat, replicate, List.cycle,
    -- ** Sublists
    take, drop,
    List.takeWhile, List.dropWhile,
    List.span, List.break,
    splitAt,
    -- ** Zipping and unzipping lists
    List.zip, List.zip3,
    List.zipWith, List.zipWith3,
    List.unzip, List.unzip3,
    -- ** Functions on strings
    List.lines, List.words, List.unlines, List.unwords,

    -- * Show / Read (simplified)
    Show(showsPrec, show),
    read,

    -- * Basic Input and output
    IO,
    -- ** Simple I\/O operations
    -- All I/O functions defined here are character oriented.  The
    -- treatment of the newline character will vary on different systems.
    -- For example, two characters of input, return and linefeed, may
    -- read as a single newline character.  These functions cannot be
    -- used portably for binary I/O.
    -- *** Output functions
    putChar,
    putStr, putStrLn, print,
    -- *** Input functions
    getChar,
    getLine, getContents, interact,
    -- *** Files
    FilePath,
    readFile, writeFile, appendFile, readIO, readLn,
    -- ** Exception handling in the I\/O monad
    IOError, ioError, userError,

  ) where

import qualified Control.Monad as Monad
import System.IO
import System.IO.Error
import qualified Data.List as List
import Data.Either
import Data.Functor     ( (<$>) )
import Data.Maybe
import Data.Tuple

import GHC.Base hiding ( foldr, mapM, sequence, Eq(..), Ord(..), Monad(..), eqChar, eqString )
import qualified Text.Read as Read
import qualified GHC.Enum as Enum
import qualified GHC.Num as Num
import GHC.Num(Integer)
import qualified GHC.Real as NumR
import qualified Data.Ord as Ord
import qualified Data.Eq  as Eq
import GHC.Show

import GHC.TypeLits

-- Re-export some monomorphised things from foldable
import qualified Data.Foldable as Foldable

default (Integer)

-- So that RebindableSyntax can also be used (though this is optional)
ifThenElse :: Bool -> a -> a -> a
ifThenElse True x _  = x
ifThenElse False _ y = y

-- Avoids the Int/Integer problem
length :: [a] -> Integer
length []     = 0
length (_:xs) = 1 + length xs

take :: Integer -> [a] -> [a]
take n _      | n <= 0 = []
take _ []              = []
take n (x:xs)         = x : take (n-1) xs

drop :: Integer -> [a] -> [a]
drop n xs     | n <= 0 = xs
drop _ []              = []
drop n (_:xs)         = drop (n-1) xs

eqChar :: Char -> Char -> Bool
eqChar = (Eq.==)

eqString :: String -> String -> Bool
eqString = (Eq.==)

-- ** Monomorphised comparisons and arithmetic

(==), (/=), (<), (<=), (>=), (>) :: Integer -> Integer -> Bool
(==) = (Eq.==)
(/=) = (Eq./=)
(<)  = (Ord.<)
(<=) = (Ord.<=)
(>=) = (Ord.>=)
(>)  = (Ord.>)

max, min :: Integer -> Integer -> Integer
max = Ord.max
min = Ord.min

succ, pred :: Integer -> Integer
succ = Enum.succ
pred = Enum.pred

enumFrom :: Integer -> [Integer]
enumFrom = Enum.enumFrom

enumFromThen :: Integer -> Integer -> [Integer]
enumFromThen = Enum.enumFromThen

enumFromTo :: Integer -> Integer -> [Integer]
enumFromTo = Enum.enumFromTo

enumFromThenTo :: Integer -> Integer -> Integer -> [Integer]
enumFromThenTo = Enum.enumFromThenTo

(+), (-), (*), quot, rem, div, mod :: Integer -> Integer -> Integer
(+) = (Num.+)
(-) = (Num.-)
(*) = (Num.*)
quot = NumR.quot
rem = NumR.rem
div = NumR.div
mod = NumR.mod

negate, abs, signum, fromInteger, toInteger :: Integer -> Integer
negate = Num.negate
abs    = Num.abs
signum = Num.signum
fromInteger = id
toInteger   = id

quotRem, divMod :: Integer -> Integer -> (Integer, Integer)
quotRem = NumR.quotRem
divMod  = NumR.divMod

(^) :: Integer -> Integer -> Integer
(^) = (NumR.^)

-- ** List functions

-- Avoids the Int/Integer problem
length :: [a] -> Integer
length []     = 0
length (_:xs) = 1 + length xs

take :: Integer -> [a] -> [a]
take n _      | n <= 0 = []
take _ []              = []
take n (x:xs)         = x : take (n-1) xs

drop :: Integer -> [a] -> [a]
drop n xs     | n <= 0 = xs
drop _ []              = []
drop n (_:xs)         = drop (n-1) xs

replicate :: Integer -> a -> [a]
replicate n x | n <= 0 = []
replicate n x          = x : replicate (n-1) x

splitAt :: Integer -> [a] -> ([a], [a])
splitAt n xs | n <= 0 = ([], xs)
splitAt _ []          = ([], [])
splitAt n (x:xs)     = let (ys, zs) = splitAt (n-1) xs in (x:ys, zs)

and :: [Bool] -> Bool
and []       = True
and (b : bs) = b && and bs

or :: [Bool] -> Bool
or []        = False
or (b : bs)  = b || or bs

(!!) :: [a] -> Integer -> a
(x:_)  !! n | n == 0    = x
(_:xs) !! n | n > 0     = xs !! (n - 1)
_      !! _              = error "FirstPrelude.!!: index out of bounds"

-- ** Monomorphised fold things

null :: [a] -> Bool
null = Foldable.null

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl = Foldable.foldl

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr = Foldable.foldr

-- ** Monomorphised monads

return :: a -> IO a
return = Monad.return

(>>) :: IO a -> IO b -> IO b
(>>) = (Monad.>>)

(>>=) :: IO a -> (a -> IO b) -> IO b
(>>=) = (Monad.>>=)

fail :: String -> IO a
fail = (Monad.fail)

-- ** Show gets a fancy error message

read :: String -> Integer
read = Read.read

instance TypeError
           (Text "Cannot show (pretty print) functions (yours is of type "
           :<>: ShowType a :<>: Text " -> " :<>: ShowType b :<>: Text ")"
           :$$: Text "" :$$: Text "Perhaps there is a missing argument?" :$$: Text "")
           => Show (a -> b) where
   show = undefined
