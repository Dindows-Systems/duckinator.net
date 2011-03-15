# Dux API #

## Console API ##

For these, you explicitly specify the row and column to start printing from.
These *should be stored internally* for use from the [Relative Positioning](#relative_positioning) functions.

* <p><span class="type">void</span> <span class="name">MoveCursor</span>(<span class="type">int</span> <span class="arg">row</span>, <span class="ret">int</span> <span class="arg">col</span>):</p>
  <span class="types_overview"><code>row</code> and <code>col</code> are `Integer`s.</span>
  Places the cursor on row `row`, column `col`.

* <p><span class="type">void</span> <span class="name">PrintChar(<span class="arg">chr</span>)`:</p>
  <span class="types_overview">`chr` is a `Character`.</span>
  Prints a single character on row `row`, column `col`.
  Adjusts internal row and column representations.

* <p><span class="type">void</span> <span class="name">PrintString(<span class="type">char*</span> <span class="arg">str</span>)`:</p>
  <span class="types_overview"><code>row</code> and <code>col</code> are `Integer`s, `str` is a `String`/`Character Array`.</span>
  Prints a string on row `row`, column `col`.
  Adjusts internal row and column representations.

## Possible additions for Console API ##

These are things that are frequently seen elsewhere, but as of now are not thought to be needed.

* <p><span class="type">void</span> <span class="name">PutChar(<span class="type">int</span> <span class="arg">row</span>, <span class="arg">col</span>, <span class="arg">chr</span>)`:</p>
  <span class="types_overview"><code>row</code> and <code>col</code> are `Integer`s, `chr` is a `Character`.</span>
  Prints a single character on row `row`, column `col`.
  *If this is added, determine whether it updates internal row/column representation*

* <p><span class="type">void</span> <span class="name">PutString(<span class="type">int</span> <span class="arg">row</span>, <span class="type">int</span> <span class="arg">col</span>, <span class="type">char*</span> <span class="arg">str</span>)`:</p>
  <span class="types_overview"><code>row</code> and <code>col</code> are `Integer`s, `str` is a `String`/`Character Array`.</span>
  Prints a string on row `row`, column `col`.
  *If this is added, determine whether it updates internal row/column representation*

