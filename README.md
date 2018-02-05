What is this?
=============

This is a tiny Python script for remapping scancodes(UsageID) of USB keyboard on MacOS >= 10.12(Sierra).

The hardcoded remapping is tailored for the Emacs users on Japanese MacBooks.
The Japanese keyboard may be useful for non-Japanese programmers too because it has
two keys known as Eisu/Kana (kind of dead keys) at the both sides of the space key.
This gives additional keys that could be used as one of the modifiers Emacs uses,
e.g. control keys, which is good because you don't have to strain your pinkies too much.
Instead, you could use your thumbs which are presumably much stronger than your pinkies.

# Synopsis

```bash
$ # Remaps the keys
$ ./remap.py
$ # Reset the keys
$ ./remap.py --reset
```

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
