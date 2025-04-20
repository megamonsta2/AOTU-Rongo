--!strict

--// Modules
local Client = require(script.Parent.Client)
local DatabaseModule = require(script.Parent.Database)

--// Types
type Database = DatabaseModule.Database
type Data = {
	_client: Client.Client,
	_cluster: string,
}

--// Class Setup
local Cluster = {}
Cluster.__index = Cluster
export type Cluster = typeof(setmetatable({} :: Data, Cluster))

function Cluster.GetDatabase(self: Cluster, DatabaseName: string): Database
	-- Create db and return
	local Database = setmetatable({}, DatabaseModule) :: Database
	Database._client = self._client
	Database._cluster = self._cluster
	Database._database = DatabaseName

	return Database
end

return Cluster
