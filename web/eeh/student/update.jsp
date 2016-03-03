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
	<title>修改学生</title>
	<!-- 引用本页面JS、CSS样式静态资源 -->
	<%@include file="/s9/common/common.jsp"%>
	<!-- 用户管理操作JS静态资源的引用 -->
	<script type="text/javascript" src="<%=basePath %>/eeh/student/js/update.js?v=1"></script>
	<script type="text/javascript" src="<%=basePath %>/eeh/student/js/number.js"></script>
	<script type="text/javascript" src="<%=basePath %>s9/res/js/util/md5.js"></script>
</head>

<body class="dialogBody">
<form id="form1" onsubmit="return false;"
	  action="../student/forUpdateAjax.shtml" name="form1" method="post">
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
							班级：
						</td>
						<td width="80%" >
							<select type="text" id="classId" name="classId" style="width: 300px"  value="${bo.classId}">
								<option value="">选择班级</option>
								<c:forEach items="${gradeList}" var="grade" varStatus="vs">
									<c:choose>
										<c:when test="${grade.name==bo.classId}">
											<option value="${bo.classId}" selected="selected">${bo.classId}</option>
										</c:when>
										<c:otherwise>
											<option value="${grade.name}" >${grade.name}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>	
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
												
						</td>
					</tr>

					<tr>
						<td width="20%" height="30" align="right">
							姓名：
						</td>
						<td width="80%" >
							<input type="text" id="name" name="name" style="width: 300px"   value="${bo.name}"/>
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							性别：
						</td>
						<td width="80%" >
							<select  id="sex" name="sex" style="width: 300px"  >
								<option value="">选择性别</option>
								<option value="男" <c:if test="${bo.sex=='男'}">selected="selected" </c:if>>男</option>
								<option value="女" <c:if test="${bo.sex=='女'}">selected="selected" </c:if>>女</option>
							</select>
							<span style="color: red; padding-left: 2px; padding-top: 13px;">*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							用户名：
						</td>
						<td width="80%" >
							<input type="text"  style="width: 300px;" readonly="readonly"   value="${bo.xhnum}"/>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							密码：
						</td>
						<td width="80%" >
							<input type="password"  style="width: 300px;" id="password" name="password"   value="${bo.password}"/>
						</td>
					</tr>
					<tr>
						<td width="20%" height="30" align="right">
							确认密码：
						</td>
						<td width="80%" >
							<input type="password"  style="width: 300px;" id="password2" name="password2"   value="${bo.password}"/>
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
