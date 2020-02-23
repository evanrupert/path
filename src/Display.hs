module Display
    ( displayDirectory
    ) where

import System.Console.ANSI
import System.IO (hPutStrLn, stderr)

displayDirectory :: String -> IO ()
displayDirectory dir = do
    setSGR [ SetColor Foreground Vivid Magenta ]
    putStr " - "
    setSGR [ SetColor Foreground Vivid Green ]
    putStrLn dir


displayError :: String -> IO ()
displayError err = do
    setSGR [ SetColor Foreground Vivid Red ]
    hPutStrLn stderr err
