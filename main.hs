import System.IO
import Data.List
import Data.Maybe

main = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let pages = getPages contents
    print pages

getPages                     :: String -> [String]
getPages ""                  = []
getPages s
    | emptyLineIndex == (-1) = [s]
    | otherwise              = firstPart : getPages (dropWhile (== '\n') secondPart)
        where firstPart      = take emptyLineIndex s
              secondPart     = drop emptyLineIndex s
              emptyLineIndex = findEmptyLineIndex  s

findEmptyLineIndex :: String -> Int
findEmptyLineIndex = (fromMaybe (-1)) . (getSubstringIndex "\n\n")

getSubstringIndex :: String -> String -> Maybe Int
getSubstringIndex y x = (y `isPrefixOf`) `findIndex` (tails x)
