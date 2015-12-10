<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>首页center</title>
  </head>
  <body>
  	<div class="easyui-layout" data-options="fit:true" id ="center">
		<div data-options="region:'west',split:true,title:'导航菜单'" style="width:250px;">
			<div id="leftAccordion" class="easyui-accordion" data-options="fit:true,border:false" >
               
            </div>
	    </div>
		<div data-options="region:'center'" >
	      	<div id="tab" class="easyui-tabs" data-options="fit:true,border:false,plain:true,tools:'#tab-tools'">
				<div title="首页" id="homeTab" data-options="href:'index_home',tools:'#p-tools',iconCls:'acc_icon_world',tabWidth:80" style="padding:5px"></div>
			</div>	
	    </div>

	</div>
<script type="text/javascript">
//var $menu =  $.getAjaxHtmlData("showMenu").toJson();
//生成导航菜单
$('#leftAccordion').accordion({
   animate:false
});
   //添加一级菜单
   $('#leftAccordion').accordion('add', {
       title: "job管理",
       content: "<div id = 'job_1'></div>"
   });
   var ul = $("<ul></ul>");
   var li_html = "<li><div >";
   li_html += "    <a  url='jobController/jobqry'>";
   li_html += "    <span class='nav'>"+  "job管理"+"</span>";
   li_html += "    </a>";
   li_html += "</div></li>";
   ul.append($(li_html));  
   $("#job_1").append(ul);
   
   
   
   $('.easyui-accordion li a').click(function(){
        var tab = $("#tab");
        var title = $(this).children('.nav').text();
        if (tab.tabs("exists",title)) {
            tab.tabs("select", title);
            tab.tabs('getSelected').panel("refresh");
        } else {
            tab.tabs("add",{title:title,closable:true,icon:"acc_icon_"+$(this).attr("icon")});
            tab.tabs('getSelected').panel("refresh", $(this).attr("url"));
        }
        $('.easyui-accordion li div').removeClass("selected");
        $(this).parent().addClass("selected");
    }).hover(function(){
        $(this).parent().addClass("hover");
    },function(){
        $(this).parent().removeClass("hover");
    });
</script>
	   	
</body>
</html>
