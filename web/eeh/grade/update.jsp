<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html;charset=utf-8"
		 pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
	<title>修改班级</title>
	<!-- 引用本页面JS、CSS样式静态资源 -->
	<%@include file="/s9/common/common.jsp"%>
	<!-- 用户管理操作JS静态资源的引用 -->
	<script type="text/javascript" src="<%=basePath %>/eeh/grade/js/update.js"></script>
	<script type="text/javascript" src="<%=basePath %>/eeh/grade/js/number.js"></script>
</head>

<body class="dialogBody">
<form id="form1" onsubmit="return false;"
	  action="../grade/forUpdateAjax.shtml" name="form1" method="post">
	<input type="hidden" id="id" name="id" value="${bo.id}"/>
	<table width="100%"  align="center" cellpadding="2"
		   cellspacing="0">
		<tr>
			<td width="400">
				<div class="z-legend">
					<b>基本信息</b>
				</div>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tbody>
					<tr>
						<td width="20%" height="30" align="right">
							班级名称：
						</td>
						<td width="80%" >
							<input type="text" id="name" name="name" style="width: 300px" value="${bo.name}" />班
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							选择年级：
						</td>
						<td width="80%" >
							<select id="gradeName" name="gradeName" style="width:300px">
								<option value="">选择年级</option>
								<option value="1">一年级</option>
								<option value="2">二年级</option>
								<option value="3">三年级</option>
								<option value="4">四年级</option>
								<option value="5">五年级</option>
								<option value="6">六年级</option>
								<option value="7">七年级</option>
								<option value="8">八年级</option>
								<option value="9">九年级</option>
								<option value="10">十年级</option>
								<option value="11">十一年级</option>
								<option value="12">十二年级</option>
							</select>
							<input type="hidden" id="gradeId" name="gradeId"/>
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							班主任：
						</td>
						<td width="80%" >
							<input type="text" id="teacherName" name="teacherName" value="${bo.teacherName}" style="width: 300px"  />
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							班级人数：
						</td>
						<td width="80%" >
							<input type="text" id="gradenum" name="gradenum" value="${bo.gradenum}" style="width: 300px"  onkeyup="clearNoNum(this)" value="${bo.gradenum}"/>
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</table>
	<div class="aui_buttons">
		<button value="确定" id="z-dialog-2-OKButton"
				onclick="javascript:forUpdate();"
				class="z-dlg-button z-dialog-okbutton aui_state_highlight">
			确定
		</button>
	</div>
</form>
</body>
</html>
<script>

	$(function() {
		$("#gradeName").val("${bo.gradeName}");
	});
</script>
