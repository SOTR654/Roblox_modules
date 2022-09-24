local Multiple = require(script.Parent.Multiple)
local Bases = {
	AvatarInfo = "https://avatar.roblox.com/v1/users/%d/avatar",
	Outfits = "https://avatar.roblox.com/v1/users/%d/outfits",
}



--			Methods			--
local Methods = {}
function Methods:AvatarInfo(UserId: number): AvatarInfo
	local Link = Bases.AvatarInfo:format(UserId)
	return Multiple.GetAsync(Link, self.GoogleUrl)
end
function Methods:GetOutfits(UserId: number): {[number]: {id: number, isEditable: number, name: string}}?
	local Link = Bases.Outfits:format(UserId)
	
	--			Check			--
	local Get = Multiple.GetAsync(Link, self.GoogleUrl)
	if not Get then		return nil		end

	--			Return			--
	return Get.data
end

--			Types			--
export type AvatarInfo = {
	assets: {[number]: {
		assetType: {
			id: number,
			name: string
		},
		currentVersionId: number,
		id: number,
		name: string
	}},
	bodyColors: {
		headColorId: number,
		leftArmColorId: number,
		leftLegColorId: number,
		rightArmColorId: number,
		rightLegColorId: number,
		torsoColorId: number
	},
	defaultPantsApplied: boolean,
	defaultShirtApplied: boolean,
	emotes: {[number]: {
		assetId: number,
		assetName: string,
		position: number
	}},
	playerAvatarType: string,
	scales: {
		bodyType: number,
		depth: number,
		head: number,
		height: number,
		proportion: number,
		width: number
	}
}

--			Constructor			--
return function(GoogleUrl: string): typeof(Methods)
	local self = table.clone(Methods)
	self.GoogleUrl = GoogleUrl
	return self
end