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
