import System.IO
import Data.List
import Data.Maybe
import Data.Char (isAlpha, toLower, isSpace)

main = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let pages         = getPages contents
        numberedPages = addNumbers pages
        numberedWords = getWords numberedPages
    print numberedWords

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


addNumbers :: [String] -> [(Int, String)]
addNumbers = zip [1..]


getWords :: [(Int, String)] -> [(Int, [String])]
getWords []           = []
getWords ((n,str):xs) = (n, nub $ sort $ words $ removePunctuation str) : getWords xs

removePunctuation :: String -> String
removePunctuation [] = []
removePunctuation (s:sx)
    | (isAlpha s) || (isSpace s) = toLower s : removePunctuation sx
    | otherwise = removePunctuation sx
