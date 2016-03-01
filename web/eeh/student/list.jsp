<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<title>学生管理</title>
		<!-- 引用本页面JS、CSS样式静态资源 -->
		<%@include file="/s9/common/common.jsp"%>
		<!-- 用户管理操作JS静态资源的引用 -->
		    <link rel="stylesheet" type="text/css" href="<%=basePath%>/web/upload/uploadify.css">
			<link rel="stylesheet" type="text/css" href="<%=basePath%>/s9/res/js/ligerUI/skins/Aqua/css/ligerui-all.css"	/>
		    <link href="<%=basePath%>/s9/res/js/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
		    <link href="<%=basePath%>/s9/res/js/ligerUI/skins/Gray/css/grid.css" rel="stylesheet" type="text/css" />
		    <link  rel="stylesheet" type="text/css" href="<%=basePath%>/s9/res/js/calendar/skin/WdatePicker.css">
		    <!-- JS静态资源的引用 -->
			<script type="text/javascript" src="<%=basePath%>/s9/res/js/jquery.min.js"></script>
			<script type="text/javascript" src="<%=basePath%>/s9/res/js/ligerUI/js/ligerui.all.js"></script>
			<script type="text/javascript"  src="<%=basePath%>/s9/res/js/calendar/WdatePicker.js"></script>
		    <script type="text/javascript" src="<%=basePath%>/web/upload/jquery.uploadify.min.js"></script>
			<script type="text/javascript" src="<%=basePath%>/eeh/student/js/list.js?v=7"></script>
			<script type="text/javascript" src="<%=basePath %>/eeh/student/js/upload.js"></script>
			
	</head>
	<body class="z-body-detail" style="overflow: hidden">
	    <input type="hidden" id="classId" name="classId" value="${classId}">
		<table width="100%" id="js_layoutTable" border="0" cellspacing="0" cellpadding="0" height="100%" class="js_layoutTable">
			<tbody>
				<tr>
					<td style="width:70%">
						<div class="z-toolbar" id="ToolBar1" >
							<div class="z-toolbar-ct">
								<div class="z-toolbar-overflow"> 
									<div class="z-toolbar-nowrap">
										<a href="javascript:void(0);" class="z-btn z-btn-flat" onclick="add();">
											<img class="icon021a4" src="../s9/res/img/icon000.png"><b>添加学生<i></i></b>
										</a>

										<a href="javascript:void(0);"  class="z-btn z-btn-flat" onclick="delObj();">
											<img class="icon021a4" src="../s9/res/img/icon000.png"><b>删除<i></i></b>
										</a>
										<a href="javascript:download();"  class="z-btn z-btn-flat">
											<img class="icon021a4" src="../s9/res/img/icon000.png"><b>下载标准表格<i></i></b>
										</a>


									</div>
								</div>
							</div>
						</div>
						
					</td>
					<td>
						<a href="javascript:void(0);"  class="z-btn z-btn-flat" id="importExcel">
							<img class="icon021a1" src="../s9/res/img/icon000.png"><b>导入<i></i></b>
						</a>
					</td>
				</tr>
				<tr valign="top">
					<!-- 数据信息 --> 
					<td style="padding: 5px; height: auto;" colspan="2">
						<div class="l-loading" style="display:block" id="pageloading"></div> 
						<div class="l-clear"></div>
						<div id="maingrid"></div>
					</td> 
				</tr>
			</tbody>
		</table>

	</body>
</html>
<script type="text/javascript">
	// 初始化加载
	$(function(){
		var url='../student/findAllList.shtml';
		findAllList(url);
	})
	/**
	 * 下载标准表格
	 * **/
	function download(){
		window.location.href="<%=basePath %>/eeh/excel/班级学生表.xls";
	}
</script>