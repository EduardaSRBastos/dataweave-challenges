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