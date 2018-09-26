
install: install-binary install-deamon

build: compile-binary

install-deamon:
	mv ./source/deamon.plist ~/Library/LaunchAgents

install-binary: compile-binary
	mv ./starlight /usr/local/bin

compile-binary:
	swiftc -emit-executable ./source/starlight.swift
