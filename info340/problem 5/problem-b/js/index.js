'use strict';

/* Define a function `addFour()` that takes a single argument 
   and returns a value 4 greater than the input.*/
   function addFour(argument) {
    return argument + 4;
   }
   

/* Create and log a variable `twelve` that is the result of passing 8 to your
   addFour() function. */
   const twelve = addFour(8);
   console.log(twelve);

   
/* Create and log a variable `twelveString` that is the result of passing "8" 
   (a string) to your addFour() function. Consider what this tells you about how
  the function should be explained (e.g., in a comment). */
  let twelveString = addFour("8");
  console.log(twelveString);
  

/* Define a function `compoundInterest()` that takes three parameters: 
     1. an initial bank balance (principle, in dollars)
     2. an annual interest rate (as a decimal, e.g., 0.01) 
     3. a number of years
   The function should calculate the continuous compound interest
     (https://en.wikipedia.org/wiki/Compound_interest#Continuous_compounding) 
   and *return* the resulting total balance after that many number of years
   You can call the method and log the result to check your work. Compare to
     http://www.mathwarehouse.com/calculators/continuous-compound-interest-calculator.php
*/
function compoundInterest(initial, interest, years) {
  return initial * Math.E**(interest * years);
}


/* Define a function `fizzBuzz()` that takes in a single number as an argument.
   The function should *return* an _array_ of numbers from 1 to the argument. 
   But for multiples of three, the array should contain "Fizz" instead of the 
   number. For multiples of five, the array should contain "Buzz" instead of the 
   number. For numbers which are multiples of both three and five, the array 
   should contain "FizzBuzz" instead of the number.
   The returned array should be empty for arguments less than 1. */
   function fizzBuzz(number) {
    let result = [];
    if (number >= 1) {
      for (let i = 1; i <= number; i++) {
        if (i % 3 === 0 && i % 5 === 0) {
          result.push("FizzBuzz");
        } else if (i % 3 === 0) {
          result.push("Fizz");
        } else if (i % 5 === 0) {
          result.push("Buzz");
        } else {
          result.push(i);
        }
      }
    }
    return result;
  }

   

/* Define a function `getLetterFrequencies()` that takes in a single string as 
   an argument. The function should *return* an Object whose keys are characters
   (letters) and whose values are the number of times that character appears in
   the argument. Your function should be case sensitive.
   _Hint:_ start with an empty Object, then loop through the letters one at a
   time (you can access them with bracket notation, like with an array). For 
   each letter, increase the value associated with that key by one. Watch out 
   for if the letter is not in the Object yet!
   You can test this method with a word like "Mississippi". */
   function getLetterFrequencies(argument) {
    let letterFrequencies = {};
    for (let i = 0; i < argument.length; i++) {
      let letter = argument[i];
      if (letterFrequencies[letter] === undefined) {
        letterFrequencies[letter] = 1;
      } else {
        letterFrequencies[letter]++;
      }
    }
    return letterFrequencies;
   }
   

/* Create a variable `deck` that represents a deck of modern playing cards
   (https://en.wikipedia.org/wiki/Playing_card). This variable should be an
   *array* of 52 elements, each of which is an Object with properties:
     - `suit`, with a string value that is either `"hearts"`, `"diamonds"`, 
       `"clubs"`, or `"spades"`
     - `rank`, with an integer value ranging from 2 to 14 inclusive (values 
        11-14 represent a Jack, Queen, King, or Ace respectively).
    Tip: use a pair of nested loops to add each combination of suit and rank to 
    the `deck` array! 
    
    You can log out the `deck` to check your work! */
    let deck = [];
    let suit = ["hearts", "diamonds", "clubs", "spades"];
    for (let i = 0; i < suit.length; i++) {
      for (let j = 2; j <= 14; j++) {
        deck.push({suit: suit[i], rank: j});
      }
    }


//You can test the below functions by creating e.g., a `pokerHand` array that 
//contains five cards from the `deck`.


/* Define a function `containsQueenOfHearts()` that takes in an array of "card"
   objects (e.g., a Poker hand) and returns whether or not the Queen of Hearts
   is in that array.
   Hint: use a loop to check each card. */
   function containsQueenOfHearts(deck) {
    for (const card of deck) {
      if (card.suit == "hearts" && card.rank === 12) {
        return true;
      } 
   }
   return false;
  }

   
/* Define a function `getHighCard()` that takes in an array of "card" objects
  and returns the card object with the highest value. The "high card" is the one
  with the highest rank. Cards of different suits but the same rank are 
  considered to have the same value, and either is a valid result */
  function getHighCard(deck) {
    let highestCard = {rank: 0};
    for (const card of deck) {
      if (card.rank > highestCard.rank) {
        highestCard = card;
      } 
    }
    return highestCard;
  }
  

/* Define a function `isFlush()` that takes in an array of "card" objects and
   returns whether or not the cards all have the same _suit_. */
   function isFlush(deck) {
    let current = deck[0].suit;
    for (let i = 0; i < deck.length; i++) {
      if (deck[i].suit != current) {
        return false;
      }
    }
    return true;
   }


/* Extra challenge: define a function `hasPair()` that takes in an array of 
   "card" objects and returns whether or not there is at least one _pair_ (two 
   cards with the same _rank_) in the array.
   Double challenge: return the rank of the pair of cards with the highest rank 
   (e.g., if the hand contains more than one pair!) */
  //  function hasPair(deck) {
  //   let ranks=[];
  //   for (let i = 0; i < deck.length; i++) {
  //     ranks.push(deck[i].rank);
  //   }

  //   let highestPairRank;
  //   for (let j = 0; j < ranks.length; j++) {
  //     for (let k = j + 1; k < ranks.length; k++) {
  //       if (ranks[j] === ranks[k]) {
  //         highestPairRank = ranks[j];
  //       }
  //     }
  //   }

  //   if (highestPairRank) {
  //     return [true, highestPairRank];
  //   }
  //   return false;
  // }


//Make functions and variables available to tester. DO NOT MODIFY THIS.
if(typeof module !== 'undefined' && module.exports) {
  /* eslint-disable */
  if(typeof addFour !== 'undefined') 
    module.exports.addFour = addFour;
  if(typeof twelveString !== 'undefined') 
    module.exports.twelveString = twelveString;
  if(typeof compoundInterest !== 'undefined') 
    module.exports.compoundInterest = compoundInterest;
  if(typeof fizzBuzz !== 'undefined') 
    module.exports.fizzBuzz = fizzBuzz;
  if(typeof getLetterFrequencies !== 'undefined')
    module.exports.getLetterFrequencies = getLetterFrequencies;
  if(typeof deck !== 'undefined')
    module.exports.deck = deck;
  if(typeof containsQueenOfHearts !== 'undefined')
    module.exports.containsQueenOfHearts = containsQueenOfHearts;
  if(typeof getHighCard !== 'undefined')
    module.exports.getHighCard = getHighCard;
  if(typeof isFlush !== 'undefined')
    module.exports.isFlush = isFlush;
}