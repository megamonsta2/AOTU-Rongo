--!strict

--[[
	______                        
	| ___ \                       
	| |_/ /___  _ __   __ _  ___  
	|    // _ \| '_ \ / _` |/ _ \ 
	| |\ \ (_) | | | | (_| | (_) |
	\_| \_\___/|_| |_|\__, |\___/ 
	                   __/ |      
	                  |___/       

	Rongo - MongoDB API Wrapper for Roblox
	
	Rongo gives developers easy access to MongoDBs web APIs
	so they're able to use MongoDB directly in their games
	
	Rongo uses MongoDB's Data API, which is disabled by
	default so you must enable it in your Atlas settings
	
	Version: 2.1.2
	License: MIT License
	Documentation: https://devforum.roblox.com/t/rongo/1755615	
	
	Copyright (c) 2024 Untitled Games

	**FORK BY minimonsta2 FOR AOT: U**
--]]

--// Modules
local Client = require(script.Client)
local Connection = require(script.Connection)

return {
	connection = Connection,
	auth = Client,
}
