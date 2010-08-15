## Dux's <abbr title="User Interface">UI</abbr> ##

The UI design I came up took ideas from VIM<sup><a href="#f1">[1]</a></sup>, AutoCAD<sup><a href="#f1">[1]</a></sup>, and Mac OS<sup><a href="#f1">[1]</a></sup>.
If you are in *command mode*, the `insert` key puts you in *input mode* which lets you directly interact with the program.
If you are in *input mode*, the `escape` key puts you in *command mode* which lets you type commands in the command box and run them.

### Input mode ###

Input mode lets you directly interact with the program. Unless specified through some special thing I have yet to devise, the `insert` key will always put you in *input mode*.

### Command mode ###

In command mode, you can send commands to the program (In the [quick mockup of the UI](/dux/ui/01_main.png) you can see a demonstration of using a text editor) by typing them and hitting enter.
Unless specified through aforementioned special thing I have yet to devise, the `escape` key will always place you in *command mode*.

### Menus ###

There are 3 menus in the top bar. **Dux**, **Windows**, and the *current program* menus.

*  The [**Dux** menu](/dux/ui/02_dux_menu.png) is normal system administration.
*  The [**Windows** menu](/dux/ui/03_windows_menu.png) is a list of open windows, and lets you switch between them.
*  The [*current program* menu](/dux/ui/04_text_editor_menu.png) is a menu with options specific to the current program that is open. The name of this menu matches the program you are using.

## Footnotes ##

 <sup id="f1">1</sup>  I am not affiliated with any of the VIM developers, AutoDesk, or Apple.  At all.
