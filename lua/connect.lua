ngx.say("true")

local nginx = ngx
local headers = ngx.req.get_headers()


--请求头  
local headers = ngx.req.get_headers()  
ngx.say("headers begin", "<br/>")  
ngx.say("Host : ", headers["Host"], "<br/>")  
ngx.say("user-agent : ", headers["user-agent"], "<br/>")  
ngx.say("user-agent : ", headers.user_agent, "<br/>")  
for k,v in pairs(headers) do  
    if type(v) == "table" then  
        ngx.say(k, " : ", table.concat(v, ","), "<br/>")  
    else  
        ngx.say(k, " : ", v, "<br/>")  
    end  
end  
ngx.say("headers end", "<br/>")  
ngx.say("<br/>")  


--get请求uri参数  
ngx.say("uri args begin", "<br/>")  
local uri_args = ngx.req.get_uri_args()  
for k, v in pairs(uri_args) do  
    if type(v) == "table" then  
        ngx.say(k, " : ", table.concat(v, ", "), "<br/>")  
    else  
        ngx.say(k, ": ", v, "<br/>")  
    end  
end  
ngx.say("uri args end", "<br/>")  
ngx.say("<br/>")  
  
--post请求参数  
ngx.req.read_body()  
ngx.say("post args begin", "<br/>")  
local post_args = ngx.req.get_post_args()  
for k, v in pairs(post_args) do  
    if type(v) == "table" then  
        ngx.say(k, " : ", table.concat(v, ", "), "<br/>")  
    else  
        ngx.say(k, ": ", v, "<br/>")  
    end  
end  
ngx.say("post args end", "<br/>")  
ngx.say("<br/>")  


--请求的http协议版本  
ngx.say("ngx.req.http_version : ", ngx.req.http_version(), "<br/>")  
--请求方法  
ngx.say("ngx.req.get_method : ", ngx.req.get_method(), "<br/>")  
--原始的请求头内容  
ngx.say("ngx.req.raw_header : ",  ngx.req.raw_header(), "<br/>")  
--请求的body内容体  
ngx.say("ngx.req.get_body_data() : ", ngx.req.get_body_data(), "<br/>")  
ngx.say("<br/>")  

nginx.header.writerBy="123"
nginx.header.impl="gongz"

--[[
ngx.escape_uri/ngx.unescape_uri ： uri编码解码；

ngx.encode_args/ngx.decode_args：参数编码解码；

ngx.encode_base64/ngx.decode_base64：BASE64编码解码；

ngx.re.match：nginx正则表达式匹配；
更多Nginx Lua API请参考 http://wiki.nginx.org/HttpLuaModule#Nginx_API_for_Lua。
]]

--未经解码的请求uri
local request_uri = ngx.var.request_uri;
ngx.say("request_uri : ", request_uri, "<br/>");
--解码
ngx.say("decode request_uri : ", ngx.unescape_uri(request_uri), "<br/>");
--MD5
ngx.say("ngx.md5 : ", ngx.md5("123"), "<br/>")
--http time
ngx.say("ngx.http_time : ", ngx.http_time(ngx.time()), "<br/>")

return nginx.exit(200)