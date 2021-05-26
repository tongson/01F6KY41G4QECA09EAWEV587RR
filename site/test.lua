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
end
T["create"] = create
T.summary()
