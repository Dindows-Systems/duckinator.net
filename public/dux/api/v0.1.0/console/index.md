# Dux API #

## Console API ##

For these, you explicitly specify the row and column to start printing from.
These *should be stored internally* for use from the [Relative Positioning](#relative_positioning) functions.

* <p><span class="type">void</span> <span class="name">MoveCursor</span>(<span class="type">int</span> <span class="arg">row</span>, <span class="ret">int</span> <span class="arg">col</span>):</p>
  <p class="types_overview"><code>row</code> and <code>col</code> are <code>Integer</code>s.</p>
  Places the cursor on row `row`, column `col`.

* <p><span class="type">void</span> <span class="name">PrintChar</span>(<span class="arg">chr</span>):</p>
  <p class="types_overview"><code>chr</code> is a <code>Character</code>.</p>
  Prints a single character on row `row`, column `col`.
  Adjusts internal row and column representations.

* <p><span class="type">void</span> <span class="name">PrintString</span>(<span class="type">char*</span> <span class="arg">str</span>):</p>
  <p class="types_overview"><code>str</code> is a <code>String</code>/<code>Character Array</code>.</p>
  Prints a string on row `row`, column `col`.
  Adjusts internal row and column representations.

## Possible additions for Console API ##

These are things that are frequently seen elsewhere, but as of now are not thought to be needed.

* <p><span class="type">void</span> <span class="name">PutChar</span>(<span class="type">int</span> <span class="arg">row</span>, <span class="arg">col</span>, <span class="arg">chr</span>):</p>
  <p class="types_overview"><code>row</code> and <code>col</code> are <code>Integer</code>s, <code>chr</code> is a <code>Character</code>.</p>
  Prints a single character on row `row`, column `col`.
  *If this is added, determine whether it updates internal row/column representation*

* <p><span class="type">void</span> <span class="name">PutString</span>(<span class="type">int</span> <span class="arg">row</span>, <span class="type">int</span> <span class="arg">col</span>, <span class="type">char*</span> <span class="arg">str</span>):</p>
  <p class="types_overview"><code>row</code> and <code>col</code> are <code>Integer</code>s, <code>str</code> is a <code>String</code>/<code>Character Array</code>.</p>
  Prints a string on row `row`, column `col`.
  *If this is added, determine whether it updates internal row/column representation*

