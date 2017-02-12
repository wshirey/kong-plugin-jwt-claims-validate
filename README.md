# kong-plugin-jwt-claims-validate

Validates custom JWT claims with specific values

## How it works

When enabled, this plugin will verify that specified claims are present in a
JSON Web Token [JWT](http://www.jwt.io) and that the claim value has the
specified claim value. If these conditions are met, then the request is sent to
the upstream URL.

The plugin will look for the JWT in the `Authorization: Bearer <token>` header,
or it will look in the query string parameters specified in the plugin
configuration.


> This plugin does not verify the signature of the JWT so you should use this
> alongside the built-in [Kong JWT plugin](http://getkong.org/plugins/jwt). The
> Kong JWT plugin will execute first to authenticate the request, then this
> plugin will execute sometime aftewards.

This plugin is useful to generate scoped JSON Web Tokens that allow a consumer
to access multiple Kong APIs with a single JWT credential.

The plugin will return a `HTTP 401` status with a message about the invalid
claim property that failed. For example

```bash
< HTTP/1.1 401 Unauthorized
<
{"message":"JSON Web Token has invalid claim value for 'username'"}
```
## Configuration

The **kong-plugin-jwt-claims-validate** plugin can only be applied to an API,
and not a consumer. It can be enabled with the following request

```bash
curl -X POST http://localhost:8001/apis/29414666-6b91-430a-9ff0-50d691b03a45/plugins \
  -d '{
    "name": "jwt-claims-validate",
    "config": {
      "uri_param_names": "jwt",
      "claims": {
        "username": "wshirey",
        "id": 19829132,
        "is_admin": true
      }
    }
  }'
```

This will check the JWT payload body to at least include the following JSON

```JSON
{
  "username": "wshirey",
  "id": 19829132,
  "is_admin": true
}
```

> The plugin only supports scalar values, so if you have a nested JSON array or
> object in the payload body, it will not iterate over the values to check if it
> has your specified value.

An example JWT can be found at the [jwt.io playground](https://jwt.io/#debugger?&id_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IndzaGlyZXkiLCJpZCI6MTk4MjkxMzIsImlzX2FkbWluIjp0cnVlfQ.DTUXDMnSKJxSv9yo9Gih1sWMyeQ_X436wYqU2-Np1ss)

## Schema

form parameter|required|description
---|---|---
`name`|*required*|The name of the plugin to use, in this case: `jwt-claims-validate`
`uri_param_names`|*optional*|A list of querystring parameters that Kong will inspect to retrieve JWTs. Defaults to `jwt`.
`claims`|*required*|A table of claims that Kong will validate in the JWT payload body. Lua types supported are *[boolean, string, number]*.

## See also

- [Kong JWT Plugin](http://getkong.org/plugins/jwt)
- [Learn about JSON Web Tokens at jwt.io](http://jwt.io)