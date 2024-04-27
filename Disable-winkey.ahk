#Requires AutoHotkey v2.0
#SingleInstance Force
; v1 [Laptop HQ] @xMaxrayx @Unbreakable-ray [Code : ReBorn]   at 12:35:16  on 24/4/2024   (24H Format)  (UTC +2) 	 {Can we prove we are stronger than before?}
; v1.5 [Laptop HQ] @xMaxrayx @Unbreakable-ray [Code : ReBorn]   at 10:20:40  on 25/4/2024   (24H Format)  (UTC +2) 	 {Can we prove we are stronger than before?}


InstallKeybdHook(1,1)


global EnableDebug := 0

global defaultWinBindKey:= "{F1}"
global timeWait := 0.5
global nonVisibleKeyList := ["Enter" , "Left" , "Right" , "UP" , "Down", "Backspace" , "Shift" ]
global longTimePress := "{blind}{LWin}"
global winHoldDownTime := 5


WinActivate("Untitled - Notepad")

LWin::{

    fasterDefaultWinBindKey() ;test for faster bind   


    WinKeyDown_status := GetKeyState("Lwin" , "P") ; sotted to "P" because the hook mode
    
    if WinKeyDown_status == 1{ 

        afterWinKey := InputHook()
        afterWinKey.KeyOpt("{ALL}", "E N")
        afterWinKey.KeyOpt("{LCtrl}{RCtrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}", "-E") ;{LWin}{RWin}
        
        
        afterWinKey.Start()
        ; fasterDefaultWinBindKey() ;test for faster bind ;disabled for better solution X12a
                
        ;   SetTimer fasterDefaultWinBindKey_timer  disabled for better solution 
        
        
        
        afterWinKey.Wait(0.1)
        global winHoldDownTime
        global i := 0                                                                                      ;solution X12a
        while (GetKeyState("LWin" ,"P") == 1) && afterWinKey.EndKey == "" && winHoldDownTime > i  {                  ;solution X12a
            afterWinKey.Wait(0.1)
            i++                                                                                   ;solution X12a
        }
        
        if i >= winHoldDownTime
            {   
                msgdebug("long key mode`n" ThisHotkey "`n" GetKeyState("LWin" ,"P"))
                SendInput longTimePress
                KeyWait("LWin", "L")
                while  GetKeyState("LWin" ,"P")==1{
                    if  GetKeyState("LWin" ,"P")==0 
                        {   
                            msgdebug("exit whole winkey")
                            exit
                        }
                }
                Exit
                ; MsgBox
                ; exit ;issue bug-001
            }
        ; MsgBox "ss"
        
    msgdebug("Not long mode")


        winKeyCombo := afterWinKey.EndKey afterWinKey.EndMods

        fasterDefaultWinBindKey() ;test for faster bind

        switch winKeyCombo {
            case "r":
                SendInput "{Lwin Down}{r}{LWin UP}"
                exit
            case "":

                if i >= winHoldDownTime
                    {   
                        
                        ; MsgBox "you hold down the win key key without pressing another key :3 <3"
                        SendInput(longTimePress)
                        exit
                }

                else {
                    SendInput(defaultWinBindKey)
                    exit
                }
                
                return
            case "Space":

                msgdebug("is win key is down"  GetKeyState("LWin" ,"P"))
              
                msgdebug("you pressed space key !!! ^^")

                exit

            default:

                msgdebug("this A_ahk: " A_ThisHotkey)
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
                exit
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


    fasterDefaultWinBindKey(){ ;removed for better solution
        ; if GetKeyState("Lwin" , "P") == 0{
        ; SendInput(defaultWinBindKey)
        ; Exit
        ; }
    }

    fasterDefaultWinBindKey_timer(){
        L := 1
        while L == 1 {

        

        if GetKeyState("Lwin" , "P") == 0{
        ;SendInput(defaultWinBindKey)
        ; MsgBox "set timer winsattus :" GetKeyState("Lwin" , "P")
        SetTimer , 0
        Exit 
        }else{
            ; MsgBox "E12: " GetKeyState("Lwin" , "P")    
        }
        }
}


}



msgdebug(Text){
    EnableDebug  ?? true

    if EnableDebug == true {
        MsgBox(text)
    }

}