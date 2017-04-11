--获取全局共享变量
local dic  = ngx.shared.shared_data

--获取字典值
local i =dic:get("i")



if not i then
	i=1 
	dic.set("i",i)
	ngx.say("lazy set i ","</br>")
end
--递增
i =dic:incr("i",1)
ngx.say("i=",i,"<br/>")


