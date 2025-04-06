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