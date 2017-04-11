--[[
local function close_redis(red)
    if not red then
        return
    end
    local ok, err = red:close()
    if not ok then
        ngx.say("close redis error : ", err)
    end
end
]]


--[[
即设置空闲连接超时时间防止连接一直占用不释放；设置连接池大小来复用连接。

 

此处假设调用red:set_keepalive()，连接池大小通过nginx.conf中http部分的如下指令定义：

#默认连接池大小，默认30

lua_socket_pool_size 30;

#默认超时时间,默认60s

lua_socket_keepalive_timeout 60s;

 

注意：

1、连接池是每Worker进程的，而不是每Server的；

2、当连接超过最大连接池大小时，会按照LRU算法回收空闲连接为新连接使用；

3、连接池中的空闲连接出现异常时会自动被移除；

4、连接池是通过ip和port标识的，即相同的ip和port会使用同一个连接池（即使是不同类型的客户端如Redis、Memcached）；

5、连接池第一次set_keepalive时连接池大小就确定下了，不会再变更；

5、cosocket的连接池http://wiki.nginx.org/HttpLuaModule#tcpsock:setkeepalive。
]]
local function close_redis(red)
    if not red then
        return
    end
    --释放连接(连接池实现)
    local pool_max_idle_time = 10000 --毫秒
    local pool_size = 10 --连接池大小
    local ok, err = red:set_keepalive(pool_max_idle_time, pool_size)
    if not ok then
        ngx.say("set keepalive error : ", err)
    end
end

local redis = require("resty.redis")

--创建实例
local red = redis:new()
--设置超时（毫秒）
red:set_timeout(1000)
--建立连接
local ip = "127.0.0.1"
local port = 6379
local ok, err = red:connect(ip, port)
if not ok then
    ngx.say("connect to redis error : ", err)
    return close_redis(red)
end
--调用API进行处理
ok, err = red:set("msg", "hello world")
if not ok then
    ngx.say("set msg error : ", err)
    return close_redis(red)
end

--调用API获取数据
local resp, err = red:get("msg")
if not resp then
    ngx.say("get msg error : ", err)
    return close_redis(red)
end
--得到的数据为空处理
if resp == ngx.null then
    resp = ''  --比如默认值
end
ngx.say("msg : ", resp)

close_redis(red)
