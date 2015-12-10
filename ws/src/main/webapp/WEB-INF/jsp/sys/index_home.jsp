<%@ page language="java"  pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>首页home</title>
</head>
<body>
	<div id="weather" title="天气预报" iconCls="m-icon-weather" collapsible="true"
							closable="false" style="height: 150px; padding: 10px;">
							<iframe allowtransparency="true" frameborder="0" width="290"
								height="96" scrolling="no"
								src="http://tianqi.2345.com/plugin/widget/index.htm?s=2&z=2&t=0&v=0&d=2&bd=0&k=000000&f=004080&q=1&e=0&a=1&c=58362&w=290&h=96&align=center"></iframe>
	</div>
	<div id="calendar" title="日历" iconCls="m-icon-calendar" collapsible="true"
		closable="false" style="height: 230px; padding: 10px;">
		<div class="easyui-calendar" style="width: 200px; height: 180px;"></div>
	</div>
						
   <script type="text/javascript">
	  $('#weather').draggable();
	  $('#calendar').draggable();

   </script>
</body>
</html>
