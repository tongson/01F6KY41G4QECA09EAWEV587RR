local lapis = require("lapis")
local from_json = require("lapis.util").from_json
local to_json = require("lapis.util").to_json
local app = lapis.Application()
local dir = "storage/"
local capture_errors_json = require("lapis.application").capture_errors_json
local respond_to = require("lapis.application").respond_to

os.execute("mkdir " .. dir)
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

app:get("/read", function()
	return { json = {} }
end)

app:get("/delete", function(self)
end)

app:post("/create", function(self)
	print(self.params)
	local t = from_json(self.params.item)
	write(t.id, self.params.item)
	return {
		json = { to_json(t) },
	}
end)
app:post("/update", function(self)
	return {}
end)

return app
