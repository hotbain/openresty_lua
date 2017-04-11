    local template = require("resty.template")  

    template.caching(true)

    local context={title="openresty"}

    

    ngx.say("<br/>")

    local func = template.compile("template1.vm")

    local content = func(context)


    ngx.say(template.render("template1.vm",context))