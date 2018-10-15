
install: install-binary install-daemon

build: compile-binary

install-daemon:
	cp ./source/starlight-daemon.plist ~/Library/LaunchAgents

install-binary: compile-binary
	mv ./main /usr/local/bin/starlight

compile-binary:
	swiftc -emit-executable ./source/starlight/starlight/*.swift