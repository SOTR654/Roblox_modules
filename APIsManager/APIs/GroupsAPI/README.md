# GetRoles
- **Description:** Get information about the roles of a group.
- **Parameters:** `GroupId: number`, `Limits: number`
- **Return:**
````lua
{
	[number]: {
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
}
````
# GetWallPosts
- **Description:** Returns the messages in the wall of the selected group and ordered in pages.
- **Parameters:** `GroupId: number`, `Limits: number`, `Asc: boolean`
- **Return:** [`CursorObject`](https://github.com/SOTR654/Roblox_modules/tree/main/APIsManager#cursorobject)
* **Cursor data:**
````lua
{
	[number]: {
		body: string,
		created: string,
		id: number,
		poster: {
			role: {
				id: number,
				name: string,
				rank: number
			},
			user: {
				buildersClubMembershipType: string,
				displayName: string,
				hasVerifiedBadge: boolean,
				userId: number,
				username: string
			}
		},
		updated: string
	}
}
````
# NameHistory
- **Description:** Gets the previous names of the given group.
- **Parameters:** `GroupId: number`, `Limits: number`, `Asc: boolean`
- **Return:** [`CursorObject`](https://github.com/SOTR654/Roblox_modules/tree/main/APIsManager#cursorobject)
* **Cursor data:**
````lua
{
	[number]: {
		created: string,
		name: string,
	}
}
````


