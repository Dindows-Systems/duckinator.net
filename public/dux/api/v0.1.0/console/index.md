# Dux API #

## Console API ##

For these, you explicitly specify the row and column to start printing from.
These *should be stored internally* for use from the [Relative Positioning](#relative_positioning) functions.

* <span class="type">void</span> <span class="name">MoveCursor</span>(<span class="type">int</span> <span class="arg">row</span>, <span class="ret">int</span> <span class="arg">col</span>):
  <span class="types_overview">`row` and `col` are `Integer`s.</span>
  Places the cursor on row `row`, column `col`.

* <span class="type">void</span> <span class="name">PrintChar(<span class="arg">chr</span>)`:
  <span class="types_overview">`chr` is a `Character`.</span>
  Prints a single character on row `row`, column `col`.
  Adjusts internal row and column representations.

* <span class="type">void</span> <span class="name">PrintString(<span class="type">char*</span> <span class="arg">str</span>)`:
  <span class="types_overview">`row` and `col` are `Integer`s, `str` is a `String`/`Character Array`.</span>
  Prints a string on row `row`, column `col`.
  Adjusts internal row and column representations.

## Possible additions for Console API ##

These are things that are frequently seen elsewhere, but as of now are not thought to be needed.

* <span class="type">void</span> <span class="name">PutChar(<span class="type">int</span> <span class="arg">row</span>, <span class="arg">col</span>, <span class="arg">chr</span>)`:
  <span class="types_overview">`row` and `col` are `Integer`s, `chr` is a `Character`.</span>
  Prints a single character on row `row`, column `col`.
  *If this is added, determine whether it updates internal row/column representation*

* <span class="type">void</span> <span class="name">PutString(<span class="type">int</span> <span class="arg">row</span>, <span class="type">int</span> <span class="arg">col</span>, <span class="type">char*</span> <span class="arg">str</span>)`:
  <span class="types_overview">`row` and `col` are `Integer`s, `str` is a `String`/`Character Array`.</span>
  Prints a string on row `row`, column `col`.
  *If this is added, determine whether it updates internal row/column representation*

