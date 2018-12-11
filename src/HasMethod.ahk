HasMethod(Value, Name)
{
    local
    ; This should be updated when a new built-in type or method is added to
    ; AutoHotkey.
    static BuiltIns := {"BoundFunc":  {".Call":        ""}
                       ,"Enumerator": {".Next":        ""}
                       ,"File":       {".Close":       ""
                                      ,".RawRead":     ""
                                      ,".RawWrite":    ""
                                      ,".Read":        ""
                                      ,".ReadChar":    ""
                                      ,".ReadDouble":  ""
                                      ,".ReadFloat":   ""
                                      ,".ReadInt":     ""
                                      ,".ReadInt64":   ""
                                      ,".ReadLine":    ""
                                      ,".ReadShort":   ""
                                      ,".ReadUChar":   ""
                                      ,".ReadUInt":    ""
                                      ,".ReadUShort":  ""
                                      ,".Seek":        ""
                                      ,".Tell":        ""
                                      ,".Write":       ""
                                      ,".WriteChar":   ""
                                      ,".WriteDouble": ""
                                      ,".WriteFloat":  ""
                                      ,".WriteInt":    ""
                                      ,".WriteInt64":  ""
                                      ,".WriteLine":   ""
                                      ,".WriteShort":  ""
                                      ,".WriteUChar":  ""
                                      ,".WriteUInt":   ""
                                      ,".WriteUShort": ""}
                       ,"Func":       {".Bind":        ""
                                      ,".Call":        ""
                                      ,".IsByRef":     ""
                                      ,".IsOptional":  ""}
                       ,"Object":     {".Clone":       ""
                                      ,".Count":       ""
                                      ,".Delete":      ""
                                      ,".GetAddress":  ""
                                      ,".GetCapacity": ""
                                      ,".HasKey":      ""
                                      ,".Insert":      ""
                                      ,".InsertAt":    ""
                                      ,".Length":      ""
                                      ,".MaxIndex":    ""
                                      ,".MinIndex":    ""
                                      ,".Pop":         ""
                                      ,".Push":        ""
                                      ,".Remove":      ""
                                      ,".RemoveAt":    ""
                                      ,".SetCapacity": ""
                                      ,"._NewEnum":    ""}
                       ,"Property":   {}
                       ,"RegExMatch": {".Count":       ""
                                      ,".Len":         ""
                                      ,".Mark":        ""
                                      ,".Name":        ""
                                      ,".Pos":         ""
                                      ,".Value":       ""}}
    if (ComObjType(Value) != "")
    {
        throw Exception("Type Error", -1
                       ,"HasMethod(Value, Name)  Value is a COM object.")
    }
    ; This must avoid executing meta-functions.
    Result := false
    if (IsObject(Value))
    {
        CurrentObject := Value
       ,CurrentName   := Name
        while (not Result and CurrentObject != "")
        {
            ; Objects can have built-in and user-defined methods.
            if (    BuiltIns.HasKey(Type := Type(CurrentObject))
                and BuiltIns[Type].HasKey("." . CurrentName))
            {
                Result := true
            }
            else
            {
                ; ObjHasKey(Object, Key) does not throw an exception when Object
                ; is not Object-based.
                if (ObjHasKey(CurrentObject, CurrentName))
                {
                    CurrentObject := ObjRawGet(CurrentObject, CurrentName)
                   ,CurrentName   := "Call"
                }
                else
                {
                    ; This will throw an exception if Value or one of its bases
                    ; is not Object-based.
                    try
                    {
                        CurrentObject := ObjGetBase(CurrentObject)
                    }
                    catch
                    {
                        CurrentObject := ""
                    }
                }
            }
        }
    }
    else
    {
        ; Only user-defined methods are both properties and methods.
        Result := HasProp(Value.base, Name) and HasMethod(Value.base, Name)
    }
    return Result
}
