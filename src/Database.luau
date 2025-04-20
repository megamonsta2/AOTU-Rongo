--!strict

--// Modules
local Client = require(script.Parent.Client)
local CollectionModule = require(script.Parent.Collection)

--// Types
type Collection = CollectionModule.Collection
type Data = {
	_client: Client.Client,
	_cluster: string,
	_database: string,
}

--// Class Setup
local Database = {}
Database.__index = Database
export type Database = typeof(setmetatable({} :: Data, Database))

function Database.GetCollection(self: Database, CollectionName: string): Collection
	-- Create collection and return
	local Collection = setmetatable({}, CollectionModule) :: Collection
	Collection._client = self._client
	Collection._cluster = self._cluster
	Collection._database = self._database
	Collection._collection = CollectionName

	return Collection
end

return Database
