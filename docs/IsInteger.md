`IsInteger(Value)` returns whether `Value` is an integer.

#### Examples
```AutoHotkey
A   := 1.0
B   := 2
C   := "nan"
Inf := 9.9 ** 999
NaN := Inf - Inf

IsInteger(A)    ; 0
IsInteger(B)    ; 1
IsInteger(C)    ; 0
IsInteger(Inf)  ; 0
IsInteger(NaN)  ; 0
```
