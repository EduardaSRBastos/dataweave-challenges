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
