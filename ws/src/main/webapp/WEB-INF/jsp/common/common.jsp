<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setAttribute("web", request.getContextPath()+"/");
	request.setAttribute("resource","http://p.hfjy.com/");
%>
<link rel="stylesheet" type="text/css" href="${resource}resource/js/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${resource}resource/js/jquery-easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${resource}resource/css/common/Ynotify.css">
<!-- js资源文件 -->
<script src="${resource}resource/js/jquery/jquery-1.11.js" type="text/javascript"></script>
<script src="${resource}resource/js/layer/layer.js"></script><!-- 弹出框 -->
<script src="${resource}resource/js/validator/jquery.validationEngine.js"></script><!-- 表单验证 -->
<script src="${resource}resource/js/common/common.js"></script><!-- 公共方法 -->


<script type="text/javascript" src="${resource}resource/js/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${resource}resource/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
