generate:
	tuist fetch
	tuist generate

reset:
	tuist clean
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace

clean:
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace
