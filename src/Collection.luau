--!strict

--// Modules
local Http = require(script.Parent.Http)
local Client = require(script.Parent.Client)

--// Types
type Data = {
	_client: Client.Client,
	_cluster: string,
	_database: string,
	_collection: string,
}

--// Variables
local ENDPOINTS = {
	POST = {
		["FindOne"] = "/rongo/findOne",
		["FindMany"] = "/rongo/findMany",
		["InsertOne"] = "/rongo/insertOne",
		["InsertMany"] = "/rongo/insertMany",
		["UpdateOne"] = "/rongo/updateOne",
		["UpdateMany"] = "/rongo/updateMany",
		["DeleteOne"] = "/rongo/deleteOne",
		["DeleteMany"] = "/rongo/deleteMany",
		["ReplaceOne"] = "/rongo/replaceOne",
		["Aggregate"] = "/rongo/aggregate",
	},
}
local DEFAULT_FILTER = { ["_id"] = { ["$exists"] = true } }

--// Class Setup
local Collection = {}
Collection.__index = Collection
export type Collection = typeof(setmetatable({} :: Data, Collection))

function Collection.FindOne(self: Collection, Filter: { [string]: any }?): { [string]: any }?
	-- Get url and auth
	local url = self._client.Url
	local auth = self._client.Auth

	local bodyData = {
		database = self._database,
		collection = self._collection,
		filter = Filter or DEFAULT_FILTER,
	}

	-- Get response and return
	local response = Http.Request(url .. ENDPOINTS.POST.FindOne, auth, bodyData)
	if not response or not (typeof(response) == "table") or not response.document then
		return
	end

	return response.document
end

function Collection.FindMany(
	self: Collection,
	Filter: { [string]: any }?,
	Projection: { [string]: number }?,
	Sort: { [string]: number }?,
	Limit: number?,
	Skip: number?
): { { [string]: any } }?
	local url = self._client.Url
	local auth = self._client.Auth

	local bodyData = {
		database = self._database,
		collection = self._collection,
		filter = Filter or DEFAULT_FILTER,
		projection = Projection,
		sort = Sort,
		limit = Limit,
		skip = Skip,
	}

	-- Get response and return
	local response = Http.Request(url .. ENDPOINTS.POST.FindMany, auth, bodyData)
	if not response or not (typeof(response) == "table") or not response.documents then
		return
	end

	return response.documents
end

function Collection.InsertOne(self: Collection, Document: { [string]: any }): string?
	local url = self._client.Url
	local auth = self._client.Auth

	local bodyData = {
		["database"] = self._database,
		["collection"] = self._collection,
		["document"] = Document,
	}

	-- Get response and return
	local response = Http.Request(url .. ENDPOINTS.POST.InsertOne, auth, bodyData)
	if not response or not (typeof(response) == "table") or not response.insertedId then
		return
	end

	return response.insertedId
end

function Collection.InsertMany(self: Collection, Documents: { { [string]: any } }): { string }?
	local url = self._client.Url
	local auth = self._client.Auth

	local bodyData = {
		["database"] = self._database,
		["collection"] = self._collection,
		["documents"] = Documents,
	}

	-- Get response and return
	local response = Http.Request(url .. ENDPOINTS.POST.InsertMany, auth, bodyData)
	if not response or not (typeof(response) == "table") or not response.insertedIds then
		return
	end

	return response.insertedIds
end

function Collection.UpdateOne(
	self: Collection,
	Filter: { [string]: any }?,
	Update: { [string]: { [string]: any } }?,
	Upsert: boolean?
): { matchedCount: number, modifiedCount: number }?
	local url = self._client.Url
	local auth = self._client.Auth

	local bodyData = {
		["database"] = self._database,
		["collection"] = self._collection,
		["filter"] = Filter or DEFAULT_FILTER,
		["update"] = Update or "{}",
		["upsert"] = Upsert,
	}

	-- Get response and return
	local response = Http.Request(url .. ENDPOINTS.POST.UpdateOne, auth, bodyData)
	if not response or not (typeof(response) == "table") then
		return
	end

	return response
end

function Collection.UpdateMany(
	self: Collection,
	Filter: { [string]: any }?,
	Update: { [string]: { [string]: any } }?,
	Upsert: boolean?
): { matchedCount: number, modifiedCount: number }?
	local url = self._client.Url
	local auth = self._client.Auth

	local bodyData = {
		["database"] = self._database,
		["collection"] = self._collection,
		["filter"] = Filter or DEFAULT_FILTER,
		["update"] = Update or "{}",
		["upsert"] = Upsert,
	}

	-- Get response and return
	local response = Http.Request(url .. ENDPOINTS.POST.UpdateMany, auth, bodyData)
	if not response or not (typeof(response) == "table") then
		return
	end

	return response
end

function Collection.DeleteOne(self: Collection, Filter: { [string]: any }?): number?
	local url = self._client.Url
	local auth = self._client.Auth

	local bodyData = {
		["database"] = self._database,
		["collection"] = self._collection,
		["filter"] = Filter or DEFAULT_FILTER,
	}

	-- Get response and return
	local response = Http.Request(url .. ENDPOINTS.POST.DeleteOne, auth, bodyData)
	if not response or not (typeof(response) == "table") or not response.deletedCount then
		return
	end

	return response.deletedCount
end

function Collection.DeleteMany(self: Collection, Filter: { [string]: any }?): number?
	local url = self._client.Url
	local auth = self._client.Auth

	local bodyData = {
		["database"] = self._database,
		["collection"] = self._collection,
		["filter"] = Filter or DEFAULT_FILTER,
	}

	-- Get response and return
	local response = Http.Request(url .. ENDPOINTS.POST.DeleteMany, auth, bodyData)
	if not response or not (typeof(response) == "table") or not response.deletedCount then
		return
	end

	return response.deletedCount
end

function Collection.ReplaceOne(
	self: Collection,
	Filter: { [string]: any }?,
	Replacement: any,
	Upsert: boolean?
): { matchedCount: number, modifiedCount: number }?
	local url = self._client.Url
	local auth = self._client.Auth

	local bodyData = {
		["database"] = self._database,
		["collection"] = self._collection,
		["filter"] = Filter or DEFAULT_FILTER,
		["replacement"] = Replacement,
		["upsert"] = Upsert,
	}

	-- Get response and return
	local response = Http.Request(url .. ENDPOINTS.POST.ReplaceOne, auth, bodyData)
	if not response or not (typeof(response) == "table") then
		return
	end

	return response
end

function Collection.Aggregate(self: Collection, Pipeline: { { [string]: any } }): { { [string]: any } }?
	local url = self._client.Url
	local auth = self._client.Auth

	local bodyData = {
		["database"] = self._database,
		["collection"] = self._collection,
		["pipeline"] = Pipeline,
	}

	-- Get response and return
	local response = Http.Request(url .. ENDPOINTS.POST.Aggregate, auth, bodyData)
	if not response or not (typeof(response) == "table") then
		return
	end

	return response
end

return Collection
