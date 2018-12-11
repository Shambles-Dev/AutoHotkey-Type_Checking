HasProp(Value, Name)
{
    local
    ; This should be updated when a new built-in type or property is added to
    ; AutoHotkey.
    static BuiltIns := {"BoundFunc":  {}
                       ,"Enumerator": {}
                       ,"File":       {".AtEOF":      ""
                                      ,".Encoding":   ""
                                      ,".Length":     ""
                                      ,".Pos":        ""
                                      ,".Position":   ""
                                      ,".__Handle":   ""}
                       ,"Func":       {".IsBuiltIn":  ""
                                      ,".IsVariadic": ""
                                      ,".MaxParams":  ""
                                      ,".MinParams":  ""
                                      ,".Name":       ""}
                       ,"Object":     {}
                       ,"Property":   {}
                       ,"RegExMatch": {}}
    if (ComObjType(Value) != "")
    {
        throw Exception("Type Error", -1
                       ,"HasProp(Value, Name)  Value is a COM object.")
    }
    ; This must avoid executing meta-functions.
    Result := false
    if (Name = "base")
    {
        if (IsObject(Value))
        {
            ; This will throw an exception if Value is not Object-based.
            try
            {
                ObjGetBase(Value)
               ,Result := true
            }
            catch
            {
            }
        }
        else
        {
            Result := true
        }
    }
    else
    {
        CurrentObject := IsObject(Value) ? Value : Value.base
        while (not Result and CurrentObject != "")
        {
            ; Objects can have built-in and user-defined properties.
            if (    BuiltIns.HasKey(Type := Type(CurrentObject))
                and BuiltIns[Type].HasKey("." . Name))
            {
                Result := true
            }
            else
            {
                ; This will throw an exception if Value or one of its bases is
                ; not Object-based.
                try
                {
                    ; ObjHasKey(Object, Key) returns the empty String when Object
                    ; is not Object-based.
                    Result        := ObjHasKey(CurrentObject, Name) ? true : false
                   ,CurrentObject := ObjGetBase(CurrentObject)
                }
                catch
                {
                    CurrentObject := ""
                }
            }
        }
    }
    return Result
}
