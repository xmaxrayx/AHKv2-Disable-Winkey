#Requires AutoHotkey v2.0

c::
KeyWinC(ThisHotkey)  ; This is a named function hotkey.
{
    static winc_presses := 0
    if winc_presses > 0 ; SetTimer already started, so we log the keypress instead.
    {
        winc_presses += 1
        return
    }
    ; Otherwise, this is the first press of a new series. Set count to 1 and start
    ; the timer:
    winc_presses := 1
    SetTimer After400, -400 ; Wait for more presses within a 400 millisecond window.

    After400()  ; This is a nested function.
    {
        if winc_presses = 1 ; The key was pressed once.
        {
            MsgBox "one" ; Open a folder.
        }
        else if winc_presses = 2 ; The key was pressed twice.
        {
            ; Run "m:\multimedia"
            MsgBox "tow"  ; Open a different folder.
        }
        else if winc_presses > 2
        {

             MsgBox "Three or more clicks detected."
        }
        ; Regardless of which action above was triggered, reset the count to
        ; prepare for the next series of presses:
        winc_presses := 0
    }
}



t::{
    counter := SecondCounter()
    SecondCounter.Start
    Sleep 5000
    SecondCounter.Stop
    Sleep 2000
    
}

class SecondCounter {
    __New() {
        this.interval := 1000
        this.count := 0
        ; Tick() has an implicit parameter "this" which is a reference to
        ; the object, so we need to create a function which encapsulates
        ; "this" and the method to call:
        this.timer := ObjBindMethod(this, "Tick")
    }
    Start() {
        SetTimer this.timer, this.interval
        ToolTip "Counter started"
    }
    Stop() {
        ; To turn off the timer, we must pass the same object as before:
        SetTimer this.timer, 0
        ToolTip "Counter stopped at " this.count
    }
    ; In this example, the timer calls this method:
    Tick() {
        ToolTip ++this.count
    }
}