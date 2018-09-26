
<img src="https://user-images.githubusercontent.com/2157285/46095220-e38ba580-c1c8-11e8-94dc-730d14f834c8.png" width="200">

# Starlight
Starlight is a dark/light mode manager for OS X. It measures the surrounding ambient light and then performs light/dark theme adjustments based on that. Starlight is a daemon server and performs an adjustment task every 10 seconds. Starlight is a very lightweight task and uses 0~0.2% of your CPU and 5 MB of memory.

## How to use it?
You must be using macOS mojave or later (to even have the light/dark possibility) and then you must have Xcode installed (in a version that supports Swift 4.1+). This build system only uses Swift compiler so if you have `swiftc` in such way that it supports `4.1+` you can use it. You also have to have GNU Make installed.

```
% make install
```

This will install `starlight` to your `/usr/local/bin` and the `starlight-daemon.plist` to your `~/Library/LaunchAgents`

## Ideas for the future versions
Well I'm hoping to have ways of setting wallpapers based on day/night modes and also things like vscode themes based on that. So there must be a flexible way to do so and I'm working on it.