# AvatarInfo
- **Description:** Returns information about the appearance of the User's current avatar.
- **Parameters:** `UserId: number`
- **Return:**
````lua
{
	assets: {
		[number]: {
			assetType: {
				id: number,
				name: string
			},
			currentVersionId: number,
			id: number,
			name: string
		}
	},
	bodyColors: {
		headColorId: number,
		leftArmColorId: number,
		leftLegColorId: number,
		rightArmColorId: number,
		rightLegColorId: number,
		torsoColorId: number
	},
	defaultPantsApplied: boolean,
	defaultShirtApplied: boolean,
	emotes: {
		[number]: {
			assetId: number,
			assetName: string,
			position: number
		}
	},
	playerAvatarType: string,
	scales: {
		bodyType: number,
		depth: number,
		head: number,
		height: number,
		proportion: number,
		width: number
	}
}
````
# GetOutfits
- **Description:** Get information about the given user's outfits.
- **Parameters:** `UserId: number`
- **Return:**
````lua
{
	[number]: {
		id: number,
		isEditable: number,
		name: string
	}
}
````
# GetCurrentAssets
- **Description:** Gets the id of the assets used by the given User.
- **Parameters:** `UserId: number`
- **Return:** `{number}`
# GetOutfitIdDetails
- **Description:** Get details of the given Outfit or bundle.
- **Parameters:** `OutfitId: number`
- **Return:**
````lua
{
	assets: {
       [number]: {
          assetType:{
			id: number,
            name: string
		  },
          currentVersionId: number,
          id: number,
          name: string
       },
    },
    bodyColors: {
       headColorId: number,
       leftArmColorId: number,
       leftLegColorId: number,
       rightArmColorId: number,
       rightLegColorId: number,
       torsoColorId: number
    },
    id: number,
    isEditable: boolean,
    name: string,
    outfitType: string,
    playerAvatarType: string,
    scale: {
       bodyType: number,
       depth: number,
       head: number,
       height: number,
       proportion: number,
       width: number
    }
}
````

