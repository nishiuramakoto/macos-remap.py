on sendKeyToNonActiveWindows(keyCode)
    local frontMostProcess

    tell application "System Events"
        repeat with theProcess in processes
            if not background only of theProcess then
                tell theProcess
                    set processName to name
                    set theWindows to windows
                    set isFrontMost to frontmost
                end tell
                set windowsCount to count of theWindows

                if isFrontMost then
                    set frontMostProcess to theProcess
                    -- say "found frontmost process " & processName
                else if windowsCount is greater than 0 then
                    -- say processName
                    -- say windowsCount as text
                    -- say isFrontMost  as text

                    repeat with theWindow in theWindows
                        -- say "found a window of " & processName
                        tell theProcess
                            set frontmost to true
                            tell theWindow
                                key code keyCode
                            end tell
                        end tell
                    end repeat
                end if
            end if
        end repeat
    end tell

    tell application "System Events" to tell frontMostProcess to set frontmost to true
end sendKeyToNonActiveWindows
