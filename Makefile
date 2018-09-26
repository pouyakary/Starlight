
install: install-binary install-daemon

build: compile-binary

install-daemon:
	cp ./source/starlight-daemon.plist ~/Library/LaunchAgents

install-binary: compile-binary
	mv ./starlight /usr/local/bin

compile-binary:
	swiftc -emit-executable ./source/starlight.swift
