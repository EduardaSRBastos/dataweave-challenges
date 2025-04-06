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