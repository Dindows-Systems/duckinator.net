# Dux API #

## Text API ##

Provides functions for formatting text.

* char *TextIntBase(int number, int base):
  `number` is a `Integer`.
  
  Converts `number` to `base` and returns it as a string.
  `TextIntBase(number, 10)` converts `number` to it's string form in decimal.

* char *TextDoubleBase(double number, int base):
  `number` is a `Double`.
  
  Converts `number` to `base` and returns it as a string.
  `TextIntBase(number, 10)` converts `number` to it's string form in decimal.

* char *TextFloatBase(float number, int base):
  `number` is a `Float`.
  
  Converts `number` to `base` and returns it as a string.
  `TextIntBase(number, 10)` converts `number` to it's string form in decimal.

* char *TextLongBase(long number, int base):
  `number` is a `Long`.
  
  Converts `number` to `base` and returns it as a string.
  `TextIntBase(number, 10)` converts `number` to it's string form in decimal.

* char *TextStringFormat(conat char *format, ...):
  Similar to printf. Not sure if the formatting strings should be the same or not.

