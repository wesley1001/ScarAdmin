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
	<title>新增课程</title>
	<!-- 引用本页面JS、CSS样式静态资源 -->
	<%@include file="/s9/common/common.jsp"%>
	<!-- 用户管理操作JS静态资源的引用 -->
	<link  rel="stylesheet" type="text/css" href="<%=basePath%>/s9/res/js/calendar/skin/WdatePicker.css">
	<script type="text/javascript"  src="<%=basePath%>/s9/res/js/calendar/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=basePath %>/eeh/Course/js/add.js"></script>
	<script type="text/javascript" src="<%=basePath %>/eeh/Course/js/number.js"></script>
</head>

<body class="dialogBody">
<form id="form1" onsubmit="return false;"
	  action="../Course/forAddAjax.shtml" name="form1" method="post">
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
							选择科目：
						</td>
						<td width="80%" >
							<select id="kemu" name="kemu" style="width:300px">
								<option>请选择科目</option>
								<c:forEach items="${subjectList}" var="subject" varStatus="vs">
									<option value="${subject.id}">${subject.name}</option>
								</c:forEach>
							</select>
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>

					<tr>
						<td width="20%" height="30" align="right">
							上线人数：
						</td>
						<td width="80%" >
							<input type="text" id="peopleMax" name="peopleMax"
								   style="width: 300px"  onkeyup="clearNoNum(this)"/>
										<span
												style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							授课老师：
						</td>
						<td width="80%" >
							<select id="grade" name="grade" style="width:300px">
								<option>请选择</option>
								<c:forEach items="${teacherList}" varStatus="vs" var="teacher">
									<option value="${teacher.id}">${teacher.name}</option>
								</c:forEach>
							</select>
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							上课时间：
						</td>
						<td width="80%" >
							<select id="banji" name="banji" style="width:300px">
								<option>请选择</option>
								<c:forEach items="${timeList}" var="time" varStatus="vs">
									<option value="${time.id}">${time.time}</option>
								</c:forEach>
							</select>
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>

				<%--	<tr>
						<td width="20%" height="30" align="right">
							开始时间：
						</td>
						<td width="80%" >
							<input name="startTime"  type="text" id="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" class="Wdate" />
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							结束时间：
						</td>
						<td width="80%" >
							<input name="endTime"  type="text" id="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" class="Wdate" />
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							上课时间：
						</td>
						<td width="80%" >
							<input name="schoolTime"  type="text" id="schoolTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" class="Wdate" />
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>--%>
					<tr>
						<td width="20%" height="30" align="right">
							授课教室：
						</td>
						<td width="80%" >
							<select id="classRoom" name="classRoom" style="width:300px">
								<option>请选择</option>
								<c:forEach items="${classRoomList}" varStatus="vs" var="room">
									<option value="${room.id}">${room.name}</option>
								</c:forEach>
							</select>
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
				onclick="javascript:forAdd();"
				class="z-dlg-button z-dialog-okbutton aui_state_highlight">
			确定
		</button>
	</div>
</form>
</body>
</html>
