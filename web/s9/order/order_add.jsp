<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html;charset=utf-8"	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<!-- 引用本页面JS、CSS样式静态资源 -->
		<%@include file="/s9/common/common.jsp"%>
		<!-- 用户管理操作JS静态资源的引用 -->
		<link  rel="stylesheet" type="text/css" href="<%=basePath %>/s9/res/js/calendar/skin/WdatePicker.css">
		<script type="text/javascript" src="<%=basePath %>/s9/order/js/order.js"></script>
		<script type="text/javascript"  src="<%=basePath %>/s9/res/js/calendar/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=basePath %>/s9/res/js/util/md5.js"></script>

		<script type="text/javascript">
		 $(function (){
				var flag="${backInfo}";
				if(flag=='1'){
					window.parent.reload("修改成功");
				}else if(flag=='0'){
					$.ligerDialog.error("修改失败");
					return;
				}
			});
		</script>
	</head>

	<body class="dialogBody">
		<form id="form1" action="/bsborder/addOrder.shtml"  method="post" onsubmit="return false">
			<input type="hidden" id="password" name="password">
			<div style="height: 5px;"></div>
			<table width="100%" height="100" align="center" cellpadding="2" cellspacing="0">
			    <tr>
			      <td width="400">
			   	<div class="z-legend"><b>基本信息</b></div>
			      <table width="100%" border="0" cellpadding="0" cellspacing="0">
			      	<tbody>
						<tr>
							<td height="30" align="right"  style="padding-right: 5px;" nowrap="nowrap"><span class="dye" >
								称呼：</span>
							</td>
							<td>
								<input type="text" id="name" name="name"   />
							</td>

						</tr>
						<tr>
							<td height="30" align="right"  style="padding-right: 5px;" nowrap="nowrap"><span class="dye" >
								车牌号：</span>
							</td>
							<td>
								<input type="text" id="account" name="account" />
							</td>
						</tr>
						<tr>
							<td height="30" align="right"  style="padding-right: 5px;" nowrap="nowrap"><span class="dye" >
								电话：</span>
							</td>
							<td>
								<input type="text" id="phoneNum" name="phoneNum" />
							</td>
						</tr>
						<tr>
							<td height="30" align="right"  style="padding-right: 5px;" nowrap="nowrap"><span class="dye" >
								预约时间：</span>
							</td>
							<td>
								<input type="text" id="preTime" name="preTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" class="Wdate"/>
							</td>
						</tr>
						<tr>
							<td height="30" align="right"  style="padding-right: 5px;" nowrap="nowrap"><span class="dye" >
								预约地址：</span>
							</td>
							<td>
								<input type="text" id="washAddr" name="washAddr" />
							</td>
						</tr>
						<tr>
							<td height="30" align="right"  style="padding-right: 5px;" nowrap="nowrap"><span class="dye" >
								洗车类型：</span>
							</td>
							<td>
								<input type="text" id="washType" name="washType" />
							</td>
						</tr>
						<tr>
							<td height="30" align="right"  style="padding-right: 5px;" nowrap="nowrap"><span class="dye" >
								备注：</span>
							</td>
							<td>
								<input type="text" id="remark" name="remark" />
							</td>
						</tr>
						<tr>
							<td height="30" align="right"  style="padding-right: 5px;" nowrap="nowrap"><span class="dye" >
								预约金额：</span>
							</td>
							<td>
								<input type="text" id="total" name="total" />
							</td>
						</tr>
						<tr>
							<td height="30" align="right"  style="padding-right: 5px;" nowrap="nowrap"><span class="dye" >
								支付状态：</span>
							</td>
							<td>
								<select name="payStatus" id="payStatus" style="width: 75%">
									<option value="1" >支付完成</option>
									<option value="-1">未支付</option>
								</select>
							</td>
						</tr>
				      </tbody></table></td>
				    </tr>
					</table>
						<div class="aui_buttons">
								<button value="确定" id="z-dialog-2-OKButton" onclick="forAddSave();"
									class="z-dlg-button z-dialog-okbutton aui_state_highlight">
									确定
								</button>
							</div>
		</form>
	</body>
</html>
