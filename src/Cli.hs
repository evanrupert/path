{-# LANGUAGE OverloadedStrings #-}
module Cli
    ( parseArgs
    , PathArgs (ShowFullPath, SearchPath)
    ) where

data PathArgs
    = ShowFullPath
    | SearchPath String
    deriving (Show)


parseArgs :: [String] -> Either PathArgs String
parseArgs [] = Left ShowFullPath
parseArgs (pathSearch:[]) = Left (SearchPath pathSearch)
parseArgs _ = Right "Too many arguments"
