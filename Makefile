.INSTALL: build run
build:
	chmod +x debian-setup.sh
run:
	./debian-setup.sh
addsudousers:
	chmod +x addsudousers.sh && ./addsudousers.sh