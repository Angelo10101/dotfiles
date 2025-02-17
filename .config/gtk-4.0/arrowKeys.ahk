#Requires AutoHotkey v2+

*CapsLock::caps_control.double_tap_check(),KeyWait('CapsLock')
*CapsLock Up::caps_control.mod_key_check()

#HotIf caps_control.caps_is_held()
; Modifiers
a::Shift
s::Control
d::Alt

; Navigation
i::Up       ; Arrows
j::Left     ; Arrows
k::Down     ; Arrows
l::Right    ; Arrows
u::PgUp     ; u = up
o::PgDn
,::Home     ; < points to home
.::End      ; > points to end

; Edit
`;::Delete
'::BackSpace

; Rapid fire
*LButton::caps_control.spam('Click')
#HotIf

#If GetKeyState("CapsLock", "P")  ; Only enable the hotkey if Caps Lock is pressed

CapsLock & Escape::Send, ^`

#If

class caps_control {
    static double_tap_time := 400
        , spam_delay := 50
        , last_cap_tap := 0
        , mod_symbols := '#!^+&<>*~$'
        , mod_key_arr := ['Control', 'Alt', 'Shift', 'LWin', 'RWin']
    
    static __New() {
        A_HotkeyInterval := 300
        SetCapsLockState('AlwaysOff')
    }
    
    static double_tap_check() {
        if (A_TickCount - this.last_cap_tap < this.double_tap_time)
            this.toggle_caps_state()
            ,this.last_cap_tap := 0
        else this.last_cap_tap := A_TickCount
    }
    
    static toggle_caps_state() {
        state := GetKeyState('CapsLock', 'T') ? 'AlwaysOff' : 'AlwaysOn'
        ,SetCapsLockState(state)
    }
    
    static mod_key_check() {
        for key in this.mod_key_arr
            if !GetKeyState(key, 'P') && GetKeyState(key)
                Send('{' key ' Up}')
    }
    
    static spam(send_key, hold_key:=A_ThisHotkey) {
        Send('{' send_key '}')
        ,hold_key := this.strip_mods(hold_key)
        if GetKeyState(hold_key, 'P')
            callback := ObjBindMethod(this, 'spam', send_key, hold_key)
            ,SetTimer(callback, this.spam_delay * -1)
    }
    
    static strip_mods(hk) {
        While (InStr(this.mod_symbols, SubStr(hk, 1, 1)) && StrLen(hk) > 1)
            hk := SubStr(hk, 2)
        return hk
    }
    
    static caps_is_held() => GetKeyState('CapsLock', 'P')
}