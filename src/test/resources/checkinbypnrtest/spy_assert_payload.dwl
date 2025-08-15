%dw 2.0
import * from dw::test::Asserts
---
payload must equalTo({
  "lastName": "Suja",
  "numBags": 1
})