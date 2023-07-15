local DSS = game:GetService("DataStoreService")
local HTTPS = game:GetService("HttpService")
local function F_pcall(Base: any, Function: string, ...): (boolean, any)
	--		Success		--
	local T = {pcall(Base[Function], Base, ...)}
	if T[1] then		return unpack(T, 2)		end

	--		Error		--
	warn(("Error with %s:"):format(Function), ..., "\n", T[2])
	return false, nil
end

--		Types		--
export type GlobalDataStore = {
	--		Properties			--
	Cache: any,
	DataStore: DataStore,
	DataStoreInfo: {string},

	--		Methods			--
	GetAsync: (self: GlobalDataStore, key: string) -> (boolean, any, DataStoreKeyInfo?),
	RemoveAsync: (self: GlobalDataStore, key: string) -> (boolean, any),
	IncrementAsync: (self: GlobalDataStore, key: string, increment: number) -> (),
}
export type DS = GlobalDataStore&{
	SetAsync: (self: DS, key: string, value: any, userids: {number}?, options: DataStoreOptions?) -> (),
}
export type ODS = GlobalDataStore&{
	SetAsync: (self: ODS, key: string, value: any) -> (),
	GetSortedAsync: (self: ODS, ascending: boolean, pagesize: number, minValue: number?, maxValue: number?) -> DataStorePages,
}



--		Return		--
local GlobalDataStore = {"GetAsync", "SetAsync", "RemoveAsync", "IncrementAsync"}
local Storage, DS, ODS = {}, {}, {"IncrementAsync"}
return function(n: string, s: string?, Type: "Normal"|"Ordered")
	--		Check and get		--
	assert(type(n) == "string", "Name must be a string")
	assert(table.find({"nil","string"}, typeof(s)), 'Scope must be a string or nil')
	assert(table.find({"Normal","Ordered"}, Type), 'Type must be a "SortedMap" or "Queue"')
	
	local FullName = n .. (s or "")
	if Storage[FullName] then		return Storage[FullName]		end
	
	
	
	--		New		--
	local self = {
		Cache = {},
		DataStore = DSS[if Type == "Normal" then "GetDataStore" else "GetOrderedDataStore"](n, s),
	}
	local function Connect(Function: string)
		self[Function] = function(_, key: string, value: any, ...)
			--		No doble set		--
			if Function == "SetAsync" then
				local _, T1 = F_pcall(HTTPS, "JSONEncode", value)
				local _, T2 = F_pcall(HTTPS, "JSONEncode", self.Cache[key])
				if T1 == T2 then		return		end
			end



			--		Pcall		--
			local T = {F_pcall(self.DataStore, Function, key, value, ...)}
			if not T[1] then		return		end

			--		Cache		--
			if Function == "GetAsync" then
				self.Cache[key] = T[2]
			elseif Function == "SetAsync" then
				self.Cache[key] = value
			elseif Function == "RemoveAsync" then
				self.Cache[key] = nil
			end
			return unpack(T, 2)
		end
	end
	for _, F in pairs(GlobalDataStore) do		Connect(F)		end
	for _, F in pairs(if Type == "Normal" then DS else ODS) do		Connect(F)		end
	
	
	
	--		Save		--
	Storage[FullName] = self
	return Storage[FullName]
end :: (
	(Name: string, Scope: string?, Type: "Normal") -> DS
)&(
	(Name: string, Scope: string?, Type: "Ordered") -> ODS
)
