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
			function forAddSave() {
				var password=hex_md5("111111");//手动添加的订单用户默认账号密码是111111
				$("#password").val(password);
				var account=$("#account").val();
				if(''==account||null==account){
					$.ligerDialog.error("车牌号不能为空！");
					return;
				}
				var phoneNum=$("#phoneNum").val();
				if(''==phoneNum||null==phoneNum){
					$.ligerDialog.error("手机号不能为空！");
					return;
				}
				var name=$("#name").val();
				if(''==name||null==name){
					$.ligerDialog.error("称呼不能为空！");
					return;
				}
				var preTime=$("#washTime").val();
				if(''==preTime||null==preTime){
					$.ligerDialog.error("预约时间不能为空！");
					return;
				}
				var washAddr=$("#address").val();
				if(''==washAddr||null==washAddr){
					$.ligerDialog.error("预约地址不能为空！");
					return;
				}
				var url=$("#form1").attr('action');
				var data=$("#form1").serialize();
				$.ajax({
					url: url,
					dataType: 'json',
					data: data,
					success: function(r){
						if(r.success){
							parent.reload("保存成功");
						}

					},error:function(error){
						$.ligerDialog.error(error);
					}

				});

			}

		</script>
	</head>

	<body class="dialogBody">
		<form id="form1" action="<%=basePath %>/bsborder/addOrder.shtml"  method="post" onsubmit="return false">
			<input type="hidden" id="password" name="password">
			<div style="height: 5px;"></div>
			<table width="100%" height="100" align="center" cellpadding="2" cellspacing="0">
			    <tr>
			      <td width="400">
			   	<div class="z-legend"><b>基本信息</b></div>
			      <table width="100%" border="0" cellpadding="0" cellspacing="0">
			      	<tbody>
						<tr>
							<td height="30" align="right"  nowrap="nowrap"><span class="dye" >
								称呼：</span>
							</td>
							<td>
								<input type="text" id="name" name="name"   style="width: 75%;" />
							</td>

						</tr>
						<tr>
							<td height="30" align="right"   nowrap="nowrap"><span class="dye" >
								车牌号：</span>
							</td>
							<td>
								<input type="text" id="account" name="account" style="width: 75%;" />
							</td>
						</tr>
						<tr>
							<td height="30" align="right"   nowrap="nowrap"><span class="dye" >
								电话：</span>
							</td>
							<td>
								<input type="text" id="phoneNum" name="phoneNum" style="width: 75%;" />
							</td>
						</tr>
						<tr>
							<td height="30" align="right"   nowrap="nowrap"><span class="dye" >
								预约时间：</span>
							</td>
							<td>
								<input type="text" id="washTime" style="width: 75%;"  name="washTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" class="Wdate"/>
							</td>
						</tr>
						<tr>
							<td height="30" align="right"   nowrap="nowrap"><span class="dye" >
								预约地址：</span>
							</td>
							<td>
								<input type="text"  id="address" name="address" style="width: 75%;" />
							</td>
						</tr>
						<tr>
							<td height="30" align="right"   nowrap="nowrap"><span class="dye" >
								洗车类型：</span>
							</td>
							<td>
								<input type="text" id="washType" name="washType" style="width: 75%;"/>
							</td>
						</tr>
						<tr>
							<td height="30" align="right"  nowrap="nowrap"><span class="dye" >
								备注：</span>
							</td>
							<td>
								<textarea id="discription" name="discription"  style="width: 75%;"></textarea>
							</td>
						</tr>
						<tr>
							<td height="30" align="right"   nowrap="nowrap"><span class="dye" >
								预约金额：</span>
							</td>
							<td>
								<input type="text" id="price" name="price" style="width: 75%;"/>
							</td>
						</tr>
						<tr>
							<td height="30" align="right"  style="padding-right: 5px;" nowrap="nowrap"><span class="dye" >
								支付状态：</span>
							</td>
							<td>
								<select name="orderStatus" id="orderStatus" style="width: 75%">
									<option value="-1">未支付</option>
									<option value="1" >支付完成</option>
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
