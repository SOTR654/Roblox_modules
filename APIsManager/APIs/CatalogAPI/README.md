# By HTTP
## GetBundlesWithAsset
- **Description:** Get all bundles with the given AssetId.
- **Parameters:** `AssetId: string, Limit: number, Asc: boolean`
- **Return:** [`CursorObject`](https://github.com/SOTR654/Roblox_modules/tree/main/APIsManager#cursorobject)
- **Cursor data:**
````lua
{
    [number]: {
    	bundleType: string,
		creator: {
			id: number,
			name: string,
			type: string
		},
		description: string,
		id: number,
		itemRestrictions: {string},
		items: {
			[number]: {
				id: number,
				name: string,
				owned: boolean,
				type: string
			},
		},
		name: string,
		product: {
			id: number,
			isForSale: boolean,
			isFree: boolean,
			isPublicDomain: boolean,
			noPriceText: string,
			type: string
		}
	}
}
````



# By Roblox
