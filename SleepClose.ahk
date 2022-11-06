#SingleInstance Force                             ; Allow only one instance off this app]
SetTitleMatchMode, 2
DetectHiddenWindows,On

global Minute := 60
global Hour := Minute * 60
Duration := Hour + Floor(Hour / 2)
Timer := Duration


FormatSeconds(Seconds)  ; Convert the specified number of seconds to hh:mm:ss format.
{
    HourRes := Floor(Seconds / Hour)

    MinuteRes := Floor((Seconds / Minute) - (HourRes * Minute))
    MinuteRes := MinuteRes < 10 ? 0 MinuteRes : MinuteRes

    SecondsRes := Seconds - (MinuteRes * Minute) - (HourRes * Hour)
    SecondsRes := SecondsRes < 10 ? 0 SecondsRes : SecondsRes

    Return HourRes ":" MinuteRes ":" SecondsRes
}

Loop, %Duration% {
   Sleep, 1000
   Timer --
   TimerString := % FormatSeconds(Timer)
   Menu, Tray, Tip, Time left: %TimerString%
}
WinClose, Crow
;RunWait taskkill /F /IM Crow.exe