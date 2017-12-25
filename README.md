# vcpkg_extras
Custom ports for vcpkg:

- re2c - Lexer generator tool
- lemon - Parser generator tool
- portmidi - I/O library for MIDI
- jack2 - headers for JACK on Windows
- soundtouch - Audio stretching library
- zidl - Interface code/documentation generator tool
- dbgenpp - Sqlite/C++ code generator tool
- buzz-dsplib - DSP library for authoring Jeskola Buzz machines


To make the above packages available on AppVeyor, use the following in the "Init" or "Before build" script:

```bat
curl -fsSL -o %TEMP%\vcpkg_extras-master.zip https://github.com/clvn/vcpkg_extras/archive/master.zip
7z x %TEMP%\vcpkg_extras-master.zip -o%TEMP%
xcopy /e /y /i %TEMP%\vcpkg_extras-master\ports\*.* c:\tools\vcpkg\ports
set PATH=%PATH%;c:\tools\vcpkg\installed\x86-windows\tools
```


Then use vcpkg in the "Before build" script - after the build/package cache has been restored. F.ex:

```bat
vcpkg install re2c:x86-windows lemon:x86-windows
```
