<div align="center">

# DataWeave Challenges

 <p><i> DataWeave challenges from ProstDev.com </i></p>

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
      "1º Part": payload splitBy "\n\n",
      "2º Part": payload splitBy "\n\n" map ((item) -> (item splitBy "\n")),
      "3º Part": payload splitBy "\n\n" map ((item) -> sum(item splitBy "\n") as Number)
  }
}

```
</details>
