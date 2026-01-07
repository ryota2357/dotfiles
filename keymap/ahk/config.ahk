#Requires AutoHotkey v2.0

#include %A_ScriptDir%\capslock.ahk
#include %A_ScriptDir%\complex.ahk

; - → _ 、^ → _ 、\ → 、
-::SendText "_"
@::SendText "-"
_::SendText "@"

^q::!F4
RShift & Tab::AltTab

+8::'
+9::(
+0::)
