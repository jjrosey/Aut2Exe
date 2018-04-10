Global $oDictionary, $oMyError

_Main()

Func _Main()
    ; Create dictionary object
    $oDictionary = _InitDictionary()
    $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")    ; Initialize a COM error handler

    Local $vKey, $sItem, $sMsg

    ; Add keys with items
    _DebugPrint('_AddItem("One", "Same")' & @TAB & _AddItem("One", "Same"))
    _DebugPrint('_AddItem("Two", "Car")' & @TAB & _AddItem("Two", "Car"))
    _DebugPrint('_AddItem("Three", "House")' & @TAB & _AddItem("Three", "House"))
    _DebugPrint('_AddItem("Three", "House")' & @TAB & _AddItem("Three", "House"))
    _DebugPrint('_AddItem("Four", "Boat")' & @TAB & _AddItem("Four", "Boat"))

    If _ItemExists('One') Then
        ; Display item
        MsgBox(0x0, 'Item One', _Item('One'), 2)
        ; Set an item
        _ChangeItem('One', 'Changed')
        ; Display item
        MsgBox(0x20, 'Did Item One Change?', _Item('One'), 3)
        ; Remove key
        _ItemRemove('One')
        ;
    EndIf

    ; Store items into a variable
    For $vKey In $oDictionary
        $sItem &= $vKey & " : " & _Item($vKey) & @CRLF
    Next

    ; Display items
    MsgBox(0x0, 'Items Count: ' & _ItemCount(), $sItem, 3)

    ; Add items into an array
    $aArray = _GetItems()

    ; Display items in the array
    For $i = 0 To _ItemCount() - 1
        MsgBox(0x0, 'Array [ ' & $i & ' ]', $aArray[$i], 2)
    Next

    _DebugPrint('_ItemRemove("Two")' & @TAB & _ItemRemove("Two"))
    _DebugPrint('_ItemRemove("Three")' & @TAB & _ItemRemove("Three"))
    _DebugPrint('_ItemRemove("Three")' & @TAB & _ItemRemove("Three"))
    _DebugPrint('_ItemRemove("Four")' & @TAB & _ItemRemove("Four"))

    ; use keys like an array index
    For $x = 1 To 3
        _AddItem($x, "")
    Next
    $sItem = ""
    _ChangeItem(2, "My Custom Item")
    _ChangeItem(1, "This is the 1st item")
    _ChangeItem(3, "This is the last item")
    For $vKey In $oDictionary
        $sItem &= $vKey & " : " & _Item($vKey) & @CRLF
    Next
    ; Display items
    MsgBox(0x0, 'Items Count: ' & _ItemCount(), $sItem, 3)

    $sItem = ""
    
    _ChangeKey(2, "My New Key")
    For $vKey In $oDictionary
        $sItem &= $vKey & " : " & _Item($vKey) & @CRLF
    Next
    ; Display items
    MsgBox(0x0, 'Items Count: ' & _ItemCount(), $sItem, 3)
    
    $oDictionary.RemoveAll()
    MsgBox(0x0, 'Items Count',_ItemCount(), 3)
    

EndFunc   ;==>_Main

Func _InitDictionary()
    Return ObjCreate("Scripting.Dictionary")
EndFunc   ;==>_InitDictionary

; Adds a key and item pair to a Dictionary object.
Func _AddItem($v_key, $v_item)
    $oDictionary.ADD ($v_key, $v_item)
    If @error Then Return SetError(1, 1, -1)
EndFunc   ;==>_AddItem

; Returns true if a specified key exists in the Dictionary object, false if it does not.
Func _ItemExists($v_key)
    Return $oDictionary.Exists ($v_key)
EndFunc   ;==>_ItemExists

; Returns an item for a specified key in a Dictionary object
Func _Item($v_key)
    Return $oDictionary.Item ($v_key)
EndFunc   ;==>_Item

; Sets an item for a specified key in a Dictionary object
Func _ChangeItem($v_key, $v_item)
    $oDictionary.Item ($v_key) = $v_item
EndFunc   ;==>_ChangeItem

; Sets a key in a Dictionary object.
Func _ChangeKey($v_key, $v_newKey)
    $oDictionary.Key ($v_key) = $v_newKey
EndFunc   ;==>_ChangeKey

; Removes a key, item pair from a Dictionary object.
Func _ItemRemove($v_key)
    $oDictionary.Remove ($v_key)
    If @error Then Return SetError(1, 1, -1)
EndFunc   ;==>_ItemRemove

; Returns the number of items in a collection or Dictionary object.
Func _ItemCount()
    Return $oDictionary.Count
EndFunc   ;==>_ItemCount

; Returns an array containing all the items in a Dictionary object
Func _GetItems()
    Return $oDictionary.Items
EndFunc   ;==>_GetItems

; This is my custom defined error handler
Func MyErrFunc()
    Local $err = $oMyError.number
    If $err = 0 Then $err = -1
    SetError($err)  ; to check for after this function returns
EndFunc   ;==>MyErrFunc

Func _DebugPrint($s_Text)
    ConsoleWrite( _
            "!===========================================================" & @LF & _
            "+===========================================================" & @LF & _
            "-->" & $s_Text & @LF & _
            "+===========================================================" & @LF)
EndFunc   ;==>_DebugPrint


