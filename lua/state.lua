<<<<<<< HEAD
local SSlua = dm.global_vars:get_var("SSlua")

for _, state in SSlua:get_var("states") do
	if state:get_var("internal_id") == dm.state_id then
=======
local SSlua = dm.global_vars.SSlua

for _, state in SSlua.states do
	if state.internal_id == _state_id then
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
		return { state = state }
	end
end

return { state = nil }
