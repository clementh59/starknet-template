build:
	protostar build --cairo-path ./lib/cairo_contracts/src

deploy:
	protostar deploy ./build/main.json --network alpha-goerli

clean:
	rm -rf ./build