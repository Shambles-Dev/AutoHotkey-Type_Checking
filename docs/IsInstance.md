`IsInstance(Value, Class)` returns whether `Value` is an instance of `Class`.  `Class` must be a user-defined class.

This function is useful for validating [substitutability](https://en.wikipedia.org/wiki/Liskov_substitution_principle) for [subtype polymorphism](https://en.wikipedia.org/wiki/Subtyping), assuming your type hierarchy is correct.

#### Examples
```AutoHotkey
class A
{
}

class B
{
}

IsInstance(new A(), A)  ; 1
IsInstance(new A(), B)  ; 0
```
