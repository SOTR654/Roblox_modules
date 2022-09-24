# AvatarInfo
- **Description:** Returns the messages in the wall of the selected group and ordered in pages.
- **Parameters:** `GroupId: number`, `Limits: number`, `Asc: boolean`
- **Return:** [`CursorObject`](https://github.com/SOTR654/Roblox_modules/tree/main/APIsManager#cursorobject)
> Cursor data:
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
