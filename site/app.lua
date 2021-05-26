local lapis = require("lapis")
local from_json = require("lapis.util").from_json
local to_json = require("lapis.util").to_json
local app = lapis.Application()
local dir = "storage/"
local capture_errors_json = require("lapis.application").capture_errors_json
local respond_to = require("lapis.application").respond_to

os.execute("mkdir " .. dir .. "2>/dev/null")
local write = function(p, s)
	local file = io.open(dir .. p, "w")
	file:write(s)
	file:close()
end
local read = function(p)
	local file = io.open(dir .. p)
	local c = file:read("*a")
	file:close()
	return c
end
local remove = function(p)
	local file = read(p)
	os.remove(dir .. p)
	return file
end

app:match("/read/:id", function(self)
	local j = read(self.params.id)
	local t = from_json(j)
	return { json = t }
end)

app:put("/delete/:id", function(self)
	local t, p = pcall(read, self.params.id)
	if t then
		local t = from_json(p)
		remove(self.params.id)
		return { json = t }
	else
		return {
			status = 404,
			"not found!",
		}
	end
end)

app:post("/create", function(self)
	local t = from_json(self.params.item)
	write(t.id, self.params.item)
	return {
		json = t
	}
end)
app:post("/update/:id", function(self)
	if pcall(read, self.params.id) then
		local t = from_json(self.params.item)
		write(t.id, self.params.item)
		return {
			json = t
		}
	else
		return {
			status = 404,
			"not found!",
		}
	end
end)

return app
