-- version: 0.1.2

local HTTP = game:GetService("HttpService")
local Letters = ("ABCDEFGHIJKLMNOPQRSTUVWXYZ"):split("")
local URL_base = "https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:json&gid="

type GST = {
	URL: string,
	IDs: {
		Document: string,
		Page: number
	},
	Information: {
		status: string,
		["table"]: {
			cols: {
				[number]: {
					["id"]: string,
					["label"]: string,
					["type"]: string
				}
			},
			rows: {
				[number]: {
					c: {[number]: {v: string}?}
				}
			},
		}
	},
	
	--			Methods				--
	GetByCell: (Letter: string, Number: number) -> (string),
	Update: () -> (),
}


--			Methods				--
local GoogleSheets = {}
function GoogleSheets:GetByCell(Letter: string, Number: number)
	local self = self :: GST
	if not self.Information.table.rows[Number] then			return nil			end
	
	local LetterIndex = table.find(Letters, Letter)
	local Info = self.Information.table.rows[Number].c[LetterIndex]
	return (if Info then Info.v else nil)
end
function GoogleSheets:Update()
	local self = self :: GST
	
	--			Get from web				--
	local success, data = pcall(HTTP.GetAsync, HTTP, self.URL)
	if not success or not data then			return warn("GoogleSheets error:", data)			end

	--			Get JSON				--
	local success, JSON = pcall(HTTP.JSONDecode, HTTP, data:sub(48, #data - 2))
	if not success then		warn("GoogleSheets error:", JSON)		end
	if JSON and JSON.status == "ok" then
		self.Information = JSON
	else
		self.Information = {
			status = "not load",
			["table"] = {
				cols = {},
				rows = {},
			}
		}
	end
end


--			Constructor				--
function GoogleSheets.new(Document: string, Page: string|number)
	local self = setmetatable({} :: GST, GoogleSheets)
	self.IDs = {
		["Document"] = Document,
		["Page"] = Page
	}
	self.URL = URL_base:format(Document) .. Page
	self:Update()
	
	return self
end


--			Return class			--
GoogleSheets.__index = GoogleSheets
return GoogleSheets :: {
	new: (Document: string, Page: string|number) -> GST
}
