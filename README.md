## Haskell Inverted Index Program

This is my attempt at an Inverted Index program, written in Haskell.
The idea is to have an input file called `input.txt`, which my program
will open, read all the words from it, and then, for each word, output
where in the file that word can be found.

To be a bit more specific, for each word, the program will output a list
of "pages" on which the word appears. A page in this example is defined as
a chunk of text between empty lines. In order to get this to work, I had 
to implement some functionality in my program to recognize all the places 
where the new-line character `'\n'` appears twice. All those spots are places 
where the program essentially increments the page count.

The final output of the program is a sorted list of tuples, where each
tuple contains the given word and the corresponding list of pages on which 
that word appears.

When it comes to algorithmic efficiency and overall elegance of the program,
this is certainly not the best possible instance of Haskell programming.
Be that as it may, it was a good opportunity for me to get my hands dirty
with some functional programming.

Ways to further improve the program:
* In general, it is considered better practice to avoid explicit recursion.
I however, had to use it in a few places, just to get things moving and
make everything work as soon as possible. One could certainly find all
those places and use folds and maps to avoid potential hidden errors and
unpredictable behavior.
* Think about the function `Inverted Index`. In there, as one can see,
there is a fairly inefficient process of selecting a word from the list,
then getting all other instances of that word (with the corresponding page
numbers), then bundlind that up into one list of pages on which that word
appears, and finally inserting that list alongside the word as a final product.
Obviously, this is not the best way to do this, and it is quite slow, because
for every word we have to go through the full list and check each entry.
Furthermore, later on in the code one has to traverse the list again, in order
to remove all the tuples that contain the word that was just processed (to
avoid any duplicates). This is also inefficient.
    * The best solution to this would be utilizing some kind of a set data
    structure, which could keep track of the words that have been encountered
    already. In the future, I will try to look into this a bit more.
