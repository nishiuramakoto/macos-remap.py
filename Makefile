
SCPT= scroll-them-down.scpt scroll-them-up.scpt test.scpt test-run.scpt


all : $(SCPT)


%.scpt : %.applescript
	osacompile -o $@ $^

test : $(SCPT)
	osascript test.applescript
