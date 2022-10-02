local Multiple = require(script.Parent.Multiple)
local Bases = {
	Search = "https://users.roblox.com/v1/users/search?keyword=%s&limit=%d",
	UserInfo = "https://users.roblox.com/v1/users/%d",
	NameHistory = "https://users.roblox.com/v1/users/%d/username-history?limit=%d&sortOrder=%s"
}



--			Methods			--
local Methods = {}
function Methods:Search(Keyword: string, Limits: number): Multiple.CursorObject
	local Link = Bases.Search:format(Keyword, Limits)
	return Multiple.UseCursor(Link, self.GoogleUrl)
end
function Methods:UserInfo(UserId: number): UserInfo
	local Link = Bases.UserInfo:format(UserId)
	return Multiple.GetAsync(Link, self.GoogleUrl)
end
function Methods:NameHistory(UserId: number, Limits: number, Asc: boolean): Multiple.CursorObject
	local Sort = (if Asc then "Asc" else "Desc")
	local Link = Bases.NameHistory:format(UserId, Limits, Sort)
	return Multiple.UseCursor(Link, self.GoogleUrl, function(data)
		local NewData = {}
		for _, T in pairs(data) do		table.insert(NewData, T.name)		end
		return NewData
	end)
end

--			Types			--
export type UserInfo = {
	description: string,
	created: string,
	isBanned: boolean,
	externalAppDisplayName: string,
	hasVerifiedBadge: boolean,
	id: number,
	name: string,
	displayName: string
}

--			Constructor			--
return function(GoogleUrl: string): typeof(Methods)
	local self = table.clone(Methods)
	self.GoogleUrl = GoogleUrl
	return self
end