#SingleInstance Force                             ; Allow only one instance off this app]
SetTitleMatchMode, 2
DetectHiddenWindows,On

global Minute := 60
global Hour := Minute * 60
Duration := Hour + Floor(Hour / 2) ; timer duration in seconds
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
WinClose, Crow ; try to close app to make sure it saves it's status on close
sleep, 5000
run, taskkill /f /im Crow.exe ; kill process to make sure task is killed