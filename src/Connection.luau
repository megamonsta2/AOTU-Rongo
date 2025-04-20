--!strict

--// Modules
local Client = require(script.Parent.Client)
local ClusterModule = require(script.Parent.Cluster)

--// Types
type Cluster = ClusterModule.Cluster
type Data = {
	_client: Client.Client,
}

--// Classes
local Connection = {}
Connection.__index = Connection
export type Connection = typeof(setmetatable({} :: Data, Connection))

--// Rongo Client
function Connection.new(Url: string, Auth: Client.Auth): Connection
	local self = setmetatable({}, Connection) :: Connection
	self._client = { Url = Url, Auth = Auth }

	return self
end

function Connection.SetUrl(self: Connection, Url: string)
	-- Sets new auth
	self._client.Url = Url
end

function Connection.SetAuth(self: Connection, Auth: Client.Auth)
	-- Sets new auth
	self._client.Auth = Auth
end

function Connection.GetCluster(self: Connection, ClusterName: string): Cluster
	-- Creates cluster and returns
	local Cluster = setmetatable({}, ClusterModule) :: Cluster
	Cluster._client = self._client
	Cluster._cluster = ClusterName

	return Cluster
end

return Connection.new
