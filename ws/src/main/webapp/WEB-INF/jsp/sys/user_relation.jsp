<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<html>
<head>
<base href="${web }">
<meta charset="utf-8">
<title>人员关系管理</title>
<link rel="stylesheet" type="text/css" href="${resource}resource/js/eselect/css/hi-e-select.css">
<script src="${resource}resource/js/eselect/js/hi-e-select.js"></script>
<style type="text/css">
    .userRelation{
	    width:1004px;
	    margin-left:auto;
	    margin-right:auto;
	    padding:50px 0 0;
    }
</style>
</head>
<body>
<div class="userRelation" >
    <h3 >人员关系管理</h3>
</div> 
<div id="tt" class="easyui-tabs" tools="#tab-tools" style="width: 1004px;height:455px; margin-right: auto;margin-left: auto;">
		<div title="人员关系列表" tools="#p-tools" style="padding:20px;">
		     <table id="userRelationTable" ></table> 
		</div>
		<div title="人员关系管理" closable="true" style="padding:20px;" >
			<table id="userRelationManageTable" ></table>  
		</div>
	</div>
  <div id="add"   style="display:none">
		  <form id="add_form">
			 <p> 当前用户:&nbsp;&nbsp;&nbsp;<select name="userId" id="userId" style = "width : 250"> </select><p/>
	         <p> 上级领导:&nbsp;&nbsp;&nbsp;<select name="userPid" id="userPid" style = "width : 250"> </select><p/>
	      </form>
	</div>
<script type="text/javascript">
function init(){
	$("#userPid,#userId").selectInit({
		data : $.getAjaxHtmlData("serverCenterAccountManage/queryAccount" ) ,
		defaults : {
			key : "",
			value : "请选择"
		},
		mapping : {
			key : "userId",
			value : "name"
		}
	});
	$("#userPid,#userId").eSelect({
	});
	
	$('#userRelationTable').treegrid({
		title:'人员关系列表',
		iconCls:'icon-save',
		width:965,                                             //*********************设置treegrid宽度
		height:400,                                            //*********************设置treegrid高度 
		//nowrap: true,
		//animate:true,
		//collapsed:true,
		//nowrap: false,
		striped:true,
		collapsible:true,
		singleSelect: true,
		fitColumns:true,
		pagination:false,
		url:'userRelationManageController/getUserRelationPage',                               //**************获取数据地址返回的数据是集合(对象类型)
		idField:'id',                                          //********************每行记录对应一个唯一标识,id值
		treeField:'name',
		columns:[[                                             //********************* 设置字段名
		    {field:'name',title:'姓名',width:165,editor:'text'},
		    {field:'sex',title:'性别',width:100,editor:'text'},
			{field:'age',title:'年龄',width:100,editor:'text'},
			{field:'phone',title:'电话',width:250,editor:'text'},
			{field:'email',title:'邮箱',width:250,editor:'text'},
			{field:'status',title:'状态',width:100,editor:'text'}
			
		]],
		toolbar:[ {
			id:'flesh',
			text:'刷新',
			iconCls:'icon-reload',
			handler:function(){
				$('#userRelationTable').treegrid('reload');
			}
		}
		]
	});
	
	
	
	$('#userRelationManageTable').datagrid({
		title:'job Manage',
		iconCls:'icon-save',
		width:965,
		height:400,
		nowrap: false,
		striped: true,
		collapsible:true,
		singleSelect:true,
		url:'userRelationManageController/getUserRelationManagepage',
		sortName: 'name',
		sortOrder: 'ASC',
		remoteSort: false,
		idField:'userId',
		columns:[
            [{field:'name',title:'用户名',width:430,align:'center'},
             {field:'pname',title:'上级领导',width:435,align:'center'}
             ]
		],
		pagination:false,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'编辑',
			iconCls:'icon-add',
			handler:function(){
				var $select =  $('#userRelationManageTable').datagrid('getSelected');
				if(!$select){
					$.common.alert.error('请选择行！');
					return;
				}
				$("#userPid").eSelect("val",$select.userPid ); 
				$("#userId").eSelect("val",$select.userId ); 
				$("#add").show();
				$("#add").dialog({   
				    title: '修改',   
				    width: 400,   
				    height: 250,   
				    closed: false,   
				    cache: false,   
				    modal: true,
				    buttons:[{
						text:'保存',
						iconCls:'icon-save',
						handler:function(){
							var data = {};
							var $userId = $("#userId").val().trim();
							if(!$userId){
								$.common.alert.error('当前用户不能为空！');
								return;
							}
							var $userPid = $("#userPid").val().trim();
							if(!$userPid){
								$.common.alert.error('上级领导不能为空！');
								return;
							}
							if($userId == $userPid){
								$.common.alert.error('当前用户不能与上级领导一样');
								return;
							}
							data.userId = $userId;
							data.userPid = $userPid;
							data.userRelationId = $select.userRelationId;
							
							var $result = $.getAjaxHtmlData("userRelationManageController/edit",data);
							if($result.success){
								$("#add").window('close');
								$('#userRelationManageTable').datagrid('reload');
								$('#userRelationTable').treegrid('reload');
							}else{
								$.common.alert.error('操作失败！');
							}
						}
					},{
						text:'关闭',
						iconCls:'icon-cancel',
						handler:function(){
							$("#add").window('close');
						}
					}]
				})
		}
		}
		,{
			id:'btnadd',
			text:'添加',
			iconCls:'icon-add',
			handler:function(){
				$("#userPid").eSelect("val","" ); 
				$("#userId").eSelect("val","" ); 
				$("#add").show();
				$("#add").dialog({   
				    title: '新增',   
				    width: 400,   
				    height: 250,   
				    closed: false,   
				    cache: false,   
				    modal: true,
				    buttons:[{
						text:'保存',
						iconCls:'icon-save',
						handler:function(){
							var data = {};
							var $userId = $("#userId").val().trim();
							if(!$userId){
								$.common.alert.error('当前用户不能为空！');
								return;
							}
							var $userPid = $("#userPid").val().trim();
							if(!$userPid){
								$.common.alert.error('上级领导不能为空！');
								return;
							}
							if($userId == $userPid){
								$.common.alert.error('当前用户不能与上级领导一样');
								return;
							}
							data.userId = $userId;
							data.userPid = $userPid;
							
							var $result = $.getAjaxHtmlData("userRelationManageController/add",data);
							if($result.success){
								$("#add").window('close');
								$('#userRelationManageTable').datagrid('reload');
								$('#userRelationTable').treegrid('reload');
							}else{
								$.common.alert.error('操作失败！');
							}
						}
					},{
						text:'关闭',
						iconCls:'icon-cancel',
						handler:function(){
							$("#add").window('close');
						}
					}]
			});
		}
	},{
		id:'btncut',
		text:'删除',
		iconCls:'icon-no',
		handler:function(){
			var $select =  $('#userRelationManageTable').datagrid('getSelected');
			if(!$select){
				$.common.alert.error('请选择行！');
				return;
			}else{
				var content =  $.getAjaxHtmlData("userRelationManageController/delete?userRelationId="+$select.userRelationId);
				if(content.success ){
					$.common.alert.success('删除成功！');
					$('#userRelationManageTable').datagrid('reload');
					$('#userRelationTable').treegrid('reload');
		    	}else{
		    		$.common.alert.error('删除失败！');
		    	}
			}
		}
	}, {
		id:'flesh',
		text:'刷新',
		iconCls:'icon-reload',
		handler:function(){
			$('#userRelationManageTable').datagrid('reload');
		}
	}
		]
	});
	
}
$(function(){
	init();
});
</script>
</body>
</html>
