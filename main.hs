import System.IO

main = do
    handle <- openFile "input.txt" ReadMode
    -- How to get the type of this???
    contents <- hGetContents handle
    let pages = getPages contents
    print pages

getPages :: String -> [String]
getPages "" = []
getPages s
    | (length secondPart > 0) && (head . tail secondPart == '\n') = 
        firstPart : getPages . dropWhile (== '\n') secondPart
    | otherwise = s
            where (firstPart, secondPart) = break (/= '\n') s
