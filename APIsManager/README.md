**Description:** module for Roblox Studio to easily manage API access through Google.
# Index
1. [Start - Google](https://github.com/SOTR654/Roblox_modules/tree/main/APIsManager#start---google)
2. [Start - Roblox Studio](https://github.com/SOTR654/Roblox_modules/tree/main/APIsManager#start---roblox-studio)
3. [More information](https://github.com/SOTR654/Roblox_modules/tree/main/APIsManager#More-information)

______
# Start - Google
1. Go ```https://script.google.com/home/``` and log in.

2. Tap New Project.

3. Give the project a name and place
```javascript
function doGet(e) {
  var output;
  try
  {
    var query = e.parameter["q"];
    var response = UrlFetchApp.fetch(decodeURIComponent(query));
    output = {"result":"success", "response": JSON.parse(response.getContentText())};
  }
  catch(e)
  {
    output = {"result":"error", "error": "Unable to fetch"};
  }
  return ContentService.createTextOutput(JSON.stringify(output)).setMimeType(ContentService.MimeType.JSON);
}
```
  ![image](https://user-images.githubusercontent.com/45367427/192004926-05077730-c569-4f80-814a-69fe18df9478.png)

4. Click ```Publish``` and ```Deploy as web app...```

  ![image](https://user-images.githubusercontent.com/45367427/192004997-276ed8a5-dfa9-4ec7-9843-43bdca11c55a.png)

5. Change the access to the app to ```Anyone, even anonymous```.

 ![image](https://user-images.githubusercontent.com/45367427/192005307-37c0c828-302e-443e-b0ac-e1f563432ce0.png)

6. Click ```Deploy```, ```Continue```and finally ```Allow```

7. Copy the link and and extract the id(script id)

  ![image](https://user-images.githubusercontent.com/45367427/192006252-879f130e-0dc6-4812-88e1-cc452da60c5d.png)

___

# Start - Roblox Studio
1. Get the module and place it in your game, for more security place it in ServerStorage.
2. Require the module, call ```new``` and give it the ```script id``` of the Google project.
```lua
local ScriptId = "#######-######_###" -- Google script id
local APIsManager = require(game:GetService("ServerStorage").APIsManager).new(ScriptId)
```
3. Look at the documentation and call the methods!
___

# More information
## CursorObject
* **Type:** 
```lua
  --			Properties			--
  Data: {string},
  HistoryData: {[number]: {string}}
  PageIndex: number,
  NextCursor: string,
	
  --			Methods			--
  Next: (self) -> (),
  Before: (self) -> ()
```
* **Example:** 
```lua
local Cursor = APIsManager.UsersAPI:NameHistory(UserName, 50, true)

local Data1 = Cursor.Data
Cursor:Next()           -- Search for 50 more names, if they do not exist a warning will appear.

local Data2 = Cursor.Data
Cursor:Before()         -- Returns the previous search.

local Data3 = Cursor.Data
print(Data3 == Data2)   -- true
```



