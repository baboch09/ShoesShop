#! bin/bash -x
MODULE_SRC="Modules/ShoesNetwork/Sources/ShoesNetwork/"

openapi-generator generate -i "shoes.yaml" -g swift5 -o "api-mobile"
rm -r $MODULE_SRC""*
cp -R "api-mobile/OpenAPIClient/Classes/OpenAPIs/". $MODULE_SRC
rm -r "api-mobile"

