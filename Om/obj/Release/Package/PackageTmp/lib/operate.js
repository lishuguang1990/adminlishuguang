function operateButton()
{
    $.post("/api/ApiModuleOperate/GetUserOperate", {}, function (data)
    {
           var strhtml = "";
            strhtml+="<span class=\"l\">";
            for (var i = 0; i < data.list.length; i++) {
                var icon = "";
                if (i == 0||i==5)
                {
                    icon = "btn-primary";
                }
                else if (i == 1||i==6)
                {
                    icon = "btn-secondary";
                }
                else if (i == 2||i==7) {
                    icon = "btn-success";
                }
                else if (i == 3||i==8) {
                    icon = "btn-warning";
                }
                else{
                    icon = "btn-danger";
                }
                strhtml += "<a href=\"javascript:;\" onclick=\"" + data.list[i].JsEvent + "\" class=\"btn " + icon + " radius\"><i class=\"Hui-iconfont\">" + data.list[i].Icon + "</i>&nbsp" + data.list[i].ModuleOperateName + "</a> ";
            }
            strhtml += "</span>";
            $("#operate").html(strhtml);
            $(".breadcrumb").html('<i class="Hui-iconfont">&#xe67f;</i>'+data.parentname+'<span class="c-gray en">&gt;</span> '+data.name+' <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a>'
)

          
      

    },"json"
    )
}
