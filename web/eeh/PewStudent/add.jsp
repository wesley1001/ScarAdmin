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
	<title>新增学生</title>
	<!-- 引用本页面JS、CSS样式静态资源 -->
	<%@include file="/s9/common/common.jsp"%>
	<!-- 用户管理操作JS静态资源的引用 -->
	<script type="text/javascript" src="<%=basePath %>/eeh/PewStudent/js/add.js"></script>
	<script type="text/javascript" src="<%=basePath %>/eeh/PewStudent/js/number.js"></script>
</head>

<body class="dialogBody">
<form id="form1" onsubmit="return false;"
	  action="../PewStudent/forAddAjax.shtml" name="form1" method="post">
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
							所在班级：
						</td>
						<td width="80%" >
							<input type="text" id="className" name="className"
								   style="width: 300px"  value="${bo.className}"/>
										<span
												style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							姓名：
						</td>
						<td width="80%" >
							<input type="text" id="name" name="name"
								   style="width: 300px"   value="${bo.name}"/>
										<span
												style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							学号：
						</td>
						<td width="80%" >
							<input type="text" id="xhnum" name="xhnum"
								   style="width: 300px"   value="${bo.xhnum}"/>
										<span
												style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							性别：
						</td>
						<td width="80%" >
							<input type="text" id="sex" name="sex"
								   style="width: 300px"   value="${bo.sex}"/>
										<span
												style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							类型：
						</td>
						<td width="80%" >
							<select id="type" name="type">
								<option value="寄宿生">寄宿生</option>
								<option value="不参加晚自习的走读生">不参加晚自习的走读生</option>
								<option value="参加晚自习的走读生">参加晚自习的走读生</option>
							</select>
										<span
												style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							培优课程：
						</td>
						<td width="80%" >
							<input type="text" id="electiveCourse" name="electiveCourse"
								   style="width: 300px"   value="${bo.electiveCourse}"/>
										<span
												style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							教室：
						</td>
						<td width="80%" >
							<input type="text" id="classRoom" name="classRoom"
								   style="width: 300px"   value="${bo.classRoom}"/>
										<span
												style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							座位号：
						</td>
						<td width="80%" >
							<input type="text" id="seatNumer" name="seatNumer"
								   style="width: 300px"   value="${bo.seatNumer}"/>
										<span
												style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							上课时间：
						</td>
						<td width="80%" >
							<input type="text" id="schoolTime" name="schoolTime"
								   style="width: 300px"   value="${bo.schoolTime}"/>
										<span
												style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</table>
	<div class="aui_buttons">
		<button value="确定" id="z-dialog-2-OKButton"
				onclick="javascript:forAdd();"
				class="z-dlg-button z-dialog-okbutton aui_state_highlight">
			确定
		</button>
	</div>
</form>
</body>
</html>
