{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( splitPath
    ) where

splitPath :: String -> [String]
splitPath = splitOn (== ':')

splitOn :: (Char -> Bool) -> String -> [String]
splitOn predicate string = case dropWhile predicate string of
    "" -> []
    s -> w : splitOn predicate s''
        where (w, s'') = break predicate s
