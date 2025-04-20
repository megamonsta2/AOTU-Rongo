--// Services
local HttpService = game:GetService("HttpService")

--// Modules
local Shared = require(script.Parent.Shared)
local Client = require(script.Parent.Client)

--// Module Setup
local System = {}

function System.Request(Url: string, Auth: Client.Auth, Data: any): string? | any
	-- Get headers
	local headers = System.CreateHeaders(Auth)

	-- Send request
	local Success, Response = pcall(function()
		return HttpService:RequestAsync({
			Url = Url,
			Method = "POST",
			Headers = {
				["apiKey"] = headers["apiKey"],
				["email"] = headers["email"],
				["password"] = headers["password"],
				["Authorization"] = headers["Authorization"],
				["Content-Type"] = "application/json",
				["Accept"] = "application/json",
				["Access-Control-Request-Headers"] = "*",
			},
			Body = HttpService:JSONEncode(Data),
			Compress = Enum.HttpCompression.None,
		})
	end)

	-- If fail, warn then end
	if not Success or not Response or not Response.Body then
		Shared.RongoWarn("Response data:", Response)
		return Shared.RongoError(`Failed to send request to {Url}`)
	end

	-- Decode body
	local Body = HttpService:JSONDecode(Response.Body)

	-- If just failed, warn
	if not Response.Success then
		Shared.RongoWarn(
			`Request returned an error with the following details:\nError message: {Body}\nStatus code: {Response.StatusCode}\nStatus Message: {Response.StatusMessage}\n`
		)
	end

	-- Check body for errors
	if Body and typeof(Body) == "table" and Body.error then
		if Body.error_code then
			Shared.RongoWarn(
				`Request returned an error with the following details:\nError message: {Body.error}\nError code: {Body.error_code}\nLink: {Body.link}\n`
			)
		elseif typeof(Body.error) == "table" and Body.error.name then
			Shared.RongoWarn(`Request returned an error with the following details:`, Body.error)
		end
	end

	-- Return
	return Body or Response.Body
end

function System.CreateHeaders(Auth: Client.Auth): { [string]: string }
	-- If key, return apikey
	if Auth.Type == "key" then
		return { apiKey = Auth.Key }
	elseif Auth.Type == "emailpassword" then -- If email & pass, return those
		return { email = Auth.Email, password = Auth.Password }
	elseif Auth.Type == "bearer" then -- If bearer, do funky things and return
		return { Authorization = "Bearer " .. string.gsub(Auth.Token, "Bearer ", "") }
	elseif Auth.Type == "uri" then -- If uri, then return
		return { Authorization = Auth.Uri }
	end

	-- Else, error
	return Shared.RongoError("Invalid auth type")
end

return System
