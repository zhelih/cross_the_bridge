# .PHONY: build clean

#build: main.native

#%.native: %.ml
all:
	ocamlbuild -use-ocamlfind -package extlib,ocamlgraph -tag debug -j 0 main.native

clean:
	ocamlbuild -clean
