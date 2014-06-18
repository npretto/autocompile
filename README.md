autocompile
===========

I tested this only on windows, it may work on linux using mono (it uses hxcs)

##How to use
Compile the project, rename the executable to "autocompile.exe" and add it to your path

``` autocompile path/to/your/compile.hxml ```

It will parse your hxml file for the first -cp folder, check for changes in that folder and call ``` haxe path/to/your/compile.hxml ``` every time a file is changed

By default, the flashdevelop projects runs the program on the project in ```test/``` which uses live.js to change what happens when you click on a button
