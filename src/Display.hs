module Display
    ( displayDirectory
    , displayError
    ) where

import System.Console.ANSI

displayDirectory :: String -> IO ()
displayDirectory dir = do
    setSGR [ SetColor Foreground Vivid Magenta ]
    putStr " - "
    setSGR [ SetColor Foreground Vivid Green ]
    putStrLn dir


displayError :: String -> IO ()
displayError err = do
    setSGR [ SetColor Foreground Vivid Red ]
    putStrLn err
