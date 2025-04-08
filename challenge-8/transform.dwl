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