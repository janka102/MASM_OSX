# MASM on OS X

Use Xcode or Visual Studio Code to edit, compile, and debug MASM assembly files.

Tested and working in Xcode versions [5, 6, and 7](https://github.com/janka102/MASM_OSX/issues/1). Version 9 works with a [small fix for using breakpoints](https://github.com/janka102/MASM_OSX/issues/4).

Made possible thanks to [JWasm](https://github.com/JWasm/JWasm) and [objconv](https://github.com/vertis/objconv). This also includes support for the Irvine library as provide by [Along32](http://sourceforge.net/projects/along32).

*NOTE: This is not guaranteed to work 100% with MASM and/or the Irvine library. Just because your program works in Xcode does not guarantee it will work in Visual Studio, and vice versa. Always test in Visual Studio before submitting final work. Saying that, if you have any problems, please open an issue here on GitHub.*

## Instructions

### Xcode

1. Open `MASM_OSX.xcodeproj` in Xcode
2. Create new file
    - File > New > File... ⌘N
    - OS X > Other > Empty
    - Name the file *.asm
3. Write some MASM code
    - There is a provided template that has the Irvine library `Include`d.
4. Build it
    - Product > Build ⌘B
5. Change which file to run/debug
    - Product > Scheme > Edit Scheme... ⌘<
    - Select "Run" on the left side
    - On the right, select the "Info" section
    - Click the "Executable" dropdown and select "Other..."
        - Navigate to the project folder
        - The executables are located under the "bin" folder
6. Run/Debug it
    - Change to 32-bit mode
        - In the title bar, next to "MASM_OSX", click "My Mac (64-bit)"
        - Change it to "My Mac (32-bit)"
    - Product > Run ⌘R
    - There is a default breakpoint on the "main" procedure
        - The debugger will open automatically

### Visual Studio Code

1. Open this folder in VS Code
2. Create new file
    - File > New File ⌘N
    - Save and name the file *.asm
3. Write some MASM code
    - There is a provided template that has the Irvine library `Include`d.
4. Build current file (⇧⌘B)
    - Make sure the file is the active tab
    - View > Command Palette... ⇧⌘P
        - Search for "build"
        - Tasks: Run Build Task ⇧⌘B
6. Run/Debug current file (F5)
    - View > Debug Console ⇧⌘Y
        - Type `-exec help` to learn more about how to use the console debugger
        - `-exec di` to see the current function's instructions
    - There is a default breakpoint on the "main" procedure

## Known Issues

- Can't have the first value in `.data` be uninitialized. Thank you [@shankwiler](https://github.com/shankwiler) for finding this.  
    You will get an error like `bin/template.asm : Error A2168: General Failure`. This is an issue with JWasm and outputting to the ELF format. The easiest workaround would be to add other data before the first uninitialized value. If you don't have any other data to put before, you have to make up dummy data like `_ byte 0`. Here's a minimal example:
    ```asm
    Include Irvine32.inc
    .data
    val byte ? ; Needs to be preceeded by some initialized value, ex. _ byte 0

    .code
    main proc
      exit
    main endp
    end main
    ```
- In Xcode version 9 the default `main` breakpoint may not work. Check out [issue #4](https://github.com/janka102/MASM_OSX/issues/4) for a resolution.
