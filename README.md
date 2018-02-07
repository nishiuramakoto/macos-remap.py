What is this?
=============

This is a tiny Python script for remapping scancodes(UsageID) of USB keyboard on MacOS >= 10.12(Sierra).

The hardcoded remapping is tailored for the Emacs users on Japanese MacBooks.
The Japanese keyboard may be useful for non-Japanese programmers too because it has
two keys known as Eisu/Kana (kind of dead keys) at the both sides of the space key.
This gives additional keys that could be used as one of the modifiers Emacs uses so often,
e.g. control keys, which is good because you don't have to strain your pinkies too much.
Instead, you could use your thumbs which are presumably much stronger than your pinkies.

Additionally, it has some AppleScripts intended to be used as Dictation commands.

1. `scroll-them-up.applescript`
   When run, it will scroll up the application windows specified the file `~/etc/apps.txt`,
   while maintaining the focus of the primary application.
   Similarly,
2. `scroll-them-down.applescript`
   will scroll down the specified application windows.

For example, let's say `~/etc/apps.txt` contains the following lines:

```
Emacs
Kindle
Chrome
```

Then the scripts will scroll up Kindle and Chrome, after which it changes the focus to
Emacs. I'm planning to use this for my presentations and also for coding on Emacs.
They may be useful as dictation commands and for standalone GUI scripting.

# Synopsis

## Remap keycodes
```bash
$ # Remaps the keys
$ ./remap.py
$ # Reset the keys
$ ./remap.py --reset
```

## Install dictation commands

### Install scripts
```bash
# Create ~/Scripts folder, compile scripts and install them
$ make install
```

### Create Automator Workflow

open Automator(Command+Space "automator"), Choose "Run Script" and paste the
following code to the script editor:

```
on run {input, parameters}
   set myScript to alias ((path to scripts folder as text) &amp; "scroll-them-down.scpt")
   run script myScript with parameters {input, parameters}
end run
```

then save it as "scroll-them-down".

### Create a dictation command

System Preferences -> Accessibility -> Dictation -> Dictation Commands

Press "+" and fill the fields as follows:
1. When I Say: Scroll them down
2. While using: Any application
3. Perform: Run Workflow -> Other -> choose "scroll-them-down" workflow just created in the last step.

### Configure the workflow.
Edit `~/etc/apps.txt` as follows:

```
Emacs
Kindle
Chrome
```

The first line defines the main application (e.g. editor, excel, etc.)
The succeeding lines define auxillary applications for browsing documents.

N.B. Applications are picked up by the `contain` keyword in AppleScript.

### Test it!

Launch Emacs, Kindle and Chrome (on whatever desktops).

Press fn + fn (fn twice) and say "scroll-them-down".

Then there you go!

# Note

The definition of remaps is hardcoded; please feel free to generalize it as you wish.

The hardcoded keymap may be useful for you if:

+ you are an Emacs user on a MacBook with the Japanese keyboard
+ your keyboard layout is set to Australian (because setting it to US does not work for some reason)
+ you are annoyed by the unhelpful positions of Kana/Eisu keys at the both sides of the space key.
+ you don't want to install a third party app just to do this.

More specifically, we'll remap the keys as follows:

## On the left side of the Space

```
Left Control -> Eisu
Eisu         -> Left Control
Left Command -> Left Option(Alt)
Left Option  -> Left Command
Caps         -> Kana
```

## On the right side of the Space

```
Kana          -> Right Control
Right Command -> Right Option
Yen/|         -> `/~
_             -> Right Command
```

What it does
------------

It does nothing suspicious.

1. Construct a JSON string out of a Python dictionary defining remaps
2. Execute 'hidutil' with that JSON string.

Please see https://developer.apple.com/library/content/technotes/tn2450/_index.html
for the details. Note that this will only work for MacOS >= Sierra (10.12)
