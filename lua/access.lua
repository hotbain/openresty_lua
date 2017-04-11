    if ngx.req.get_uri_args()["token"] ~= "123" then  
       return ngx.say("Please access with param token=123")
    end  