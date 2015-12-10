<%@ page language="java"  pageEncoding="UTF-8"%>
<html>
    <base href="${web}">
	<head>
		<title>正在跳转到系统首页...</title>
	</head>
	<script language="javascript">
	 function openwin(){
			window.opener = null;
			window.open('','_self');
	        myWindow8 =window.open('login','','toolbar=0,location=0,directories=0,status=0,menubar=0,fullscreen=1,scrollbars=0,resizable=1');
	 } 
	 openwin();
	</script>
	<body> 
		如果不能自动跳转，请点击<a href="javascript:openwin();">本链接</a>
	</body>
</html>
