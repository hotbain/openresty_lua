local  count  = 0

local hello= function()
	count = count+1
	ngx.say("count:",count)
end

local _M={
	hello=hello
}

return _M

