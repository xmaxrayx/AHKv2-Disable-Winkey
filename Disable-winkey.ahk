#Requires AutoHotkey v2.0
#SingleInstance Force
; v1 [Laptop HQ] @xMaxrayx @Unbreakable-ray [Code : ReBorn]   at 12:35:16  on 24/4/2024   (24H Format)  (UTC +2) 	 {Can we prove we are stronger than before?}
; v1.5 [Laptop HQ] @xMaxrayx @Unbreakable-ray [Code : ReBorn]   at 10:20:40  on 25/4/2024   (24H Format)  (UTC +2) 	 {Can we prove we are stronger than before?}


InstallKeybdHook(1,1)


global EnableDebug := 1


global defaultWinBindKey:= "{F1}"
global timeWait := 0.5
global nonVisibleKeyList := ["Enter" , "Left" , "Right" , "UP" , "Down", "Backspace" , "Shift" ]




WinActivate("Untitled - Notepad")

LWin::{
    afterWinKey := InputHook()
    afterWinKey.KeyOpt("{ALL}", "E N")
    afterWinKey.KeyOpt("{LCtrl}{RCtrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}", "-E") ;{LWin}{RWin}
    afterWinKey.Start()
    afterWinKey.Wait(timeWait)
    winKeyCombo := afterWinKey.EndKey afterWinKey.EndMods

    WinKeyDown_status := GetKeyState("Lwin" , "P") ; sotted to "P" because the hook mode

    ;MsgBox WinKeyDown_status ;for debug
    
    if WinKeyDown_status == 1{ 
        switch winKeyCombo {
            case "r":
                SendInput "{Lwin Down}{r}{LWin UP}"
                return
            case "":
                MsgBox "you hold down the win key key without pressing another key :3 <3"
                return
            case "Space":
                MsgBox "is win key is down"  GetKeyState("LWin" ,"P")
                MsgBox "you pressed space key !!! ^^"

                return

            default:

                
                local EndKey__Clean := afterWinKey.EndKey
                global nonVisibleKeyList 
                loop nonVisibleKeyList.Length{
                    EndKey__Clean := RegExReplace(EndKey__Clean, "i)" . nonVisibleKeyList[A_Index]  , ('{' . nonVisibleKeyList[A_Index] . '}')) 
                }

                if EnableDebug == 1 {

                    MsgBox( "you pressed " winKeyCombo
                    "`n" 'is win pressed ' isWinKeyDown_status__string() '`n Realtime winkey down :'  GetKeyState("LWin" ,"P")
                    "`nEnd__clean value :" EndKey__Clean
                    )
                    return

                }
                
                ; EndKey__Clean := RegExReplace(EndKey__Clean, "i)enter" ,"{Enter}")
                ; EndKey__Clean := RegExReplace(EndKey__Clean, "i)left" ,"{}")
                ;to see if there something wrong with your combo shortcut
                SendInput(EndKey__Clean) ; need "" to convert non-visable key like enter
                return
            }
    

        isWinKeyDown_status__string(*){
            local WinStatus__string := unset
            switch GetKeyState("LWin" ,"P"){
                case 0:
                    WinStatus__string := "No"
                case 1:
                    WinStatus__string := "Yes"
                default: 
                    WinStatus__string := "Unknown"
            }
            return "is win key is down? :"  . WinStatus__string
        }
        ;break ;safe code to do the  defoult bind
    }
    else {
        SendInput(defaultWinBindKey)
    }


}
