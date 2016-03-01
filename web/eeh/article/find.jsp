<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
  <head>
	  <meta http-equiv="X-UA-Compatible" content="edge" />
  <link rel="stylesheet" type="text/css" href="<%=basePath%>/s9/res/js/ligerUI/skins/Aqua/css/ligerui-all.css" >
<link rel="stylesheet" type="text/css" href="<%=basePath%>/s9/res/css/spirites.css" >
<link rel="stylesheet" type="text/css" href="<%=basePath%>/s9/res/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/s9/res/css/default.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/web/upload/uploadify.css"> 
<link  rel="stylesheet" type="text/css" href="<%=basePath%>/s9/res/js/calendar/skin/WdatePicker.css">
<script type="text/javascript"  src="<%=basePath%>/s9/res/js/calendar/WdatePicker.js"></script> 
	<script type="text/javascript" src="<%=basePath%>/web/ckeditor/ckeditor.js"></script>
		<script type="text/javascript" src="<%=basePath%>/s9/inatitution/js/config.js"></script>
<script type="text/javascript" src="<%=basePath%>/s9/res/js/jquery.min.js"></script>
 <script type="text/javascript" src="<%=basePath%>/web/upload/jquery.uploadify.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/s9/res/js/ligerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>/web/upload/upload.js"></script>

<script type="text/javascript" charset="utf-8" src="<%=basePath%>/web/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>/web/ueditor/_examples/editor_api.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="<%=basePath%>/web/ueditor/lang/zh-cn/zh-cn.js"></script>


<script type="text/javascript">
var combox;
var dialog=null;
 //点击缩略图
  function fun(obj){
		var url="../imageServer.shtml?type=image&imageType="+obj;
		dialog=$.ligerDialog.open({ 
		height: 600,
		width:960,
		url: url,
		title:'图片服务器'
	 	});
	}
 //关闭弹出窗口，并为tex框赋值
	function selectPic(str,imageType){
 		if(imageType=='mobile'){
 			$("#mobileThumbnail").val(str);
 		}else{
			$("#attachmentUrl").val(str);
 		}
		dialog.close();
	}
 function clickPic(obj){
	 $("#thumbnail").val(obj);
		dialog.close();
 }
 $(function() {
	var config=CKEDITOR.editorConfig = function(config)
				{
				    config.extraPlugins += (config.extraPlugins?',code':'code');
				    config.extraPlugins += (config.extraPlugins?',idcard':'idcard');
				    config.filebrowserUploadUrl = '../fileUpload.shtml?type=File' ;
					config.filebrowserImageUploadUrl = '../fileUpload.shtml?type=Image' ;
				    config.filebrowserImageBrowseUrl = '../browerServer.shtml?type=image'; 
				    config.toolbar = [[ 'Image', 'Code','Idcard' ]];
				};
	 CKEDITOR.replace('ckContent',config);
	 ajax();
})
  //保存编辑事件
	function save(){
		//$("#thumbnail").val($("#thumbnailName").attr('src'));
		$("#articleType").val(combox.getValue());
		var content=UE.getEditor('editor',{ enterTag:''}).getContent();
		$("#content").val(content);
		var infoParam="";//信息参数
		var infoParamObj=$("input[name='checkbox']");
		infoParamObj.each(function(index){
			var value=$(this).attr('checked');
			if(value){
				if(index<infoParamObj.length-1){
					infoParam+=$(this).attr('value')+";";
				}else{
					infoParam+=$(this).attr('value');
				}
			}
		})
		$("#infoParam").val(infoParam);
		//获取文章属性信息
		    var keyArr= Array();
			 var valueArr= Array();
			 var jsonStr='';
			$("input[name$='keys']").each(function(){
				var value=$(this).val();
				 if(value!=''&&value!=null){
					 keyArr.push(value);
				 }
			 }); 
			$("input[name$='values']").each(function(){
				var value=$(this).val();
				 if(value!=''&&value!=null){
					 valueArr.push(value);
				 }
			 });
			
			for(var i=0;i<keyArr.length;i++){
				if(i<keyArr.length-1){
					jsonStr+=keyArr[i]+":"+valueArr[i]+",";
				}else{
					jsonStr+=keyArr[i]+":"+valueArr[i];
				}
			}
		  //获取文章附件信息
		    //获取文章附件信息
		    var ArticleAttach='';
		    var itemList=$(".uploadify-queue-item");
		    var AttachArray = ''; 
		    var viewName=$("#viewName").val();
		    itemList.each(function(index){
		    	   var ArticleAttach =  Object(); 
		    		ArticleAttach.filePath=$(this).attr('filepath');
		    		ArticleAttach.fileName=$(this).attr('filename');
		    		ArticleAttach.uploadAuthor=$(this).attr('uploadauthor');
		    		ArticleAttach.uploadTime=$(this).attr('uploadtime');
		    		var id=$(this).attr('tid');
		    		ArticleAttach.viewName=$("#"+id).val();
		    		var finalInfoStr = JSON.stringify(ArticleAttach);
		    		if(index<itemList.length-1){
		    			AttachArray+=finalInfoStr+",";
		    		}else{
		    				AttachArray+=finalInfoStr;
		    		}
		    		
		    });
		    var url="../article/updArticle.shtml?flag=update";
		    if(AttachArray!=''){
		    	url+="&articleAttachmentArr="+AttachArray;
		    }
		    if(jsonStr!=''){
		    	url+="&articleAttrArr="+jsonStr;
		    }
		    //缩略图重新赋值
		    $("#thumbnail").val($("#attachmentUrl").val());
		    var data=$("#form1").serialize();
		    $.ajax({
			url:url,
			type:"post",
			dataType:"json",
			data:data,
			async:false, 
			beforeSend:function(XMLHttpRequest){
			},
			success:function(msg){
				$.ligerDialog.success("修改成功",function(){
					window.close();
					opener.location.reload();
				});
				
			},error:function(){
				$.ligerDialog.error("服务器异常");
				return;
			}});
	}
   //编辑
      function editeBtnClick(){
		$("#saveBtn").show();
		$("#editeBtn").hide();
		 var html=$("#ckeditor").html();
		 $("#ckeditor").remove();
		 $("#editor").show();
		 UE.getEditor('editor',{ enterTag:''}).setHeight(400);
		 editor.setContent(html);
		 $(".uploadify-button").width(105);
		 setEnabled();
	
	}
 	function onload(){
 		ajax();
 	}
 	
	init();
	
    //ajax获取数据
    function ajax(){
    	var articleId=$("#articleId").val();
		var url="../article/findArticleBo.shtml";
    	$.ajax({
		url:url,
		type:"post",
		dataType:"json",
		data:{"articleId":articleId},
		async:false, 
		beforeSend:function(XMLHttpRequest){
		},
		success:function(msg){
			var bo=msg.articleBo;
			var attrList=msg.attrList;
			var attachList=msg.attachList;
			/**文章类型选择框初始化**/
			var url='../codeManage/getCodeValueAjax.shtml';
			initSlectValue(url);
			combox.setValue(bo.articleType);
			 $(".uploadify-button").width(105);
			//初始化信息参数并选中
			var infoParam=bo.infoParam;
			if(infoParam!=''&&infoParam!=null){
				var infoParamObj=infoParam.split(";");
				$("input[name='checkbox']").each(function(index){
					for(var i=0;i<infoParamObj.length;i++){
						if(infoParamObj[i]==$(this).attr('value')){
							$(this).attr('checked',"checked");
						}
					}
				});
			}
			//文章模板
		     var attrTemplateList=msg.listSelect;
		     var html='<select id="articleTemplate" name="articleTemplate" style="width:25%;"><option value="">默认模版</option>';
		     for(var i=0;i<attrTemplateList.length;i++){
		     		if(attrTemplateList[i].templateCode==bo.articleTemplate){
		     		 	html+='<option selected="selected"  value='+attrTemplateList[i].templateCode+'>'+attrTemplateList[i].templateName+'</option>';
		     		}else{
		     			html+='<option value='+attrTemplateList[i].templateCode+'>'+attrTemplateList[i].templateName+'</option>';
		     		}
		     }
		     html+='</select>';	
		     $('#templateHtml').html(html);
			$("#articleSource").val(bo.articleSource);
			/**为文章信息初始化值**/
			$("#articleTitle").val(bo.articleTitle);
			$("#ckeditor").html(bo.content);	 
			$("#author").val(bo.author);	 
			$("#ckeditor").show();	
			$("#classificationName").val(bo.classificationName);
			$("#classification").val(bo.classification);
			$("#remark").val(bo.remark);
			$("#keyword").val(bo.keyword);
			$("#description").val(bo.description);
			$("#sendTime").val(bo.sendTime);
			$("#attachmentUrl").val(bo.thumbnail);
			$("#mobileThumbnail").val(bo.mobileThumbnail);
			$("#viewName").val(bo.viewName);
			$("#editor").show();
			$('#expirationDate').val(bo.expirationDate);
			var html=$("#ckeditor").html();
			$("#ckeditor").remove();
		     var editor = new baidu.editor.ui.Editor({ initialFrameWidth:800,'enterTag':'',initialContent:html  });
		     if('undefined'!=editor){
		    	  editor.render("editor");
		     }
		     
			$("#thumbnailName").attr('src',bo.thumbnail);
			/**文章属性初始化**/
			initArticleAttrValue(attrList);
			/**文章附件初始化**/
			initArticleAttachValue(attachList);
			
			
		},error:function(){
			$.ligerDialog.error("服务器异常");
			return;
		}});
    }
	/**文章属性初始化**/
	function initArticleAttrValue(attrList){
		var length=attrList.length;
		$("#articleAttrHtml").attr('style','');
		var str='';
		for(var i=0;i<attrList.length;i++){
			str+="<tr>";
			str+="<td><input type='text' name='keys' style='width:80px' id="+attrList[i].id+" value="+attrList[i].articleKey+"></input>";
			str+="-<input type='text' name='values' style='width:300px;'  value="+attrList[i].articleValue+"></input>";
			str+='<a href="javascript:del('+attrList[i].id+');"  class="z-btn z-btn-flat" ><img class="icon404a3" src="../s9/res/img/icon000.png"><b>删除<i></i></b></a>';
			str+="</td>"
				str+="</tr>";
		}
		if(length>0){
			$("#tabContent").append(str);
		}
		
	}
	/**文章类型选择框初始化**/
	function initArticleAttachValue(attachList){
		var str='';
		var length=attachList.length;
		for(var i=0;i<length;i++){
			var bo=attachList[i];
			str+='<div tid="'+bo.id+'" class="uploadify-queue-item" filepath="'+bo.filePath+'" filename="'+bo.fileName+'" uploadauthor="'+bo.uploadAuthor+'" uploadtime="'+bo.uploadTime+'">';					
			str+='<div class="cancel">';
			str+='<a href="javascript:delAttache('+bo.id+')">移除</a>';
			str+='</div>';
			str+='<span class="fileName">'+bo.fileName+'</span>\t';
			str+='<span class="viewName"><input type="text" id="'+bo.id+'"  value="'+bo.viewName+'"/></span>\t';
			str+='<span class="data"><img class="icon403a12" src="../s9/res/img/icon000.png"></span>';	
			str+='<div class="uploadify-progress">';						
			str+='<div class="uploadify-progress-bar" style="width: 100%;">';
			str+='</div>';					
			str+='</div>';				
			str+='</div>';
		}
		$("#fileAttachementDiv").after(str);
	}
	function init(){
		var backinfo = $("#backinfo").val();
		if(backinfo!=''){
			$.ligerDialog.success(backinfo);
		}
	}
	function look(obj){
		$("#"+$(obj).attr('id')).val($(obj).val());
	}

//设置页面元素只读属性
function setDisbaled(){
	$("#articleTypeSelect").ligerGetComboBoxManager().setDisabled();
	$(":checkbox").each(function(){
		$(this).attr("disabled","disabled");
	});
	$(":input").each(function(){
		$(this).attr("disabled","disabled");
	});
	//隐藏附件
	$("#file_upload").attr('style','display:none');
	$("#file_upload-button").attr('style','display:none');
	$("a").live('click', function(event) { 
 		 vent = event ? event : window.event;
	    if(event.preventDefault){
	      event.preventDefault();
	    }else{
	      event.returnValue = false;
	    } 
	});
	
}
//取消页面元素只读属性
function setEnabled(){
	$("#articleTypeSelect").ligerGetComboBoxManager().setEnabled();
	$(":checkbox").each(function(){
		$(this).removeAttr("disabled");
	});
	$(":input").each(function(){
		$(this).removeAttr("disabled");
		$(this).removeAttr("readonly");
	});
	$("a").each(function(){
		$(this).removeClass("z-btn-disabled");
		$(this).unbind('click');
	})
	//显示附件
	$("#file_upload").show();
	$("#file_upload-button").show();
	$("#thumbnailName").bind('click',function(){
		fun();
	});
}
//删除文章属性
 function del(obj){
	 $("#"+obj).parents('tr:first').remove();
 }

 //删除文章附件
function delAttache(obj){
		 $("#"+obj).remove();
}
 //增加文章属性
  function addPro(){
	 var timestamp = Date.parse( Date()); 
	 		str="<tr>";
			str+="<td><input type='text' style='width:80px' name='keys' id='"+timestamp+"'></input>";
			str+="-<input type='text' style='width:300px;' name='values'></input>";
			str+='<a href="javascript:del('+timestamp+');"  class="z-btn z-btn-flat" ><img class="icon404a3" src="../s9/res/img/icon000.png"><b>删除<i></i></b></a>';
			str+="</td>"
			str+="</tr>";
	 	    $("#tabContent").append(str);
 }
 function initSlectValue(url){
 	//初始化文章类型
	 combox=$("#articleTypeSelect").ligerComboBox({
	        width: 380,
	        checkbox:false,
			isMultiSelect: false,   //是否多选
            isShowCheckBox: false,  //是否选择复选框
	        selectBoxWidth: 380,
	        selectBoxHeight: 280, 
	        valueField: 'id',
	        tree: { 
					url: url+"?codeId=102", 
					checkbox:false,
					ajaxType: 'post'
					
				}
	    });
	
 }
</script>
</head>
<body class="z-body-detail" style="background-color:white;height:1000;overflow: hidden;" >
   	<form onsubmit="return check();" action="" id="form1" name="form1" method="post" enctype="multipart/form-data">
   	<input type="hidden" id="uploadAuthor" value="${user.userName}"/>
   	<input type="hidden" id="rootPath" name="rootPath" value="${param.rootPath}"/>
	<input type="hidden" id="articleId" name="articleId" value="${articleId }"/>
	<input type="hidden" id="content" name="content"/>
	<input type="hidden" id="backinfo" name="backinfo" value="${backinfo}"/>
	<input type="hidden" id="uploadAuthor" value="${user.userName}"/>
	<input type='hidden' id="updateUserCode" name="updateUserCode" value="${user.userName}"/>
   	<div id="_DivContainer" style="overflow: auto; width: 100%;height:100%; position: absolute; z-index: 2;">
   	<table width="100%" id="js_layoutTable" border="0" cellspacing="0" cellpadding="0" height="40" class="js_layoutTable">
  <tbody><tr>
    <td align="left" id="trToolbar">
		<div class="z-toolbar" id="Toolbar" style="position:fixed;left:0px;top:0px;width:100%;z-index:999999">
		<div class="z-toolbar-ct">
		<div class="z-toolbar-overflow">
		<div class="z-toolbar-nowrap">
			<a href="javascript:save();"  id="saveBtn" class="z-btn z-btn-flat"><img class="icon003a16" src="<%=basePath%>/s9/res/img/icon000.png"><b>
			  保存
			<i></i></b></a>
			<a href="javascript:void(0);"  id="BtnPublish" class="z-btn z-btn-flat z-btn-disabled"><img class="icon003a13" src="<%=basePath%>/s9/res/img/icon000.png"><b>
			  发布
			<i></i></b></a>
			
       </div></div></div></div>
		</td></tr></tbody></table>
          <table width="100%" cellpadding="12" cellspacing="10">
           <tbody>
            <tr>
            <td height="28" width="30%" align="right" style="padding-right: 5px;" nowrap="nowrap"><font color="#ff0000">*</font><span class="dye" >文章类型：</span>
            </td>
            <td colspan="3" align="left">
            	<input name="articleTypeSelect" type="text" id="articleTypeSelect" style="width: 380px;" >
            	<input name="articleType" type="hidden" id="articleType" >
            </td>
           </tr>
           <tr>
            <td height="28" align="right" style="padding-right: 5px;"><font color="#ff0000">*</font><span class="dye" nowrap="nowrap">文章标题：</span>
            </td>
            <td colspan="3" align="left"><input name="articleTitle" type="text" id="articleTitle" style="width: 380px;">
            </td>
           </tr>
            <tr>
	            <td height="28" align="right" style="padding-right: 5px;" nowrap="nowrap"><span class="dye">手机缩略图：</span>
	            </td>
	            <td colspan="3" align="left">
	            	   <input type="text" name="mobileThumbnail"  id="mobileThumbnail" style="width: 350px;" onclick="CKEDITOR.tools.callFunction(5, this,5); return false;"/>
	            	   <a href="javascript:void(0);" id="Button6" class="z-btn z-btn-flat" onclick="fun('mobile');">
						<img class="icon021a2" src="../s9/res/img/icon000.png"><b>浏览<i></i></b>
					   </a>
	            </td>
           </tr>
           <tr>
            <td height="28" align="right" style="padding-right: 5px;" nowrap="nowrap"><span class="dye">来源：</span>
            </td>
            <td colspan="3" align="left"><input name="articleSource" type="text" style="width: 380px;" id="articleSource" size="50" value="${article.articleSource }" ></td>
           </tr>
            <tr>
            <td height="28" align="right" style="padding-right: 5px;" nowrap="nowrap"><span class="dye">作者：</span>
            </td>
            	<td colspan="3" align="left"><input name="author" type="text" id="author" style="width: 380px;">
            </td>
           </tr>
               <tr>
            <td height="28" align="right" style="padding-right: 5px;" nowrap="nowrap"><span class="dye">缩略图：</span>
            </td>
            	<td colspan="3" align="left">
            	 <input type="text" name="attachmentUrl"  id="attachmentUrl" style="width: 380px;" onclick="CKEDITOR.tools.callFunction(4, this,4); return false;"/>
            	   <input type="hidden" id="thumbnail" name="thumbnail"/>
            	   <a href="javascript:void(0);" id="Button6" class="z-btn z-btn-flat" onclick="fun('');">
											<img class="icon021a2" src="../s9/res/img/icon000.png"><b>浏览<i></i></b>
										</a>
			  		<div style="display: none">
			  		 	<textarea id="ckContent" name="ckContent" rows="1" cols="1"  ></textarea>
			  		</div>
            </td>
           </tr>
           <tr id="articleTypeTr">
            <td height="28" align="right" style="padding-right: 5px;"><span class="dye">文章属性：</span></td>
             <td colspan="7">
        	属性 - 值 ，点击  
        	<a href="javascript:addPro();" id="addProBtn"  class="z-btn z-btn-flat"><img class="icon404a8" src="../s9/res/img/icon000.png"><b>增加属性<i></i></b></a>
        	<div></div>
        	<table style="width: 100%" id="tabContent">
        	</table>
        </td>
           </tr>
           <tr>
	            <td height="28" align="right" style="padding-right: 5px;" valign="middle">
	            	<span class="dye">
							META Keywords（栏目关键词）<br/>
							关键字中间用半角逗号隔开：  
	            	</span>
	            </td>
	           <td colspan="3" align="left">
	           		<textarea rows="5" cols="10" id="keyword" name="keyword" style="margin-left: 0px; margin-right: 0px; width: 380px;"></textarea>
	           </td>
           </tr>
			<tr>
	            <td height="28" align="right" style="padding-right: 5px;" valign="middle">
	            	<span class="dye">
							META description<br/>
	            	</span>
	            </td>
	           <td colspan="3" align="left">
	           		<textarea rows="5" cols="10" id="description" name="description" style="margin-left: 0px; margin-right: 0px; width: 380px;"></textarea>
	           </td>
           </tr>
            <tr style="padding-top: 10px;">
	            <td height="28" align="right" style="padding-right: 5px;" valign="middle">
	            	<span class="dye">
							简述：  
	            	</span>
	            </td>
	           <td colspan="3" align="left">
	           		<textarea rows="5" cols="10" id="remark" name="remark" style="margin-left: 0px; margin-right: 0px; width: 380px;"></textarea>
	           </td>
           </tr>
           <tr id="AttachHtml" style="display: none">
           		<td></td>
	            <td colspan="3" align="left">
	            	<input type="text" name="keys" style="width:80px;"/>-<input type="text" name="values"  style="width:265px;"/>&nbsp;<a onclick="javascript:del(this)">移除</a>
	            </td>
           </tr>
           <tr>
           <td valign="middle" align="right"><font color="#ff0000">*</font><span class="dye">内容:</span></td>
           <td class="xheIframeArea">
        	 <div id="ckeditor" style="height:100%"></div>
        	  <textarea id="editor" cols="" rows="" style="display: none"></textarea>
        	 <div style="padding-top: 10px;"></div>
           </td>
           </tr>
            <tr >
            <td height="28" align="right" style="padding-right: 5px;"><span class="dye">信息参数：</span></td>
           <td colspan="3" align="left">
            <input type="hidden" id="infoParam" name="infoParam"/>
            <input type="checkbox" name="checkbox" value="置顶"  ><span class="dye">置顶</span>
            <input type="checkbox" name="checkbox" value="热门" ><span class="dye">热门</span>
            <input type="checkbox" name="checkbox" value="推荐" ><span class="dye">推荐</span>
            </td>
           </tr>
           <tr>
				<td width="30%" height="40" align="right" style="padding-right: 5px;" nowrap="nowrap"><span class="dye" >
					发布时间：</span>
				</td>
				<td> 
					<input name="startTime" id="startTime" type="hidden"/> 
					<input name="sendTime" value="${sendTime}" style="width:180px;" type="text" id="sendTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" class="Wdate" />
				</td>
			</tr>
			 <tr>
				<td width="30%" height="40" align="right" style="padding-right: 5px;" nowrap="nowrap"><span class="dye" >
					活动过期时间：</span>
				</td>
				<td> 
					<input name=expirationDate value="${expirationDate}" style="width:180px;" type="text" id="expirationDate" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" class="Wdate" />
				</td>
			</tr>
            <tr >
            <td height="28" align="right" style="padding-right: 5px;"><span class="dye">模板路径：</span></td>
            <td colspan="3" align="left">
            	 <span id="templateHtml"></span>
            </td>
           </tr>
           
           <tr >
	            <td height="28" align="right" style="padding-right: 5px;"><span class="dye">附件：</span></td>
	             <td nowrap="nowrap" style="width:100%;">
		 					<a href="javascript:void(0);"  id="file_upload" class="z-btn z-btn-flat"><img class="icon003a16" src="<%=basePath%>/s9/res/img/icon000.png"><b>
			 				 选择文件
							<i></i></b></a>
					 		<div id="uploader_queue" style="float: left;padding-left:0px">
       						 </div>
			 	 </td>
           </tr>
           <tr height="50">
            <td height="28" align="right" style="padding-right: 5px;"></td>
           <td colspan="3">
            	<div id="fileAttachementDiv"></div>
           </td>
          
           </tr>
       </tbody>
       </table>
       </div>
       </form>
  
  </body>
</html>
