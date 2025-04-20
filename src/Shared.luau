--!strict

--// Module Setup
local System = {}

function System.RongoWarn(message: string, ...)
	warn("[RONGO] " .. message, ...)
end

function System.RongoError(message: string): never
	error("[RONGO] " .. message .. "\n", 2)
end

return System
