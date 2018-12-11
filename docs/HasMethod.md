`HasMethod(Value, Name)` returns whether `Value` has a method identified by `Name`.  `Value` must not be a COM object.

If `Value` is a primitive (Number or String) type, it will examine the [default base object](https://www.autohotkey.com/docs/Objects.htm#Default_Base_Object).

It can recognize methods identified by objects.

This function is useful for validating [interfaces](https://en.wikipedia.org/wiki/Interface_(computing)#In_object-oriented_languages) for [ad hoc polymorphism](https://en.wikipedia.org/wiki/Ad_hoc_polymorphism).

#### Examples
```AutoHotkey
Object := {}

F(this)
{
}

HasMethod(Func("HasMethod"), "Call")      ; 1
HasMethod([], "_NewEnum")                 ; 1
HasMethod(0, "Wrong")                     ; 0
HasMethod({(Object): Func("F")}, Object)  ; 1
```
