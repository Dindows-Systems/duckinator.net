# Dux API #

## Console API ##

Functions for printing information to the screen.

* <p><span class="func-type">void</span> <span class="func-name">MoveCursor</span>(<span class="func-type">int</span> <span class="func-arg">row</span>, <span class="ret">int</span> <span class="func-arg">col</span>):</p>
  <p class="types_overview"><code>row</code> and <code>col</code> are <code>Integer</code>s.</p>
  Places the cursor on row `row`, column `col`.

* <p><span class="func-type">void</span> <span class="func-name">PrintChar</span>(<span class="func-arg">chr</span>):</p>
  <p class="types_overview"><code>chr</code> is a <code>Character</code>.</p>
  Prints a single character on row `row`, column `col`.
  Adjusts internal row and column representations.

* <p><span class="func-type">void</span> <span class="func-name">PrintString</span>(<span class="func-type">char*</span> <span class="func-arg">str</span>):</p>
  <p class="types_overview"><code>str</code> is a <code>String</code>/<code>Character Array</code>.</p>
  Prints a string on row `row`, column `col`.
  Adjusts internal row and column representations.

## Possible additions for Console API ##

These are things that are frequently seen elsewhere, but as of now are not thought to be needed.

* <p><span class="func-type">void</span> <span class="func-name">PutChar</span>(<span class="func-type">int</span> <span class="func-arg">row</span>, <span class="func-arg">col</span>, <span class="func-arg">chr</span>):</p>
  <p class="types_overview"><code>row</code> and <code>col</code> are <code>Integer</code>s, <code>chr</code> is a <code>Character</code>.</p>
  Prints a single character on row `row`, column `col`.
  *If this is added, determine whether it updates internal row/column representation*

* <p><span class="func-type">void</span> <span class="func-name">PutString</span>(<span class="func-type">int</span> <span class="func-arg">row</span>, <span class="func-type">int</span> <span class="func-arg">col</span>, <span class="func-type">char*</span> <span class="func-arg">str</span>):</p>
  <p class="types_overview"><code>row</code> and <code>col</code> are <code>Integer</code>s, <code>str</code> is a <code>String</code>/<code>Character Array</code>.</p>
  Prints a string on row `row`, column `col`.
  *If this is added, determine whether it updates internal row/column representation*

