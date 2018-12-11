class _Type
{
    Property
    {
    }
}

Type(Value)
{
    local
    global _Type
    ; This should be updated when a new built-in type is added to AutoHotkey.
    static BoundFunc             := Func("Type").Bind("")
    static ComObjArrayEnumerator := ComObjArray(0x11, 1)._NewEnum()
    static ComObjectEnumerator   := ComObjCreate("Scripting.Dictionary")._NewEnum()
    static File                  := FileOpen(A_ScriptFullPath, "r")
    static Func                  := Func("Type")
    static ObjectEnumerator      := {}._NewEnum()
    static Property              := ObjRawGet(_Type, "Property")
    static RegExMatch, _         := RegExMatch("a" ,"O)a", RegExMatch)
    ; If you try to convert the above to expressions and get the addresses, the
    ; result is incorrect.
    static TypeFromAddress := {NumGet(&BoundFunc):             "BoundFunc"
                              ,NumGet(&ComObjArrayEnumerator): "Enumerator"
                              ,NumGet(&ComObjectEnumerator):   "Enumerator"
                              ,NumGet(&File):                  "File"
                              ,NumGet(&Func):                  "Func"
                              ,NumGet(&ObjectEnumerator):      "Enumerator"
                              ,NumGet(&Property):              "Property"
                              ,NumGet(&RegExMatch):            "RegExMatch"}
    if (IsObject(Value))
    {
        if (TypeFromAddress.HasKey(NumGet(&Value)))
        {
            Result := TypeFromAddress[NumGet(&Value)]
        }
        else if (ComObjType(Value) != "")
        {
            if (ComObjType(Value) & 0x2000)
            {
                Result := "ComObjArray"
            }
            else if (ComObjType(Value) & 0x4000)
            {
                Result := "ComObjRef"
            }
            else if (    (ComObjType(Value) == 9 or ComObjType(Value) == 13)
                     and ComObjValue(Value) != 0)
            {
                Result := ComObjType(Value, "Class") != "" ? ComObjType(Value, "Class")
                        : "ComObject"
            }
            else
            {
                Result := "ComObj"
            }
        }
        else
        {
            ; This must avoid executing meta-functions.
            Result        := ObjHasKey(Value, "__Class") ? "Class" : ""
           ,CurrentObject := ObjGetBase(Value)
            while (Result == "" and CurrentObject != "")
            {
                ; This will throw an exception if one of Value's bases is not
                ; Object-based.
                try
                {
                    Result        := ObjRawGet(CurrentObject, "__Class")
                   ,CurrentObject := ObjGetBase(CurrentObject)
                }
                catch
                {
                    CurrentObject := ""
                }
            }
            Result := Result == "" ? "Object" : Result
        }
    }
    else
    {
        Result := IsFloat(Value)   ? "Float"
                : IsInteger(Value) ? "Integer"
                : "String"
    }
    return Result
}
