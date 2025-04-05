^+t::
IfWinExist ahk_class CabinetWClass  ; Check if File Explorer is open
{
    Send, !{F10}  ; Press ALT + F10 to focus on the File Menu
    Sleep, 100
    Send, r  ; Press 'r' to trigger the context menu item for Open in Terminal (adjust if necessary)
}
return
