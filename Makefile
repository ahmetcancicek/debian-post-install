.INSTALL: build run
.INSTALLSUDO: addsudo
build:
	chmod +x setup.sh
run:
	./setup.sh
addsudo:
	chmod +x addsudousers.sh && ./addsudousers.sh