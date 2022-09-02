build:
	dart compile js src/main.dart -o dist/main.dart.js
	cp src/content/* dist/