build:
	dart compile js src/main.dart -o docs/main.dart.js
	cp src/content/* docs/