-- mod-version:2 -- lite-xl 2.0
local core = require 'core'
local common = require 'core.common'
local style = require 'core.style'
local RootView = require 'core.rootview'
local rootnode = core.root_view.root_node
local av

style.divider = style.background

local function getActiveViews(n, t)
	t = t or {}
	if n.active_view then
		table.insert(t, n.active_view)
	end
	if n.a then getActiveViews(n.a, t) end
	if n.b then getActiveViews(n.b, t) end

	return t
end

local function updateShade()
	local views = getActiveViews(rootnode)
	for _, v in ipairs(views) do
		if v ~= av then
			local pos = v.size
			local size = v.position
			local w = pos.x
			local h = pos.y
			--core.log(string.format('%s %.0f, %.0f - %.0f %.0f // sx %.0f sy %.0f', v:get_name(), pos.x, pos.y, w, h, size.x, size.y))
			renderer.draw_rect(size.x, size.y, w + 1, h, {common.color 'rgba(0, 0, 0, 0.6)'})
		end
	end
end

local rvDraw = RootView.draw
function RootView:draw(...)
	rvDraw(self, ...)
	updateShade()
end

local setActiveView = core.set_active_view
function core.set_active_view(view)
	setActiveView(view)
	av = view
end
