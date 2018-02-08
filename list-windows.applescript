

on convertListToString(theList, theDelimiter)
    set AppleScript's text item delimiters to theDelimiter
    set theString to theList as string
    set AppleScript's text item delimiters to ""
    return theString
end convertListToString

on GetApplicationCorrespondingToProcess(process_name)
    tell application "System Events"
        set process_bid to get the bundle identifier of process process_name
        set application_name to file of (application processes where bundle identifier is process_bid)
    end tell
    return application_name
end GetApplicationCorrespondingToProcess

on GetFrontmostApplicationNameCorrespondingToProcess(process_name)
    tell application "System Events"
        set process_bid to get the bundle identifier of process process_name
        set application_name to file of (application processes where bundle identifier is process_bid and frontmost is true)
    end tell

    repeat with x in application_name
        return name of x
    end repeat

    return ""

end GetFrontmostApplicationNameCorrespondingToProcess

on GetProcessCorrespondingToApplication(application_name)
    tell application "System Events"
        set application_id to (get the id of application "Adobe Acrobat Professional" as string)
        set process_name to name of (application processes where bundle identifier is application_id)
    end tell
    return process_name
end GetProcessCorrespondingToApplication


on test ()

    set frontmostApps to {}
    set message to ""

    tell application "System Events"
        set listOfProcesses to (name of every process where background only is false)
    end tell

    repeat with visibleProcess in listOfProcesses
        try
            set x to GetFrontmostApplicationNameCorrespondingToProcess(visibleProcess)
            if x is not "" then
                set end of frontmostApps to x
            end if
        on error someError
            set message to message & "Some error occurred: " & someError & "; "
        end try
    end repeat

    return {frontmostApps, message}
end run

--display dialog GetApplicationNameCorrespondingToProcess("Kindle")

test()
