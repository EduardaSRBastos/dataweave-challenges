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