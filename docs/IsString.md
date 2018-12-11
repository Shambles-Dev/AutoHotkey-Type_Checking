`IsString(Value)` returns whether `Value` is a string.

#### Examples
```AutoHotkey
A      := 1.0
B      := 2
C      := "nan"
Inf    := 9.9 ** 999
NaN    := Inf - Inf
Object := {}

IsString(A)       ; 1
IsString(B)       ; 1
IsString(C)       ; 1
IsString(Inf)     ; 1
IsString(NaN)     ; 1
IsString(Object)  ; 0
```
