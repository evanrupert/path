{-# LANGUAGE OverloadedStrings #-}
module Main where

import Lib
import Display
import Cli
import System.Environment (getEnv, getArgs)
import System.Console.ANSI
import Data.List
import System.IO (hPutStrLn, stderr)
import System.Directory (listDirectory, doesDirectoryExist)
import Control.Monad

type Directory = (String, [String])

main :: IO ()
main = do
    args <- getArgs

    case parseArgs args of
      (Left ShowFullPath) -> showFullPath
      (Left (SearchPath search)) -> searchPath search
      (Right err) -> hPutStrLn stderr err


showFullPath :: IO ()
showFullPath = do
    path <- getEnv "PATH"
    let pathDirectories = sort . splitPath $ path

    mapM_ displayDirectory pathDirectories


searchPath :: String -> IO ()
searchPath search = do
    path <- getEnv "PATH"
    let pathDirectories = splitPath path

    result <- findPathDirectory search pathDirectories

    case result of
      (Just result) -> displayDirectory result
      Nothing -> putStrLn "Fr4ick off"


findPathDirectory :: String -> [String] -> IO (Maybe String)
findPathDirectory search directories = do
    existingPathDirectories <- filterM doesDirectoryExist directories

    pathFiles <- fmap (zip existingPathDirectories) $ mapM listDirectory existingPathDirectories

    return $ findProgramDirectory search pathFiles
    

findProgramDirectory :: String -> [Directory] -> Maybe String
findProgramDirectory search = foldl (findDirName search) Nothing


findDirName :: String -> Maybe String -> Directory -> Maybe String
findDirName search acc (dirName, files) = if search `elem` files
                                             then (Just dirName)
                                             else acc
                                                                                 

