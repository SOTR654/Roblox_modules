# Search
- **Description:** Search for information from users with names similar to `Keyword`
- **Parameters:** `Keyword: string`, `Limits: number`
- **Return:**
```lua
Data: {
    displayName: string,
    hasVerifiedBadge: boolean,
    id: number,
    name: string,
    previousUsernames: {string}
}
```
___
# UserInfo
- **Description:** Obtains user information from their UserId.
- **Parameters:** `UserId: number`
- **Return:**
```lua
{
    [number]: {
        description: string,
        created: string,
        isBanned: boolean,
        externalAppDisplayName: string,
        hasVerifiedBadge: boolean,
        id: number,
        name: string,
        displayName: string
    }
}
```
___
# NameHistory
- **Description:** Gets the previous names of the `UserId` data ordered in pages.
- **Parameters:** `UserId: number`, `Limits: number`, `Asc: boolean`
- **Return:**
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
- **Example:**
```lua
    local Cursor = APIsManager.UsersAPI:NameHistory(UserName, 50, true)
    
    local Data1 = Cursor.Data
    Cursor:Next()           -- Search for 50 more names, if they do not exist a warning will appear.

    local Data2 = Cursor.Data
    Cursor:Before()         -- Returns the previous search.

    local Data3 = Cursor.Data
    print(Data3 == Data2)   -- true
```


