class Type
{
    Property
    {
    }
}

Type(Value)
{
    local
    global Type
    ; This should be updated when a new built-in type is added to AutoHotkey.
    static BoundFunc             := Func("Type").Bind("")
    static ComObjArrayEnumerator := ComObjArray(0x11, 1)._NewEnum()
    static ComObjectEnumerator   := ComObjCreate("Scripting.Dictionary")._NewEnum()
    static File                  := FileOpen(A_ScriptFullPath, "r")
    static Func                  := Func("Type")
    static ObjectEnumerator      := {}._NewEnum()
    static Property              := ObjRawGet(Type, "Property")
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
        else if ((TypeCode := ComObjType(Value)) != "")
        {
            Result := TypeCode & 0x2000                                             ? "ComObjArray"
                    : TypeCode & 0x4000                                             ? "ComValueRef"
                    : (TypeCode == 9 or TypeCode == 13) and ComObjValue(Value) != 0 ? (ClassName := ComObjType(Value, "Class")) != "" ? ClassName : "ComObject"
                    : "ComValue"
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
        Result := IsInteger(Value) ? "Integer"
                : IsFloat(Value)   ? "Float"
                : "String"
    }
    return Result
}
