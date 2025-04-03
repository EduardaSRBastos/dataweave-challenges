<div align="center">

# DataWeave Challenges

 <p><i> DataWeave challenges from <a href="https://www.prostdev.com/">ProstDev.com</a> with explanations.</i></p>

</div>

<br>

### [Challenge #1](https://www.prostdev.com/post/dataweave-programming-challenge-1)

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

<br>

### [Challenge #2](https://www.prostdev.com/post/dataweave-programming-challenge-2)

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

<br>

### [Challenge #3](https://www.prostdev.com/post/dataweave-programming-challenge-3)

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fdataweave-challenges&path=challenge-3">DataWeave Playground<a>

<details>
  <summary>Function</summary>

```dataweave
%dw 2.0
import mapString, isAlphanumeric, reverse from dw::core::Strings
output application/json

var sentences = payload splitBy "\n" map ((item) -> item mapString ((character) -> if (isAlphanumeric(character))
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