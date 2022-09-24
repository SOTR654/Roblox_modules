# Search
**Description:** Search for information from users with names similar to `Keyword`

**Parameters:** `Keyword: string`, `Limits: number`

**Return:** {
    displayName: string,

    hasVerifiedBadge: boolean,

    id: number,
    
    name: string,

    previousUsernames: {string}
}
___
# UserInfo
**Description:** Obtains user information from their UserId.

**Parameters:** `UserId: number`

**Return:** {
    description: string,
	created: string,
	isBanned: boolean,
	externalAppDisplayName: string,
	hasVerifiedBadge: boolean,
	id: number,
	name: string,
	displayName: string
}
___