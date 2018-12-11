`IsFloat(Value)` returns whether `Value` is a floating-point value.

It returns `true` for `-inf`, `inf`, and `nan`.  AutoHotkey does not have literals for these values, but calculations can produce them.

#### Examples
```AutoHotkey
A   := 1.0
B   := 2
C   := "nan"
Inf := 9.9 ** 999
NaN := Inf - Inf

IsFloat(A)    ; 1
IsFloat(B)    ; 0
IsFloat(C)    ; 0
IsFloat(Inf)  ; 1
IsFloat(NaN)  ; 1
```
