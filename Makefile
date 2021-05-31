.INSTALL: build run
.INSTALLSUDO: addsudo
build:
	chmod +x debian-setup.sh
run:
	./debian-setup.sh
addsudo:
	chmod +x addsudousers.sh && ./addsudousers.sh