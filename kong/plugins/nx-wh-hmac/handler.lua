local openssl_mac = require "resty.openssl.mac"

local HEADERS_NX_SIG = "X-Nexudus-Hook-Signature"

local NxWhHmacHandler = {
  VERSION = "0.0.0",
  PRIORITY = 1029,
}

function NxWhHmacHandler:access(conf)
  local headers = kong.request.get_headers()
  local sig_received = headers[HEADERS_NX_SIG]
  if not sig_received then
    return nil, { status=401, message="no nexudus signature header given" } }
  end

  if type(sig_received) ~= "string" then
    return nil, { status=400, message="header sig is not string" } }
  end

  local body, err = kong.request.get_raw_body()
  if err then
    return {}
  end

  local sig, err = openssl_mac.new(conf.shared_secret, "hmac", nil, "sha256"):final(body or '')
  local sig_calculated = string.upper(sig)

  if sig_received ~= sig_calculated then
    return nil, { status=401, message="nexudus signature mismatch" } }
  end

end

return NxWHmacHandler
