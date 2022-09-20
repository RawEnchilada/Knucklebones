build:
	dart compile js src/main.dart -o dist/main.dart.js
	cp src/content/* dist/

artifact:
	dart compile js src/main.dart -o _site/main.dart.js
	cp src/content/* _site/