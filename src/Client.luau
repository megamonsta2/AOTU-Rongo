--!strict

--// Modules
local Shared = require(script.Parent.Shared)

--// Types
type AuthType = "emailpassword" | "key" | "bearer" | "uri"
export type Auth =
	{ Type: "emailpassword", Email: string, Password: string }
	| { Type: "key", Key: string }
	| { Type: "bearer", Token: string }
	| { Type: "uri", Uri: string }
export type Client = {
	Url: string,
	Auth: Auth,
}

--// Module Setup
return function(Type: AuthType, Value: string, Value2: string?): Auth
	if Type == "emailpassword" then
		return {
			Type = "emailpassword",
			Email = Value,
			Password = Value2 or "",
		}
	elseif Type == "key" then
		return {
			Type = "key",
			Key = Value,
		}
	elseif Type == "bearer" then
		return {
			Type = "bearer",
			Token = Value,
		}
	elseif Type == "uri" then
		return {
			Type = "uri",
			Uri = Value,
		}
	end

	return Shared.RongoError("Invalid auth.")
end
