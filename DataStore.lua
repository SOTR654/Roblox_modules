--	Made by SOTR654
local DSS = game:GetService("DataStoreService")
local Limits = {
	Max = {
		Get = {B = 60, P = 10},				--> GetAsync
		Set = {B = 60, P = 10},				--> SetAsync, IncrementAsync, UpdateAsync, RemoveAsync
		GetSorted = {B = 5, P = 2},			--> GetSortedAsync
		GetVersion = {B = 5, P = 2},		--> GetVersionAsync
		List = {B = 5, P = 2},				--> ListDataStoresAsync, ListKeysAsync, ListVersionAsync
		ListRemove = {B = 5, P = 2},		--> RemoveVersionAsync
	} :: {[string]: {B: number, P: number, N: number}},
	Using = {},
}
for k, T in pairs(Limits.Max) do
	T.N, Limits.Using[k] = T.B, 0
end

--		Functions		--
local function CheckLimits(Type: string)
	if Limits.Max[Type].N >= Limits.Using[Type] then		return		end
	Limits.Using[Type] += 1
	task.delay(60, function()		Limits.Using[Type] -= 1		end)
	return true
end

--		Types		--
type Response = "Success"|"Error"|"Offline"|"Limit"
export type DataManager = {
	DS: DataStore|OrderedDataStore,
	TableKey: string,
	Cache: {[string]: any},
	
	--		Methods - global		--
	Get: (self: DataManager, K: string, O: DataStoreOptions?) -> (Response, any, DataStoreKeyInfo),
	Set: (self: DataManager, K: string, V: any, U: {number}?, O: DataStoreSetOptions?) -> Response,
	Remove: (self: DataManager, K: string) -> (Response, any, DataStoreKeyInfo),
	Update: (self: DataManager, K: string, F: (any) -> any, O: DataStoreSetOptions?) -> (Response, any, DataStoreKeyInfo),
	Increment: (self: DataManager, K: string, D: number, U: {number}?, O: DataStoreOptions?) -> (Response, number?),

	--		Methods - order		--
}



--		Methods		--
local Methods: DataManager = {} :: DataManager
for T, L in pairs({Get = {"Get"}, Set = {"Increment", "Set", "Update", "Remove"}}) do
	for _, v in pairs(L) do
		Methods[v] = function(self, K: string, value, ...): (Response, any)
			if not CheckLimits(T) then		return "Limit"		end


			--		Set and save?		--
			if self.DS then
				local List = {pcall(self.DS[v.."Async"], self.DS, K, value, ...)}
				if List[1] then
					self.Cache[K] = (
						if v == "Set" then
							value
							elseif v == "Remove" then
							nil
							elseif table.find({"Increment", "Get", "Update"}, v) then
							List[2]
							else
							0
					)
					return "Success", unpack(List, 2)
				else
					return "Error", warn("Error with GetAsync:", K, self.TableKey, List[2])
				end
			else
				if K == "Get" then
					return "Offline", self.Cache[K]
				else
					local new = value(self.Cache[K])
					self.Cache[K] = (
						if v == "Set" then
							value
							elseif v == "Remove" then
							nil
							elseif v == "Increment" then
							(self.Cache[K]or 0)+value
							elseif v == "Update" then
							(if typeof(new) ~= "nil" then new else self.Cache[K])
							else
							0
					)
				end
				return "Offline"
			end
		end
	end
end




--		Limits by players		--
game:GetService("Players").PlayerAdded:Connect(function()
	for _, T in pairs(Limits.Max) do		T.N += T.P		end
end)
game:GetService("Players").PlayerRemoving:Connect(function()
	for _, T in pairs(Limits.Max) do		T.N -= T.P		end
end)



--		Create		--
local Storage = {}
local function GetDataStore(Mode: string)
	return function(Name: string, Scope: string?): DataManager
		--		Before		--
		local TableKey = ("%s_%s_%s"):format(Name, Scope or"", Mode)
		if Storage[TableKey] then		return Storage[TableKey]		end


		--		Can use DataStoreService?		--
		local S1, DS = pcall(DSS[("Get%sDataStore"):format((Mode=="Order"and"Ordered")or"")], DSS, Name, Scope)
		if not S1 then
			warn("Could not access datastore, offline mode will be used:", TableKey, DS)
			DS = nil
		end


		--		Data table		--
		local self: DataManager = table.clone(Methods)
		self.Cache = {["Server"] = {}, ["Player"] = {}}
		self.DS, self.TableKey = DS, TableKey
		return self
	end
end
return {
	Order = GetDataStore("Order"),
	Normal = GetDataStore("Normal"),
}
