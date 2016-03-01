$(function(){ 
	var win=null;
	init();
	//初始化提示信息
    function init(){
    	var info=$("#backInfo").val();
    	var articleId=$("#articleId").val();
    	if(articleId!= ''){
		 	clickRow(articleId);
    	}
    }
    //新增
	$("#add").bind("click", function() {
		var url = "/s9/article/add.jsp";
		//opeanfullwin(url);
		 var w=screen.availWidth;
		 var h=screen.availHeight;
		 opeanfullwin(url);
		  //window.opener="/c/article/forInit.shtml"; 
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
		var url="../article/delArticle";
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
		 window.location.href="/article/forInit.shtml";
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
    	var url="../article/updArticleInit.shtml?articleId="+articleId;
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