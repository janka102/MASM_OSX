# MASM on OS X

Use Xcode to edit, compile, and debug MASM assembly files. Tested and working in Xcode [5, 6, and 7](https://github.com/janka102/MASM_OSX/issues/1).

Made possible thanks to [JWasm](https://github.com/JWasm/JWasm) and [objconv](https://github.com/vertis/objconv). This also includes support for the Irvine library as provide by [Along32](http://sourceforge.net/projects/along32).

*NOTE: This is not guaranteed to work 100% with MASM and/or the Irvine library. Just because your program works in Xcode does not guarantee it will work in Visual Studio, and visa versa. Always test in Visual Studio before submitting final work. Saying that, if you have any problems, please open an issue here on GitHub.*

## Instructions

- Create new file
    - File > New > File... ⌘N
    - OS X > Other > Empty
    - Name the file *.asm
- Write some masm code
    - There is a provided template that has the Irvine library included.
- Build it
    - Product > Build ⌘B
- Change which file to run/debug
    - Product > Scheme > Edit Scheme... ⌘<
    - Select "Run" on the left side
    - On the right, select the "Info" section
    - Click the "Executable" dropdown and select "Other..."
        - Navigate to the project folder
        - The executables are located under the "bin" folder
- Run/Debug it
    - Change to 32-bit mode
        - In the title bar, next to "MASM_OSX", click "My Mac (64-bit)"
        - Change it to "My Mac (32-bit)"
    - Product > Run ⌘R
    - There is a default breakpoint on the "main" procedure
        - The debugger will open automatically
