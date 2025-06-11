local openssl_mac = require "resty.openssl.mac"
local str = require "resty.string"

local HEADERS_NX_SIG = "X-Nexudus-Hook-Signature"

local plugin = {
  PRIORITY = 1029,
  VERSION = "0.0.0",
}

function plugin:access(plugin_conf)
  local headers = kong.request.get_headers()
  local sig_received = headers[HEADERS_NX_SIG]
  if not sig_received then
    return kong.response.error(401, "nexudus header sig missing")
  end

  if type(sig_received) ~= "string" then
    return kong.response.error(400, "nexudus header sig invalid format")
  end

  local body, err = kong.request.get_raw_body()
  if err then
    return {}
  end

  local digest, err = openssl_mac.new(plugin_conf.shared_secret, "hmac", nil, "sha256"):final(body or '')
  local sig_calculated = string.upper(str.to_hex(digest))

  if sig_received ~= sig_calculated then
    return kong.response.error(401, "nexudus signature mismatch")
  end

end

return plugin
