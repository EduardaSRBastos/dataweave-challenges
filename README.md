<div align="center">

# DataWeave Challenges

 <p><i> DataWeave challenges from <a href="https://www.prostdev.com/">ProstDev.com</a> with explanations.</i></p>

<br>

---

## Table of Contents

<table>
  <tbody>
    <tr>
      <td><a href="#challenge-1---highest-number-of-sums"><b>Challenge #1</b></a></td>
      <td><a href="#challenge-2---rock-paper-scissors-score"><b>Challenge #2</b></a></td>
      <td><a href="#challenge-3---sum-of-characters-in-palindrome-sentences"><b>Challenge #3</b></a></td>
      <td><a href="#challenge-4---tower-of-hanoi"><b>Challenge #4</b></a></td>
    </tr>
    <tr>
      <td><a href="#challenge-5---reverse-phrases-words-keeping-the-punctuation"><b>Challenge #5</b></a></td>
      <td><a href="#challenge-6---digits-at-indexes-20-to-25-of-the-factorial-sum"><b>Challenge #6</b></a></td>
      <td><a href="#challenge-7---json-uppercase-values-except-for-thisname"><b>Challenge #7</b></a></td>
      <td><a href="#challenge-8---add-up-the-numbers-to-1-digit"><b>Challenge #8</b></a></td>
    </tr>
  </tbody>
</table>

</div>

---

<br>

### [Challenge #1 - Highest Number of Sums](https://www.prostdev.com/post/dataweave-programming-challenge-1)

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fdataweave-challenges&path=challenge-1">DataWeave Playground<a>

<details>
  <summary>Function</summary>

```dataweave
%dw 2.0
output application/json  
---
{
  "Highest Number": max(payload splitBy "\n\n" map ((item) -> sum(item splitBy "\n") as Number)),
  "Explanation": {
    "Split in the Empty Paragraph": payload splitBy "\n\n",
    "Split in Clean Arrays": payload splitBy "\n\n" map ((item) -> (item splitBy "\n")),
    "Sum Array Values": payload splitBy "\n\n" map ((item) -> sum(item splitBy "\n") as Number)
    }
}
```
</details>

### [Challenge #2 - Rock Paper Scissors Score](https://www.prostdev.com/post/dataweave-programming-challenge-2)

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fdataweave-challenges&path=challenge-2">DataWeave Playground<a>

<details>
  <summary>Function</summary>

```dataweave
%dw 2.0
output application/json 

var firstCol = payload splitBy "\n" map (item) -> (item splitBy " ")[0]
var secondCol = payload splitBy "\n" map (item) -> (item splitBy " ")[1]
---
{
  "Total Points": sum(firstCol map ((item, index) -> 
    if (item == secondCol[index])
      3
    else if ((item == "R" and secondCol[index] == "P") 
      or (item == "P" and secondCol[index] == "S")  
      or (item == "S" and secondCol[index] == "R"))
      6
    else
      0)),
  "Explanation": {
    "1º Column": payload splitBy "\n" map (item) -> (item splitBy " ")[0],
    "2º Column": payload splitBy "\n" map (item) -> (item splitBy " ")[1],
    "Counting Points": firstCol map ((item, index) -> 
      if (item == secondCol[index])
        3
      else if ((item == "R" and secondCol[index] == "P") 
          or (item == "P" and secondCol[index] == "S")  
          or (item == "S" and secondCol[index] == "R"))
          6
      else
        0)
    }
}
```
</details>

### [Challenge #3 - Sum of Characters in Palindrome Sentences](https://www.prostdev.com/post/dataweave-programming-challenge-3)

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fdataweave-challenges&path=challenge-3">DataWeave Playground<a>

<details>
  <summary>Function</summary>

```dataweave
%dw 2.0
import mapString, isAlphanumeric, reverse from dw::core::Strings
output application/json

var sentences = payload splitBy "\n" map ((item) -> 
  item mapString ((character) -> 
    if (isAlphanumeric(character))
      lower(character)
    else
      ""))
---
{
  "Sum of Palindrome Characters": sum(sentences map ((item, index) -> if(item == reverse(item)) sizeOf((payload splitBy "\n")[index]) else 0)),
  "Explanation": {
    "Clean Sentences": sentences,
    "Palindrome Sentences": sentences map ((item, index) -> if(item == reverse(item)) item else ""),
    "Size of Original Palindrome Sentences": sentences map ((item, index) -> if(item == reverse(item)) sizeOf((payload splitBy "\n")[index]) else 0)
  }
}
```
</details>

### [Challenge #4 - Tower of Hanoi](https://www.prostdev.com/post/dataweave-programming-challenge-4)

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fdataweave-challenges&path=challenge-4">DataWeave Playground<a>

<details>
  <summary>Function</summary>

```dataweave
%dw 2.0
output application/json

// $: value, $$: key
var towers = payload.towers mapObject (
  if (!isEmpty($)) // Tower with disks
    source: {name: $$, value: $} 
  else if ($$ ~= payload.targetTower) // Tower with the same name as targetTower
    target: {name: $$, value: $} 
  else  // Left tower - aux
    aux: {name: $$, value: $}
)

var moves = payload.moves

var toh = (disks, source, target, aux, moves) ->
  if (disks == 1) 
    moves + 1
  else do {
    var step1 = toh(disks - 1, source, aux, target, moves) // Move disks from source to aux
    var step2 = step1 + 1 // Increment the move count
    var step3 = toh(disks - 1, aux, target, source, step2) // Move disks from aux to target
    ---
    step3 // Return the total move count
  }

var finalTowers = {
  (towers.source.name): [],
  (towers.aux.name): [],
  (towers.target.name): 1 to payload.disks
}

---
{
  moves: toh(payload.disks, towers.source.name, towers.target.name, towers.aux.name, moves),
  disks: payload.disks,
  targetTower: payload.targetTower,
  towers: finalTowers orderBy($$),
  Explanation: {
    "Towers Var -  Separate the name and value for each tower": towers,
    "ToH Function - Count the number of moves": toh(payload.disks, towers.source.name, towers.target.name, towers.aux.name, moves)
  }
}
```
</details>

### [Challenge #5 - Reverse Phrase's Words, Keeping the Punctuation](https://www.prostdev.com/post/dataweave-programming-challenge-5)

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fdataweave-challenges&path=challenge-5">DataWeave Playground<a>

<details>
  <summary>Function</summary>

```dataweave
%dw 2.0
import indexWhere from dw::core::Arrays
import update from dw::util::Values
output application/json  
---
{
  // $: item, $$: index
  "Reverse Word Order": payload splitBy "\n" map 
    
    // Phrases without '!' and ','
    if (!(($ contains "!") or ($ contains ",")))
      $ splitBy " " orderBy -$$ joinBy " "

    // Phrases with both '!' and ','
    else if (($ contains "!") and ($ contains ","))
      do {
        var commaLocation = ($ splitBy " ") indexWhere ($ contains ",")
        ---
        $ replace "!" with "" replace "," with "" splitBy " " update [0] with ($ ++ "!") orderBy -$$ update [ commaLocation ] with ($ ++ ",") joinBy " "
      }
  
    // Phrases with only '!'
    else if ($ contains "!") 
      $ replace "!" with "" splitBy " " update [0] with ($ ++ "!") orderBy -$$ joinBy " " 

    // Phrases with only ',    '
    else 
      do {
        var commaLocation = ($ splitBy " ") indexWhere ($ contains ",")
        ---
        $ replace "," with "" splitBy " " orderBy -$$ update [ commaLocation ] with ($ ++ ",") joinBy " "
      },

  "Explanation": {
    "Phrases without '!' or ','": "Splits the phrase into words, reverses the word order, and joins them back together with spaces.",
    "Phrases with both '!' and ','": "Removes both punctuation marks, splits the phrase into words, adds the '!' back to the first word, reverses the word order, then adds the ',' back to its original position, and joins the words with spaces.",
    "Phrases with only '!'": "Removes the '!', splits the phrase into words, adds it back to the first word, then reverses the word order and joins the words with spaces.",
    "Phrases with only ','": "Removes the ',', splits the phrase into words, reverses the word order, then adds it back to its original position, and joins the words with spaces."
  }
}
```
</details>

### [Challenge #6 - Digits at indexes 20 to 25 of the Factorial Sum](https://www.prostdev.com/post/dataweave-programming-challenge-6)

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fdataweave-challenges&path=challenge-6">DataWeave Playground<a>

<details>
  <summary>Function</summary>

```dataweave
%dw 2.0
output application/json

var posNumbers = payload splitBy "\n" filter ($ >= 0)

fun factorial(number, result) = (
  if(number == 0)
    result
  else
    factorial(number - 1, result * number)
)
---
{
  "Digits at indexes 20 to 25 of the Factorial Sum" :sum(posNumbers map factorial($, 1))[20 to 25] as Number,
  Explanation: {
    "List of Positive Numbers": posNumbers,
    "Factorials of the Positive Numbers": posNumbers map factorial($, 1),
    "Sum of the Factorials of Positive Numbers": sum(posNumbers map factorial($, 1))
  }
}
```
</details>

### [Challenge #7 - JSON Uppercase Values Except for 'thisname'](https://www.prostdev.com/post/dataweave-programming-challenge-7)

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fdataweave-challenges&path=challenge-7">DataWeave Playground<a>

<details>
  <summary>Function</summary>

```dataweave
%dw 2.0
output application/json

// $: item/value, $$: key
fun valueType(value, key) =
  if (value is String and !(key ~= "thisname"))
    upper(value)
  else if (value is Array)
    value map valueType($, "")
  else if (value is Object)
    value mapObject { ($$): valueType($, $$) }
   else
    value

---
"Uppercase Values Except for 'thisname'": payload mapObject { ($$): valueType($, $$) }
```
</details>

### [Challenge #8 - Add Up the Numbers to 1 Digit](https://www.prostdev.com/post/dataweave-programming-challenge-8)

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fdataweave-challenges&path=challenge-8">DataWeave Playground<a>

<details>
  <summary>Function</summary>

```dataweave
%dw 2.0
output application/json

fun sumNumbers (number) =
    if(sizeOf(number) > 1)
        sumNumbers(sum(number splitBy ""))
    else
        number
---
// Same Result: sum(sum(sum(payload splitBy "\n") splitBy "") splitBy "")
"Add Up the Numbers to 1 Digit": sumNumbers(sum(payload splitBy "\n"))
```
</details>
