local Multiple = require(script.Multiple)



--			Constructor			--
local Constructor = {}
function Constructor.new(ScriptId: string)
	local GoogleUrl = "https://script.google.com/macros/s/" .. ScriptId .. "/exec"
	
	local self = {}
	self.UsersAPI = require(script.APIs.UsersAPI)(GoogleUrl)
	self.AvatarAPI = require(script.APIs.AvatarAPI)(GoogleUrl)
	self.GroupsAPI = require(script.APIs.GroupsAPI)(GoogleUrl)
	self.CatalogAPI = require(script.APIs.CatalogAPI)(GoogleUrl)
	return self
end
return Constructor