--!strict

--// Modules
local Client = require(script.Parent.Client)

--// Types
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

return Connection.new
