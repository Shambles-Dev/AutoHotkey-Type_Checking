`HasProp(Value, Name)` returns whether `Value` has a property identified by `Name`.  `Value` must not be a COM object.

If `Value` is a primitive (Number or String) type, it will examine the [default base object](https://www.autohotkey.com/docs/Objects.htm#Default_Base_Object).

It can recognize properties identified by objects.

This function is useful for validating [interfaces](https://en.wikipedia.org/wiki/Interface_(computing)#In_object-oriented_languages) for [ad hoc polymorphism](https://en.wikipedia.org/wiki/Ad_hoc_polymorphism).

#### Examples
```AutoHotkey
Object := {}

HasProp({}, "X")                ; 0
HasProp({"X": 1}, "X")          ; 1
HasProp(0, "base")              ; 1
HasProp({(Object): 1}, Object)  ; 1
HasProp({{}: 1}, Object)        ; 0
```
