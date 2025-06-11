local plugin_name = "nx-wh-hmac"
local package_name = "kong-nexudus-webhook-hmac"
local package_version = "0.0.0"
local rockspec_revision = "1"

local github_account_name = "PSandro"
local github_repo_name = "kong-nexudus-webhook-hmac"
local git_checkout = package_version == "dev" and "main" or package_version


package = package_name
version = package_version .. "-" .. rockspec_revision
supported_platforms = { "linux", "macosx" }
source = {
  url = "git+https://github.com/"..github_account_name.."/"..github_repo_name..".git",
  branch = git_checkout,
}


description = {
  summary = "Nexudus Webhook HMAC validation",
  homepage = "https://"..github_account_name..".github.io/"..github_repo_name,
  license = "Apache 2.0",
}


dependencies = {
}


build = {
  type = "builtin",
  modules = {
    ["kong.plugins."..plugin_name..".handler"] = "kong/plugins/"..plugin_name.."/handler.lua",
    ["kong.plugins."..plugin_name..".schema"] = "kong/plugins/"..plugin_name.."/schema.lua",
  }
}
