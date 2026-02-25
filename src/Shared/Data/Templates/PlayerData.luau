local Template = {
	Coins = 0,
	Metadata = {
		JoinDate = 0,
		LastSeen = 0,
		TotalPlaytime = 0,
	},
}

export type PlayerData = typeof(Template)

return Template
