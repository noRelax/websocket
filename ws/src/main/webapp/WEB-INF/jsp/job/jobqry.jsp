<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<html>
<head>
<meta charset="utf-8">
<title>job管理</title>
 <base href="${web}">


</head>
<body>
  <div class="job" >
    <table id="jobTable" ></table>  
  </div> 
    <div id="add"   style="display:none">
		  <form id="add_form">
			 <p> 任务规则:&nbsp;&nbsp;&nbsp;<input name="jobRule" id="jobRule" width = 300><p/>
	      </form>
	</div>

<script> 

function onOff(jobId){
	var $result = $.getAjaxHtmlData("jobController/onOff?iJobId=" +jobId) 
	if($result.success){
		$('#jobTable').datagrid('reload');
	}else{
		$.common.alert.error('操作失败！');
	}
}

$(function(){
    var jobManagePage = function(){
    	function init(){
    		$('#jobTable').datagrid({
				title:'job Manage',
				iconCls:'icon-save',
				width:$("#center").width()-250-2,
				height:$("#center").height()-48,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'jobController/jobpage',
				sortName: 'jobName',
				sortOrder: 'desc',
				singleSelect:true,
				remoteSort: false,
				idField:'jobName',
				columns:[
                    [{field:'jobName',title:'任务名',width:150,align:'center'},
                     {field:'jobClass',title:'任务调度类',width:250,align:'center'},
                     {field:'jobGroup',title:'任务组',width:250,align:'center'},
                     {field:'jobRule',title:'任务规则',width:150,align:'center'},
                     {field:'opt',title:'状态',width:100,align:'center',
 						formatter:function(value,rec){
 							return '<span style="color:red" onclick = "onOff('+rec.jobId+')">'+(rec.status == 1 ? '启用' :'禁用')+'</span>';
 						}
 					}]
				],
				pagination:true,
				rownumbers:true,
				toolbar:[{
					id:'btnadd',
					text:'编辑',
					iconCls:'icon-add',
					handler:function(){
						var $select =  $('#jobTable').datagrid('getSelected');
						if(!$select){
							$.common.alert.error('请选择行！');
							return;
						}
						$("#jobRule").val($select.jobRule);
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
									var $jobRule = $("#jobRule").val().trim();
									if(!$jobRule){
										$.common.alert.error('任务规则不能为空！');
										return;
									}
									data.jobId = $select.jobId;
									data.jobRule = $jobRule;
									
									var $result = $.getAjaxHtmlData("jobController/edit",data);
									if($result.success){
										$("#add").window('close');
										$('#jobTable').datagrid('reload');
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
				}]
			});
			
    	}
    	
    	return {init:init};
    }();
    jobManagePage.init();
    
});
</script>  
</body>
</html>