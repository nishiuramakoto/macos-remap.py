
APPLESCRIPTS = list-windows.applescript
LIB  =  sendKey.applescript list-windows.applescript scroll-them-down.applescript scroll-them-up.applescript
SCPT = $(patsubst %.applescript,%.scpt,$(LIB))

.PHONY: all

remap :  remap.py
	python remap.py

all-scripts : $(SCPT)

%.scpt : %.applescript
	osacompile -o $@ $^

test : $(SCPT)
	osascript dump-windows.applescript

install : $(SCPT)
	mkdir -p ~/Scripts && install $(SCPT)  ~/Scripts

clean:
	rm $(SCPT) 
