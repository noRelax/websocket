<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<html>
<head>
<base href="${web }">
<meta charset="utf-8">
<title>角色操作权限管理</title>
</head>
<body>
<div style="clear:both"></div>
<div style="margin-top: 80px;">
	<c:forEach items="${data}" var="temp">
	<div class="lec_con1">
    	<span style="font-weight: bold;" >${temp[1]}</span>
            <input type="checkbox"    
            <c:if test="${temp[3] == 1 }">
		 				checked="checked" 
		 	</c:if>
            onchange="offOn(${temp[0]} ,this)">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  	</div>
	</c:forEach>
</div>
<script type="text/javascript">
var iRoleId = ${iRoleId};

function offOn(iPurviewinfoId,that){
	var checked = $(that).is(':checked');
	var i=$.layer({
	    shade : [0], //不显示遮罩
	    area : ['auto','auto'],
	    dialog : 
	    {
	        msg:'你确定要'+(checked ?"赋予":"取消")+'权限吗？',
	        btns : 2, 
	        type : 4,
	        btn : ['确定','取消'],
	        yes : function()
	        {
	        	var url = "roleManageController/offOn";
	        	var data = {
						"iRoleId":iRoleId,
						"iPurviewinfoId":iPurviewinfoId,
						"bIsAdd":checked
				};
	            var retData = $.getAjaxHtmlData(url,data);
				if(retData.success == true)
				{
				    layer.msg((checked ?"赋予":"取消")+"权限成功",2,1);
				}else
				{
					layer.msg((checked ?"赋予":"取消")+"权限失败",4,2);
					$(that).prop("checked",'true');
				}
	        	
	        },
		    no : function()
		    {
		    	if(checked){
		    		$(that).removeAttr("checked");  
		    	}else{
		    		$(that).prop("checked",'true');
		    	}
		        layer.close(i);
		        
		    }
		   
	      },
	      close: function(index){
		    	if(checked){
		    		$(that).removeAttr("checked");  
		    	}else{
		    		$(that).prop("checked",'true');
		    	}
		        layer.close(i);
		    }
	});
	return false;
}


</script>
</body>
</html>
