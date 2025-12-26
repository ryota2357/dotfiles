#include %A_ScriptDir%\IME.ahk

; ';' と ';' を入れ替える
sc028::{
    If (GetKeyState("Shift")) {
        Send "*"
    } else {
        send "`;"
    }
}
sc027::{
    If (GetKeyState("Shift")) {
        Send "*"
    } else {
        send ":"
    }
}

; 変換・無変換キーで、かな・英数切り替え
vk1D::{
    if (IME_GET()) {
        IME_SET(0)
    }
}
vk1C::{
    if (!IME_GET()) {
        IME_SET(1)
    }
}

; Esc::{
;     if (IME_GET()) {
;         IME_SET(0)
;     }
;     Send "{Esc}"
;     return
; }
