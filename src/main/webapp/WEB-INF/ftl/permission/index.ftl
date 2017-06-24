<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>权限列表 - 权限管理</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link href="${basePath}/js/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link rel="stylesheet" href="${basePath}/css/bootstrap-table.css">
		<link href="${basePath}/css/base.css?${_v}" rel="stylesheet"/>
		<script  src="${basePath}/js/jquery/jquery1.8.3.min.js"></script>
		<script  src="${basePath}/js/layer/layer.js"></script>
		<script  src="${basePath}/js/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script src="${basePath}/js/bootstrap-table.js"></script>
		<script src="${basePath}/js/bootstrap-table-zh-CN.js"></script>
		<script >
		$.extend($.fn.bootstrapTable.defaults, $.fn.bootstrapTable.locales['zh-CN']);
			<@shiro.hasPermission name="/permission/deletePermissionById.shtml">
			<#--根据ID数组删除角色-->
			function deleteById(ids){
				var index = layer.confirm("确定这"+ ids.length +"个权限？",function(){
					var load = layer.load();
					$.post('${basePath}/permission/deletePermissionById.shtml',{ids:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(result.resultMsg);
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</@shiro.hasPermission>
			<@shiro.hasPermission name="/permission/addPermission.shtml">
			<#--添加权限-->
			function addPermission(){
				var name = $('#name').val(),
					url  = $('#url').val();
				if($.trim(name) == ''){
					return layer.msg('权限名称不能为空。',so.default),!1;
				}
				if($.trim(url) == ''){
					return layer.msg('权限Url不能为空。',so.default),!1;
				}
				<#--loding-->
				var load = layer.load();
				$.post('${basePath}/permission/addPermission.shtml',{name:name,url:url},function(result){
					layer.close(load);
					if(result && result.status != 200){
						return layer.msg(result.message,so.default),!1;
					}
					layer.msg('添加成功。');
					setTimeout(function(){
						$('#formId').submit();
					},1000);
				},'json');
			}
			</@shiro.hasPermission>
			
			<@shiro.hasPermission name="/permission/addPermission.shtml">
			function optionsFormatter(value, row){
				var del='<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById(['+ row.id +']);">删除</a>';
				return del;
			}
			</@shiro.hasPermission>
			
			
			function queryParams(params) {
		        var temp={
		        pageSize: params.pageSize,   //页面大小  
     		    pageNumber: params.pageNumber,  //页码 
     		    findContent:$('#findContent').val(),
		        };
		        return temp;
		    }
		    
			 function query(){
				$('#table').bootstrapTable('refresh');
			 };
		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		<#--引入头部-->
		<@_top.top 3/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<#--引入左侧菜单-->
				<@_left.role 3/>
				<div class="col-md-10">
					<h2>权限列表</h2>
					<hr>
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}" 
					        			name="findContent" id="findContent" placeholder="输入权限名称">
					      </div>
					     <span class=""> <#--pull-right -->
				         	<button onclick="query();" class="btn btn-primary">查询</button>
				         	<@shiro.hasPermission name="/permission/addPermission.shtml">
				         		<a class="btn btn-success" onclick="$('#addPermission').modal();">增加权限</a>
				         	</@shiro.hasPermission>
				         	<@shiro.hasPermission name="/permission/deletePermissionById.shtml">
				         		<button type="button" id="deleteAll" class="btn  btn-danger">Delete</button>
				         	</@shiro.hasPermission>
				         </span>    
				        </div>
					<hr>
					<table id="table"
			               data-toggle="table"
			               data-url="../permission/index2.shtml"
			               data-side-pagination="server"
			               data-method="post"
			               data-content-type="application/x-www-form-urlencoded"
			               data-pagination="true"
			               data-page-list="[5, 10, 20, 50, 100, 200]"
			               data-pagination-first-text="First"
				           data-pagination-pre-text="Previous"
				           data-pagination-next-text="Next"
				           data-pagination-last-text="Last"
				           data-query-params-type="offset"
				           data-query-params="queryParams"
			               data-search="false">
			            <thead>
			            <tr>
			                <th data-field="id" data-checkbox="true"></th>
			                <th data-field="name">权限名称</th>
			                <th data-field="url">角色类型</th>
			                <th data-formatter="optionsFormatter">角色类型</th>
			            </tr>
			            </thead>
			        </table>
        
        
				</div>
			</div><#--/row-->
			<@shiro.hasPermission name="/permission/addPermission.shtml">
			<#--弹框-->
			<div class="modal fade" id="addPermission" tabindex="-1" role="dialog" aria-labelledby="addPermissionLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="addPermissionLabel">添加权限</h4>
			      </div>
			      <div class="modal-body">
			        <form id="boxRoleForm">
			          <div class="form-group">
			            <label for="recipient-name" class="control-label">权限名称:</label>
			            <input type="text" class="form-control" name="name" id="name" placeholder="请输入权限名称"/>
			          </div>
			          <div class="form-group">
			            <label for="recipient-name" class="control-label">权限URL地址:</label>
			            <input type="text" class="form-control" id="url" name="url"  placeholder="请输入权限URL地址">
			          </div>
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			        <button type="button" onclick="addPermission();" class="btn btn-primary">Save</button>
			      </div>
			    </div>
			  </div>
			</div>
			<#--/弹框-->
			</@shiro.hasPermission>
		</div>
			
	</body>
</html>