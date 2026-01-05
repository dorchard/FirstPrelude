# Revision history for FirstPrelude

## 0.2.0.0

* Added string/character comparison functions (eqChar, eqString) - Students can now compare strings and characters without understanding type classes
* Removed HasCallStack constraints - Overrode head, tail, last, init, error, and undefined to provide cleaner type signatures without confusing HasCallStack => constraints
* Fixed list indexing consistency - Replaced (!!) to use Integer instead of Int, matching the return type of length
* Hides Int type - Removed Int from exports to avoid confusion since all numeric operations use Integer
* Added missing list functions - Included concat, concatMap, and, and or
* take, drop, replicate, and splitAt implementations use Integer consistently
* Updated base dependency - Relaxed upper bound from < 4.16.5.0 to < 5 to support newer GHC versions

Breaking changes:

* Int type no longer exported
* Several functions now use Integer instead of Int for indices

## 0.1.2.0
* Include standard definition of `ifThenElse` to allow RebindableSyntax
to be used.

## 0.1.1.0
* Added in (^) :: Integer -> Integer -> Integer

## 0.1.0.0

* First version. Released on an unsuspecting world.
