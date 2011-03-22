# Dux API #

## Text API ##

Provides functions for formatting text.

* <p class="func"><span class="type">char*</span> TextIntBase(<span class="type">int</span> <span class="arg">number</span>, <span class="type">int</span> <span class="arg">base</span>):</p>
  <p class="types_overview"><code>number</code> is a <code>Integer</code>.</p>
  Converts `number` to `base` and returns it as a string.
  `TextIntBase(number, 10)` converts `number` to it's string form in decimal.

* <p class="func"><span class="type">char*</span> TextDoubleBase(<span class="type">double</span> <span class="arg">number</span>, <span class="type">int</span> <span class="arg">base</span>):</p>
  <p class="types_overview"><code>number</code> is a <code>Double</code>.</p>
  
  Converts `number` to `base` and returns it as a string.
  `TextIntBase(number, 10)` converts `number` to it's string form in decimal.

* <p class="func"><span class="type">char*</span> TextFloatBase(<span class="type">float</span> <span class="arg">number</span>, <span class="type">int</span> <span class="arg">base</span>):</p>
  <p class="types_overview"><code>number</code> is a <code>Float</code>.</p>
  
  Converts `number` to `base` and returns it as a string.
  `TextIntBase(number, 10)` converts `number` to it's string form in decimal.

* <p class="func"><span class="type">char*</span> TextLongBase(long <span class="arg">number</span>, <span class="type">int</span> <span class="arg">base</span>):</p>
  <p class="types_overview"><code>number</code> is a <code>Long</code>.</p>
  
  Converts `number` to `base` and returns it as a string.
  `TextIntBase(number, 10)` converts `number` to it's string form in decimal.

* <p class="func"><span class="type">char*</span> TextStringFormat(<span class="type">conat char*</span> format, ...):</p>
  Similar to sprintf. Not sure if the formatting strings should be the same or not.

