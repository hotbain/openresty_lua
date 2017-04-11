local function close_db(db)  
    if not db then  
        return  
    end  
    db:close()  
end  


local mysql = require("resty.mysql")
local db,err = mysql:new();
if not db then
	ngx.say("new msyql error",err)
	return 
end

--设置超时时间毫秒
db:set_timeout(1000)


local props = {  
    host = "127.0.0.1",  
    port = 3306,  
    database = "test",  
    user = "root",  
    password = "123456"  
}  


local res, err, errno, sqlstate = db:connect(props)  


if not res then  
   ngx.say("connect to mysql error : ", err, " , errno : ", errno, " , sqlstate : ", sqlstate)  
   return close_db(db)  
end  

res, err, errno, sqlstate = db:query("select * from test_user where id =101");
if not res then  
   ngx.say("select error : ", err, " , errno : ", errno, " , sqlstate : ", sqlstate)  
   return close_db(db)  
end  

for i, row in ipairs(res) do  
   for name, value in pairs(row) do  
     ngx.say("select row ", i, " : ", name, " = ", value, "<br/>")  
   end  
end  