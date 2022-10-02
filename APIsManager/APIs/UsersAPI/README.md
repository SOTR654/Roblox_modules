# Search
- **Description:** Search for information from users with names similar to `Keyword`
- **Parameters:** `Keyword: string`, `Limits: number`
- **Return:** [`CursorObject`](https://github.com/SOTR654/Roblox_modules/tree/main/APIsManager#cursorobject)
- **Cursor data:**
````lua
{
    [number]: {
        displayName: string,
        hasVerifiedBadge: boolean,
        id: number,
        name: string,
        previousUsernames: {string}
    }
}
````
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
- **Return:** [`CursorObject`](https://github.com/SOTR654/Roblox_modules/tree/main/APIsManager#cursorobject)
* **Cursor data:** `{string}`
