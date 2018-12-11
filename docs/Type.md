`Type(Value)` returns the type name of `Value`.

This function is useful for reporting type errors and dispatching in the face of AutoHotkey v1’s incorrect type hierarchy and inconsistent interfaces.

#### Examples
```AutoHotkey
A := 1.0
B := 2
C := "nan"

Type(A)  ; "Float"
Type(B)  ; "Integer"
Type(C)  ; "String"
```
