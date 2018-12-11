IsInstance(Value, Class)
{
    local
    if (not (Type := Type(Class)) == "Class")
    {
        throw Exception("Type Error", -1
                       ,Format("IsInstance(Value, Class)  Class is not a Class.  Class's type is {1}.", Type))
    }
    ; This must avoid executing meta-functions.
    Result := false
    ; This will throw an exception if Value or one of its bases is not
    ; Object-based.
    try
    {
        CurrentObject := ObjGetBase(Value)
    }
    catch
    {
        CurrentObject := ""
    }
    while (not Result and CurrentObject != "")
    {
        try
        {
            Result        := CurrentObject == Class
           ,CurrentObject := ObjGetBase(CurrentObject)
        }
        catch
        {
            CurrentObject := ""
        }
    }
    return Result
}
