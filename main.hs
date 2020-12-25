--------------------------------------------------------------------------------
-- Haskell Inverted Index Program
--
-- Given an input text file, this program parses it, organizes it into pages,
-- and returns a list of pairs, where each pair contains a single word, and
-- a list of pages on which the given word appears.
--
-- Author: Luka Duranovic (lduranovic22@amherst.edu)
-- Date: 25/12/2020
--------------------------------------------------------------------------------



import System.IO
import Data.List
import Data.Maybe
import Data.Char (isAlpha, toLower, isSpace)
import qualified Data.Set

main = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let pages         = getPages contents
        numberedPages = addNumbers pages
        numberedWords = getWords numberedPages
        wordPagePairs = indexPages numberedWords
        finalList     = invertedIndex wordPagePairs
    print finalList

getPages                     :: String -> [String]
getPages ""                  = []
getPages s
    | emptyLineIndex == (-1) = [s]
    | otherwise              = 
        firstPart : getPages (dropWhile (== '\n') secondPart)
            where firstPart      = take emptyLineIndex s
                  secondPart     = drop emptyLineIndex s
                  emptyLineIndex = findEmptyLineIndex  s

findEmptyLineIndex :: String -> Int
findEmptyLineIndex = (fromMaybe (-1)) . (getSubstringIndex "\n\n")

getSubstringIndex     :: String -> String -> Maybe Int
getSubstringIndex y x = (y `isPrefixOf`) `findIndex` (tails x)


addNumbers :: [String] -> [(Int, String)]
addNumbers = zip [1..]


getWords              :: [(Int, String)] -> [(Int, [String])]
getWords []           = []
getWords ((n,str):xs) = 
    (n, nub $ sort $ words $ removePunctuation str) : getWords xs

removePunctuation                :: String -> String
removePunctuation []             = []
removePunctuation (s:sx)
    | (isAlpha s) || (isSpace s) = toLower s : removePunctuation sx
    | otherwise                  = removePunctuation sx

indexSinglePage :: (Int, [String]) -> [(String, Int)]
indexSinglePage (pageNum, []) = []
indexSinglePage (pageNum, (firstWord:restOfWords)) = 
    (firstWord, pageNum) : indexSinglePage (pageNum, restOfWords)

indexPages :: [(Int, [String])] -> [(String, Int)]
indexPages [] = []
indexPages (page:restOfPages) =
    (indexSinglePage page) ++ (indexPages restOfPages)

invertedIndex :: [(String, Int)] -> [(String, [Int])]
invertedIndex [] = []
invertedIndex fullList@(x:xs) = 
    (processSingleWord x) : (invertedIndex $ deleteWord x xs)
        where processSingleWord (word, pageNum) =
                  let newList = filter (\(currWord, currPageNum) -> currWord == word) fullList
                      newWordList = nub $ map (\(str, n) -> n) newList
                  in (word, newWordList)
              deleteWord _ [] = []
              deleteWord word wordList =
                  filter (\(currWord, currPageNum) -> currWord /= (fst word)) wordList
