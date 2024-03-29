$(function() {
    $("#importExcel").uploadify({
       'auto' : true,
       'method' : "post",
       'formData' : {'folder' : 'file'},
          'height' : 25,
          'swf' : '../web/upload/uploadify.swf',
          'uploader' : '../c/uploadify',
          'width' : 90,
          'buttonText' : '导入培优学生表',
          'uploadLimit' : 5,
          'atuo':false,
          'multi':true,
          // 两个配套使用
           'fileTypeExts': "*.xlsx;",             // 扩展名
           'fileTypeDesc': "请选择 excel文件",     // 文件说明
          //'successTimeout' : 5,
          'requeueErrors' : false,
          'removeTimeout' : 10,
          'removeCompleted' : false,
          'queueSizeLimit' :10,
          'queueID'  : 'uploader_queue',
          'progressData' : 'speed',
          'onInit' : function (){
          },
       // 单个文件上传成功时的处理函数
       'onUploadSuccess' : function(file, data, response){

           //获取上传路径
           var filepath=data;
           //读取excel文件到表格中
           var url="../excelOperate/importExcelForPewStudent.shtml";
           var data={"path":filepath};
           ajaxImport(url,data);

    },
          'onQueueComplete' : function(queueData) {
              //alert("上传完成");
    		// $('#uploader_msg').html(queueData.uploadsSuccessful + ' files were successfully uploaded.');
    }
      });
    $("#importExcel").removeClass().addClass("z-btn z-btn-flat");
	var format = function(time, format){
    var t = new Date(time);
    var tf = function(i){return (i < 10 ? '0' : '') + i};
    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a){
        switch(a){
            case 'yyyy':
                return tf(t.getFullYear());
                break;
            case 'MM':
                return tf(t.getMonth() + 1);
                break;
            case 'mm':
                return tf(t.getMinutes());
                break;
            case 'dd':
                return tf(t.getDate());
                break;
            case 'HH':
                return tf(t.getHours());
                break;
            case 'ss':
                return tf(t.getSeconds());
                break;
        }
    })
}
})
function ajaxImport(url,data){
    $.ajax({
        url:url,
        type:"post",
        dataType:"json",
        data:data,
        async:false,
        beforeSend:function(XMLHttpRequest){
        },
        success:function(msg){
            $.ligerDialog.success("保存成功");
            var url='../PewStudent/findAllList.shtml';
            findAllList(url);
        },error:function(){
            $.ligerDialog.error("服务器异常");
            return;
        }});
}