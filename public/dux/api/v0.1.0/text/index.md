# Dux API #

## Text API ##

Provides functions for formatting text.

* ``` c
char* TextIntBase(int number, int base)
```
  <p class="types_overview"><code>number</code> is a <code>Integer</code>.</p>
  Converts `number` to `base` and returns it as a string.
  `TextIntBase(number, 10)` converts `number` to it's string form in decimal.

* ``` c
char *TextDoubleBase(double number, int base)
```
  <p class="types_overview"><code>number</code> is a <code>Double</code>.</p>
  
  Converts `number` to `base` and returns it as a string.
  `TextIntBase(number, 10)` converts `number` to it's string form in decimal.

* ``` c
char *TextFloatBase(float number, int base)
```
  <p class="types_overview"><code>number</code> is a <code>Float</code>.</p>
  
  Converts `number` to `base` and returns it as a string.
  `TextIntBase(number, 10)` converts `number` to it's string form in decimal.

* ``` c
char *TextLongBase(long number, int base)
```
  <p class="types_overview"><code>number</code> is a <code>Long</code>.</p>
  
  Converts `number` to `base` and returns it as a string.
  `TextIntBase(number, 10)` converts `number` to it's string form in decimal.

* ``` c
char* TextStringFormat(conat char* format, ...)
```
  Similar to sprintf. Not sure if the formatting strings should be the same or not.

