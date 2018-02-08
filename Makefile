
APPLESCRIPTS = list-windows.applescript
LIB  = list-windows.applescript scroll-them-down.applescript scroll-them-up.applescript sendKey.applescript
SCPT = $(patsubst %.applescript,%.scpt,$(LIB))

all : $(SCPT)

%.scpt : %.applescript
	osacompile -o $@ $^

test : $(SCPT)
	osascript dump-windows.applescript

install : $(SCPT)
	mkdir -p ~/Scripts && install $(SCPT)  ~/Scripts
