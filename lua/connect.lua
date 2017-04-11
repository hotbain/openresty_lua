ngx.say("true")

local nginx = ngx
local headers = ngx.req.get_headers()


--����ͷ  
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


--get����uri����  
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
  
--post�������  
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


--�����httpЭ��汾  
ngx.say("ngx.req.http_version : ", ngx.req.http_version(), "<br/>")  
--���󷽷�  
ngx.say("ngx.req.get_method : ", ngx.req.get_method(), "<br/>")  
--ԭʼ������ͷ����  
ngx.say("ngx.req.raw_header : ",  ngx.req.raw_header(), "<br/>")  
--�����body������  
ngx.say("ngx.req.get_body_data() : ", ngx.req.get_body_data(), "<br/>")  
ngx.say("<br/>")  

nginx.header.writerBy="123"
nginx.header.impl="gongz"

--[[
ngx.escape_uri/ngx.unescape_uri �� uri������룻

ngx.encode_args/ngx.decode_args������������룻

ngx.encode_base64/ngx.decode_base64��BASE64������룻

ngx.re.match��nginx������ʽƥ�䣻
����Nginx Lua API��ο� http://wiki.nginx.org/HttpLuaModule#Nginx_API_for_Lua��
]]

--δ�����������uri
local request_uri = ngx.var.request_uri;
ngx.say("request_uri : ", request_uri, "<br/>");
--����
ngx.say("decode request_uri : ", ngx.unescape_uri(request_uri), "<br/>");
--MD5
ngx.say("ngx.md5 : ", ngx.md5("123"), "<br/>")
--http time
ngx.say("ngx.http_time : ", ngx.http_time(ngx.time()), "<br/>")

return nginx.exit(200)