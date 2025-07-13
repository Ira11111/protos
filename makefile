.PHONY: $(MAKECMDGOALS)

gen-all: gen-go gen-python gen-js

gen-go:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	mkdir -p gen/go
	protoc -I proto proto/sso/sso.proto --go_out=./gen/go --go_opt=paths=source_relative --go-grpc_out=./gen/go --go-grpc_opt=paths=source_relative

gen-js:
	npm install -g grpc-tools grpc-web
	mkdir -p gen/js
	protoc -I=./gen/js --js_out=import_style=commonjs,binary:./gen/js --grpc-web_out=import_style=commonjs,mode=grpcwebtext:./gen/js
