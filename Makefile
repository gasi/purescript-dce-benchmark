all:
	cd purescript && git checkout esm-codegen && stack build && cd ..

	make --directory example1-dce-js
	make --directory example2-no-dce-purs
	make --directory example3-dce-purs
