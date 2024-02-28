--{-# LANGUAGE RebindableSyntax #-}
import Prelude()
import FirstPrelude

simple = 1 + 2  -- has type Integer

allOdd = map (mod 2) -- [Integer] -> [Integer]

-- *Main> (+1)
--
-- <interactive>:2:1: error:
--    • Cannot show (pretty print) functions (yours is of type Integer -> Integer)
--
--      Perhaps there is a missing argument?
--
--    • In a stmt of an interactive GHCi command: print it

-- *Main> (+1) "x"
--
-- <interactive>:3:6: error:
--    • Couldn't match expected type ‘Integer’ with actual type ‘[Char]’
--    • In the first argument of ‘+ 1’, namely ‘"x"’
--      In the expression: (+ 1) "x"
--      In an equation for ‘it’: it = (+ 1) "x"

-- (instead of "No instance for (Num [Char]) arising from a use of ‘+’").
