local HTTP = game:GetService("HttpService")
local Letters = ("ABCDEFGHIJKLMNOPQRSTUVWXYZ"):split("")
local URL_base = "https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:json&gid="

type GST = {
	URL: string,
	IDs: {
		Document: string,
		Page: number
	},
	Information: {},
	
	--			Methods				--
	GetByCell: (Letter: string, Number: number) -> (string)
}



--			Methods				--
local GoogleSheets = {}
function GoogleSheets:GetByCell(Letter: string, Number: number)
	local self = self :: GST
	
	local LetterIndex = table.find(Letters, Letter)
	return self.Information.table.rows[Number].c[LetterIndex].v
end


--			Constructor				--
function GoogleSheets.new(Document: string, Page: string|number)
	local self = setmetatable({} :: GST, GoogleSheets)
	self.IDs = {
		["Document"] = Document,
		["Page"] = Page
	}
	self.URL = URL_base:format(Document) .. Page

	--			Get from web				--
	local success, data = pcall(HTTP.GetAsync, HTTP, self.URL)
	if not success or not data then		return warn("GoogleSheets error:", data)	end

	--			Get JSON				--
	local success, JSON = pcall(HTTP.JSONDecode, HTTP, data:sub(48, #data - 2))
	if not success or not JSON then		return warn("GoogleSheets error:", JSON)	end
	self.Information = JSON

	return self
end



--			Return class			--
GoogleSheets.__index = GoogleSheets
return GoogleSheets :: {
	new: (Document: string, Page: string|number) -> GST
}
