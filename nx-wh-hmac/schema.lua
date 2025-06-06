local typedefs = require "kong.db.schema.typedefs"

return {
  name = "nx-wh-hmac",
  fields = {
    { consumer = typedefs.no_consumer },
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { shared_secret = { description = "Shared Nexudus Webhook secret.", type = "string", required = true, default = "changeme"}, },
        },
    }, },
  },
}
