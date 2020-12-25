================
Debugging by pdb
================

| **d(own) [count]**
| Move the current frame count (default one) levels down in the stack trace (to a newer frame).

| **u(p) [count]**
| Move the current frame count (default one) levels up in the stack trace (to an older frame).

| **s(tep)**
| Execute the current line, stop at the first possible occasion (either in a function that is called or on the next line in the current function).

| **n(ext)**
| Continue execution until the next line in the current function is reached or it returns. (The difference between next and step is that step stops inside a called function, while next executes called functions at (nearly) full speed, only stopping at the next line in the current function.)

| **r(eturn)**
| Continue execution until the current function returns.

| **c(ont(inue))**
| Continue execution, only stop when a breakpoint is encountered.

| **ll | longlist**
| List all source code for the current function or frame. Interesting lines are marked as for list.

| **! statement**
| Execute the (one-line) statement in the context of the current stack frame.

| **q(uit)**
| Quit from the debugger.
