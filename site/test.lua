local request = require("lapis.spec.request").mock_request
local app = require("app")
local T = require("u-test")
local expect = T.expect
local trve = T.is_not_nil
local json = require("cjson")
local create = function()
	local b = {
		id = 1,
		title = "test 1",
		description = "this is the first test",
	}
	local status, body = request(app, "/create", { post = { item = json.encode(b) } })
	expect(200)(status)
	local j = json.decode(body)
	expect(1)(j.id)
	expect("test 1")(j.title)
	expect("this is the first test")(j.description)
end
local read = function()
	local status, body = request(app, "/read/1")
	expect(200)(status)
	local j = json.decode(body)
	expect(1)(j.id)
	expect("test 1")(j.title)
	expect("this is the first test")(j.description)
end
local update = function()
	local b = {
		id = 1,
		title = "test updated",
		description = "this is the first test",
	}
	local status, body = request(app, "/update/1", { post = { item = json.encode(b) } })
	expect(200)(status)
	local j = json.decode(body)
	expect(1)(j.id)
	expect("test updated")(j.title)
	expect("this is the first test")(j.description)
end
T["create"] = create
T["read"] = read
T["update"] = update
T.summary()
