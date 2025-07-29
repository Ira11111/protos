.PHONY: $(MAKECMDGOALS)

SCHEMA_PKG := github.com/Ira11111/protos/v4/http/products/schemas

gen-all: gen-go gen-js

go-install-tools-grpc:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

go-install-tools-api:
	go install github.com/deepmap/oapi-codegen/v2/cmd/oapi-codegen@v2.2.0

gen-go-grpc:
	mkdir -p gen/go
	protoc -I proto proto/sso/sso.proto --go_out=./gen/go --go_opt=paths=source_relative --go-grpc_out=./gen/go --go-grpc_opt=paths=source_relative

gen-go-products-api:
	mkdir -p gen/go/products
	oapi-codegen -generate types,gin-server -package products ./http/products/openapi.yaml > ./gen/go/products/api.go

gen-js-grpc:
	npm install -g grpc-tools grpc-web
	mkdir -p gen/js
	protoc -I=./gen/js --js_out=import_style=commonjs,binary:./gen/js --grpc-web_out=import_style=commonjs,mode=grpcwebtext:./gen/js
