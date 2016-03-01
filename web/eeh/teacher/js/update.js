/*
 * 新增联系人信息1
 */
function forUpdate() {
	if(validData()){
		$("#form1").attr('onsubmit', '');
		var url=$('#form1').attr('action');
		var data=$('#form1').serialize();
		ajax(url,data);
	}
}
/*
 * 验证表单数据
 */
function validData() {
	var name = $("#name").val();
	if (name.replace(/(^\s*)|(\s*$)/, "").length == 0) {
		$.ligerDialog.warn("教师名称不能为空！");
		return false;
	}
	var subjectId=$("#subjectId").val();
	if(""==subjectId||null==subjectId){
		$.ligerDialog.warn("科目不能为空！");
		return;
	}
	var gradeId=$("#gradeId").val();
	if(""==gradeId||null==gradeId){
		$.ligerDialog.warn("所属年级不能为空！");
		return;
	}
	var classId=$("#classId").val();
	if(""==classId||null==classId){
		$.ligerDialog.warn("授课班级不能为空！");
		return;
	}
	return true;
}
function ajax(url,data){
	$.ajax( {
		type :"post",
		url :url,
		data :data,
		async : false,
		dataType : "json",
		beforeSend : function(XMLHttpRequest) {
		},
		timeout:20000,
		success : function(data) {
			if (data["success"]) {
				parent.reload("操作成功！");
			} else {
				parent.reload("操作失败！");
			}

		},
		error : function() {
			$.ligerDialog.error("操作失败！");
		}
	});
}
