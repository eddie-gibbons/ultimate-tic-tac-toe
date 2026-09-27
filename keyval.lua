local http = require("socket.http")
local json = require("dkjson")

local keyval = {}

function keyval.set(key, value) 
    local url = "https://api.keyval.org/set/" .. key .. "/" .. value
    local body, status = http.request(url)
    return status
end

function keyval.get(key)
    local url = "https://api.keyval.org/get/" .. key
    local response, status = http.request(url)
    local body = json.decode(response).val 
    return body, status 
end

return keyval
