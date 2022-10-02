local Multiple = require(script.Parent.Multiple)
local Bases = {
	Roles = "https://groups.roblox.com/v2/users/%d/groups/roles",
	WallPost = "https://groups.roblox.com/v2/groups/%d/wall/posts?limit=%d&sortOrder=%s",
	NameHistory = "https://groups.roblox.com/v1/groups/%d/name-history?limit=%d&sortOrder=%s",
}



--			Methods			--
local Methods = {}
function Methods:GetRoles(GroupId: number, Limits: number): {[number]: Roles}?
	local Link = Bases.Roles:format(GroupId, Limits)
	local Get = Multiple.GetAsync(Link, self.GoogleUrl)
	if Get then		return Get.data		end
	return nil
end
function Methods:GetWallPosts(GroupId: number, Limits: number, Asc: boolean): Multiple.CursorObject
	local Sort = (if Asc then "Asc" else "Desc")
	local Link = Bases.WallPost:format(GroupId, Limits, Sort)
	return Multiple.UseCursor(Link, self.GoogleUrl)
end
function Methods:NameHistory(GroupId: number, Limits: number, Asc: boolean): Multiple.CursorObject
	local Sort = (if Asc then "Asc" else "Desc")
	local Link = Bases.NameHistory:format(GroupId, Limits, Sort)
	return Multiple.UseCursor(Link, self.GoogleUrl)
end

--			Types			--
export type Roles = {
	group: {
		hasVerifiedBadge: boolean,
		id: number,
		memberCount: number,
		name: string
	},
	role: {
		id: number,
		name: string,
		rank: number
	},
}

--			Constructor			--
return function(GoogleUrl: string): typeof(Methods)
	local self = table.clone(Methods)
	self.GoogleUrl = GoogleUrl
	return self
end