<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@include file="/s9/common/common.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html   xmlns="http://www.w3.org/1999/xhtml" >
<head>
<script type="text/javascript" src="<%=basePath%>/s9/article/js/sort.js"></script>
<script>
var manager;
  //改变图片宽度
    function changeImage(obj){
    	$(obj).attr('width','120px');
    }
  function changeSmallImage(obj){
	  $(obj).attr('width','64px');
  }
 function reload(){
	 manager.clear();
	 initTree();
	 if(m){
		  m.close();
	 }
 }
 function reflush(){
	  manager.clear();
	  initTree();
 }
 function initTree(){
		 var url='../codeManage/getCodeValueAjax.shtml';
		 manager=$("#tree1").ligerTree({
		 url: url+"?codeId=102", 
		 checkbox:false,
		 ajaxType: 'post' ,
		 onClick: onClick,
		 onAfterAppend: function () { 
		 	   var articleType=manager.getData()[0].id;
		 	   $("#articleType").val(articleType);
    		   var url="../article/initListPage.shtml?pcode="+articleType+"&articleType="+articleType;
    		   $("#quickEditorWindow").attr("src",url);
		 }
		 });
	 }
	  function onClick(note)
        {
            var articleType=note.data.id;
            var isParentNode=note.data.children==null?false:true;
	        var rootPath=$("#rootPath").val();
            if(isParentNode){//是父节点
            	var pcode=note.data.codeValue;
            	//查询此pcode下面的子节点codeValue
            	//把这些codeValue当作articleType去文章表里面查询,多个articleType以逗号分隔
            	var url="../article/initListPage.shtml?pcode="+pcode+"&articleType="+pcode;
            	$("#pcode").val(pcode);
            	$("#codeSortId").val(note.data.codeSortId);
            	 $("#codeId").val(note.data.codeId);
	    		$("#quickEditorWindow").attr("src",url);
            
            }else{
            	$("#pcode").val(note.data.codeValue);
	            $("#codeSortId").val(note.data.codeSortId);
	            $("#codeId").val(note.data.codeId);
	    		var url="../article/initListPage.shtml?articleType="+articleType;
	    		$("#quickEditorWindow").attr("src",url);
	            }
           
            
        }

$(function(){ 
	var win=null;
	init();
	//初始化提示信息
    function init(){
    	var info=$("#backInfo").val();
    	var articleId=$("#articleId").val();
    	//if(articleId!= ''){
		 //	clickRow(articleId);
    	//}
    }
	 initTree();

    //新增
	$("#add").bind("click", function() {
		var rootPath=$("#rootPath").val();
		var url = "/s9/article/add.jsp?rootPath="+rootPath;
		 var w=screen.availWidth;
		 var h=screen.availHeight;
		 opeanfullwin(url);
	});
	//查询
	$("#search").bind('click',function(){
		var articleTitle=$("#articleTitle").val();
		var url="../article/forInit.shtml?articleTitle="+articleTitle;
		window.location.href=url;
	})
	//删除
	$("#delete").bind("click",function(){
		var obj=$("input:checkbox:checked");
		if(obj.length==0){
			$.ligerDialog.error("请选中要删除的内容");
			return;
		}
		var id='';
		for(var i=0;i<obj.length;i++){
			if(i<obj.length-1){
				id+=$(obj[i]).attr('id')+",";
			}else{
				id+=$(obj[i]).attr('id');
			}
			
		}
		var url="../article/delArticle.shtml";
	    $.ligerDialog.confirm("确定要删除吗?", function (yes)
		           {
		               if(yes){
		            	   $.ajax({
							url:url,
							data:{"ids":id},
							dataType:'json',
							success:function(msg){
								if(msg.message=='1');{
									$.ligerDialog.success("删除成功",function(){
										document.location.href="/article/forInit.shtml";
									})
								}
								
							},error:function(){
								$.ligerDialog.error("服务器异常");
								return;
							}
						});
		            	   }
		            });
	});
	//弹出全屏窗口
	function opeanfullwin(url)
	{
			win = window.open(url,"_blank","resizable=yes;status=yes;toolbar=no;location=no;menubar=no;directories=no;scrollbars=no;"); 
			window.opener=null; 
			window.open('','_self'); 
			window.close(); 
			win.moveTo(0,0); 
			win.resizeTo(screen.availWidth,screen.availHeight); 
	}
	//关闭弹窗
	function close(){
		 ///window.opener.opener="/c/article/forInit.shtml";
		 window.close();//关闭当前窗窗口
		 window.location.href="../article/forInit.shtml";
	}
    //点击行事件，查询行事件
    $(".datarow").bind("click",function(){
    	var articleId=$(this).attr('id');
    	var $selectTr=$(this);
    	//var obj=$("input:checkbox[value='"+articleId+"']");
    	var obj=$("input:checkbox");
    	$(obj).each(function(){
    		var id=$(this).attr('id');
			if(id==articleId){
				this.checked=true;
				$(this).parents("td:first").parents("td:first").attr('bgcolor','#DAFAA2');
			}else if(id!='selectAll'){
				this.checked=false;
				$(this).parents("td:first").parents("td:first").attr('bgcolor','');
			}
		});
    	var obj=$("input:checkbox:checked");
    	clickRow(articleId);
    });
    //点击行事件
    function clickRow(articleId){
    	//var rootPath=$("#rootPath").val();
    	var url="../article/initListPage.shtml?articleId="+articleId;
    	$("#quickEditorWindow").attr("src",url);
    }
  
 //全选
    $("#selectAll").live('click',function(){
    	var obj=$("input:checkbox");
    	var all=$("#selectAll").attr('checked');
    	$(obj).each(function(){
    		if($(this).attr('id')!='selectAll'){
    			if(all=='checked'){
    				this.checked=true;
    				$(this).parents("td:first").parents("td:first").attr('bgcolor','#DAFAA2');
    			}else{
    				this.checked=false;
    				$(this).parents("td:first").parents("td:first").attr('bgcolor','');
    			}
    			
	    	}
    	})
    	});
    		
    
});  
</script>
</head>
<body class="z-body-list">
<input type="hidden" id="backInfo" name="backinfo" value="${backInfo}"/>
<input type="hidden" id="articleId" name="articleId" value="${articleId}"/>
<input type="hidden" id="rootPath" name="rootPath" value="${rootPath}"/>
<input type="hidden" id="codeSortId" name="codeSortId"/>
<input type="hidden" id="codeId" name="codeId"/>
<input type="hidden" id="codeType" name="codeType"/>
<input type="hidden" id="pcode" name="pcode"/>
<input type="hidden" id="firstId" name="firstId"/>
<input type="hidden" id="articleType" name="articleType"/>
<table id="js_layoutTable" width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="js_layoutTable">
  <tbody>
  <tr valign="top">
    <td  height="100%" class="centerColumnWrap" style="height: 861px; width: 200px; "><table id="js_layoutTable" width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="js_layoutTable">
        <tbody>
        <tr>
          <td height="33"><div class="z-toolbar" id="ToolBar1"><div class="z-toolbar-ct"><div class="z-toolbar-overflow"><div class="z-toolbar-nowrap">
			  <a href="javascript:void(0)"  onclick="addCodeInfo();" id="addSort" class="z-btn z-btn-flat"   ><img class="icon003a2" src="<%=basePath%>/s9/res/img/icon000.png"><b>新建 <i></i></b></a>
              <a href="javascript:void();" onclick="editCodeInfo();"  id="updateSort" class="z-btn z-btn-flat"  ><img class="icon003a4" src="<%=basePath%>/s9/res/img/icon000.png"><b>编辑<i></i></b></a>
              <a href="javascript:void();"  onclick="delCodeInfo();" id="deleteSort" class="z-btn z-btn-flat"  ><img class="icon003a3" src="<%=basePath%>/s9/res/img/icon000.png"><b>删除<i></i></b></a>
              </div></div></div></div></td>
        </tr>
        
        <tr>
          <td  style="padding-top: 0px;  padding-bottom: 0px; padding-left: 2px; ">
           <div class="dataList-wrap" id="dl1_wrap">
      			 <ul id="tree1"></ul>
           </div>
           </td>
        </tr>
       
      </tbody></table></td>
    <td style="height: 861px; zoom: 1; "><div id="splitter1" class="z-splitter-v shadow-v"></div>
      <iframe id="quickEditorWindow" frameborder="0" width="100%" height="100%" src=""  scrolling="no" ></iframe>
    </td>
  </tr>
</tbody></table>

</body></html>