`IsNumber(Value)` returns whether `Value` is a floating-point value or integer.

#### Examples
```AutoHotkey
A   := 1.0
B   := 2
C   := "nan"
Inf := 9.9 ** 999
NaN := Inf - Inf

IsNumber(A)    ; 1
IsNumber(B)    ; 1
IsNumber(C)    ; 0
IsNumber(Inf)  ; 1
IsNumber(NaN)  ; 1
```
