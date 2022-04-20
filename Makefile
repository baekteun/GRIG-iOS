generate:
	tuist fetch
	tuist cache warm --dependencies-only
	tuist generate
