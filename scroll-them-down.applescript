property name : "scroll-them-down"

on test()
    display dialog "test"
end test

on run {input, parameters}
    set keyCode to 121  -- fn + down
    try
        set homeFolder to path to home folder as string
        set apps to paragraphs of (read file (homeFolder & "etc:apps.txt"))
        set app1 to item 1 of apps
        set app2 to item 2 of apps

        repeat with i from 2 to length of apps
            set theApp to item i of apps
            tell application "Finder"
                set processList to the name of every process whose visible is true
            end tell

            repeat with processName in processList
                if processName contains theApp then
                    tell application processName
                        activate
                        tell application "System Events"
                            delay 0.1
                            key code keyCode
                        end tell
                    end tell
                end if
            end repeat

        end repeat

        tell application app1 to activate

        return input

    on error errStr number errorNumber
        display dialog errStr
        error errStr number errorNumber
    end try

end run
