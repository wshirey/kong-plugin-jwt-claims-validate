package = "kong-plugin-jwt-claims-validate"
version = "1.0-1"
source = {
   url = "git+https://github.com/wshirey/kong-plugin-jwt-claims-validate.git",
   tag = "v1.0"
}
description = {
   summary = "A Kong plugin to check JWT claim values",
   homepage = "https://github.com/wshirey/kong-plugin-jwt-claims-validate",
   license = "MIT"
}
dependencies = {
   "lua ~> 5.1"
}
build = {
   type = "builtin",
   modules = {
      ["kong.plugins.jwt-claims-validate.handler"] = "handler.lua",
      ["kong.plugins.jwt-claims-validate.schema"] = "schema.lua"
   }
}
