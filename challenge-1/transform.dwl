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