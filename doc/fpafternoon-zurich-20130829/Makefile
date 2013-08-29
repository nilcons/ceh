all: final/ceh.html

final/ceh.html: ceh.md
	mkdir -p final
	pandoc -t slidy -s $< -o $@
