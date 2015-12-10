<%@ page language="java"  pageEncoding="UTF-8"%>
<%@include file="./common/common.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>服务中心-登陆-海风教育</title>

<style type="text/css">
<!--
a{ color:#008EE3}
a:link  { text-decoration: none;color:#008EE3}
A:visited {text-decoration: none;color:#666666}
A:active {text-decoration: underline}
A:hover {text-decoration: underline;color: #0066CC}
A.b:link {
	text-decoration: none;
	font-size:12px;
	font-family: "Helvetica,微软雅黑,宋体";
	color: #FFFFFF;
}
A.b:visited {
	text-decoration: none;
	font-size:12px;
	font-family: "Helvetica,微软雅黑,宋体";
	color: #FFFFFF;
}
A.b:active {
	text-decoration: underline;
	color: #FF0000;

}
A.b:hover {text-decoration: underline; color: #ffffff}

.table1 {
	border: 1px solid #CCCCCC;
}
.font {
	font-size: 12px;
	text-decoration: none;
	color: #999999;
	line-height: 20px;
	

}
.input {
	font-size: 12px;
	color: #999999;
	text-decoration: none;
	border: 0px none #999999;


}

td {
	font-size: 12px;
	color: #007AB5;
}
form {
	margin: 1px;
	padding: 1px;
}
input {
	border: 0px;
	height: 26px;
	color: #007AB5;

	.unnamed1 {
	border: thin none #FFFFFF;
}
.unnamed1 {
	border: thin none #FFFFFF;
}
select {
	border: 1px solid #cccccc;
	height: 18px;
	color: #666666;

	.unnamed1 {
	border: thin none #FFFFFF;
}
body {
	background-repeat: no-repeat;
	background-color: #9CDCF9;
	background-position: 0px 0px;

}
.tablelinenotop {
	border-top: 0px solid #CCCCCC;
	border-right: 1px solid #CCCCCC;
	border-bottom: 0px solid #CCCCCC;
	border-left: 1px solid #CCCCCC;
}
.tablelinenotopdown {

	border-top: 1px solid #eeeeee;
	border-right: 1px solid #eeeeee;
	border-bottom: 1px solid #eeeeee;
	border-left: 1px solid #eeeeee;
}
.style6 {FONT-SIZE: 9pt; color: #7b8ac3; }

-->
</style>
</head>
<body>
  <form id="loginForm">
<table width="681" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:120px">
  <tr>
    <td width="353" height="259" align="center" valign="bottom" background="${resource}resource/images/login_1.gif"><table width="90%" border="0" cellspacing="3" cellpadding="0">
      <tr>
        <td align="right" valign="bottom" style="color:#05B8E4">Power by www.hfjy.com Copyright 2013</td>
      </tr>
    </table></td>
    <td width="195" background="${resource}resource/images/login_2.gif"><table width="190" height="115" border="0" style="margin-top:27px" cellpadding="2" cellspacing="0">
    
      
            <tr>
              <td width="50" height="30" align="left">账&nbsp;&nbsp;&nbsp;&nbsp;户：</td>
              <td><input name="loginPhone" type="TEXT" style="background:url(${resource}resource/images/login_6.gif) repeat-x; border:solid 1px #27B3FE; height:20px; background-color:#FFFFFF" id="UserName" size="14" class="validate[required]"></td>
            </tr>
            <tr>
              <td height="30" width="50" align="left">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
              <td><input  name="loginPassword" TYPE="PASSWORD" style="background:url(${resource}resource/images/login_6.gif) repeat-x; border:solid 1px #27B3FE; height:20px; background-color:#FFFFFF" id="Password" size="14" class="validate[required]"></td>
            </tr>
          <tr>
              <td valign="top">验&nbsp;证&nbsp;码：</td>
			  <td valign="top"><input type="text" id="code" name="code" style="width: 50px;" class="validate[required]"/>
				 &nbsp;<img src="captchaImage" id="captchaImage" width="50"
				height="24" align="absmiddle" /> 
			  </td>
          </tr>
          <tr>
              <td colspan="2" align="center"><input type="button" id="sub" style="background:url(${resource}resource/images/login_5.gif) no-repeat" value=" 登  陆 ">
			  <input type="reset" style="background:url(${resource}resource/images/login_5.gif) no-repeat" value=" 取  消 "></td>
          </tr>
    </table>
    </td>
    <td width="133" background="${resource}resource/images/login_3.gif">&nbsp;</td>
  </tr>
  <tr>
    <td height="161" colspan="3" background="${resource}resource/images/login_4.gif"></td>
  </tr>
</table>
</form>
<script>
$(function(){         
    $('#captchaImage').click(changeCaptcha);
    //表单提交
	$("#sub").click(function(){
		$("#sub").attr("disabled",true);
		if(!$('#loginForm').validationEngine('validate')){
			$(".formError ").delegate(this,"click",function(){
				$(this).remove();
			});
			$("#sub").attr("disabled",false);
			return false;
		}
		
		var $result =  $.getAjaxHtmlData("doLogin",getAjaxData("loginForm"));
		if($result.success){
			window.location.href = "welcome";
		}else{
			layer.tips($result.data,($result.data.indexOf('用户名')>-1) ? $("#UserName") :($result.data.indexOf('密码')>-1 ?$("#Password") : $("#captchaImage")), {
                 style: ['background-color:#05B8E4; color:#fff', '#78BA32'],
                 maxWidth:185,
                 guide: 1,
                 time: 3,
                 closeBtn:[0, true]
            });
			//$('body').Ynotify($result.data, 0,3000);
		}
		$("#sub").attr("disabled",false);
	});
});

function changeCaptcha() {  
    $('#captchaImage').hide().attr('src', 'captchaImage?' + Math.floor(Math.random()*100) ).fadeIn();  
} 
</script>
</body>
</html>