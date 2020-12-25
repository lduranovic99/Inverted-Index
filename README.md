## Haskell Inverted Index Program

This is my attempt at an Inverted Index program, written in Haskell.
The idea is to have an input file called `input.txt`, which my program
will open, read all the words from it, and then, for each word, output
where in the file that word can be found.

To be a bit more specific, for each word, the program will output a list
of "pages" on which the word appears. A page in this example is defined as
a chunk of text between empty lines. Therefore, I had to implement some
functionality in my program to recognize all the places where the new-line
character '\n' appears twice. All those spots are places where the program
essentially increments the page count.
