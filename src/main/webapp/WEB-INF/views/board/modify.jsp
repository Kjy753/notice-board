<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Modify/Delete</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Modify/Delete
                        </div>
                        <!-- /.panel-headifng -->
                        <div class="panel-body">
                           <form>
                           	   <input type='hidden' name='pageNum' value='${cri.pageNum }'>
                           	   <input type='hidden' name='amount' value='${cri.amount }'>
                           	   <input type='hidden' name='type' value = '${cri.type }'>
	                           <input type='hidden' name='keyword' value = '${cri.keyword }'>
                        	   <div class="form-group">
	                           		<label>BNO</label>
	                           		<input class="form-control" name="bno" readonly="readonly" value= '<c:out value="${board.bno}"/>'>
	                           </div>
                        
	                           <div class="form-group">
	                           		<label>Title</label>
	                           		<input class="form-control" name="title"  value= '<c:out value="${board.title}"/>'>
	                           </div>
	                           
	                           <div class="form-group">
	                           		<label>Content</label>
	                           		<textarea rows="5" cols="50" name="content" class="form-control"> '<c:out value="${board.title}"/>'</textarea>
                               </div>
	                           
	                           <div class="form-group">
	                           		<label>Writer</label>
	                           		<input class="form-control" name="writer" value= '<c:out value="${board.title}"/>'>
	                           </div>
                           
	                           <button class="btn btn-default" data-oper='modify'>Modify</button>
	                           <button class="btn btn-danger" data-oper='remove'>Remove</button>
	                           <button class="btn btn-info" data-oper='list'>List</button> 
                           </form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>

<style>

.uploadResult {
	widity: 100%;
	background-color: gray;
}
.puloadResult ul{
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}
.uploadResult ul li{
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}
.uploadResult ul li img{
	width:100px;
}
.uploadResult ul li span {
	color:white;
}
.bigPictureWrapper{
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background:rgba(255,255,255,0.5);
}
.bigPicture{
	position: relative;
	display: flex;
	justify-content: center;
	align-items: cetner;
}
.bigPicture img{
	width: 600px;
}

</style>      

<div class="row">
 <div class="col-lg-12">
  <div class="panel panel-default">
   
   <div class="panel-heading">Files</div>
   <div class="panel-body">
     <div class="form-group uploadDiv">
     	<input type="file" name='uploadFile' multiple="multiple">
     </div>
    <div class='uploadResult'>
     <ul>
     </ul>
    </div>
   </div>
   <!-- end panel-body -->
  </div>
  <!-- end panel-default -->
 </div>
 <!-- end col-lg-12 -->
</div>
<!-- /.row -->          
<script>
$(document).ready(function() {
	
	var formobj = $("form");
	
	$('.btn').click(function(e){
		// 기본 동작을 먼저 막아준다.
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'list'){
			formobj.attr("action", "/board/list").attr("method","get");
			
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
			
			formobj.empty();
			formobj.append(pageNumTag);
			formobj.append(amountTag);
			formobj.append(keywordTag);
			formobj.append(typeTag);
			
			formobj.submit();
			
		}else if(operation === 'remove'){
			formobj.attr("action","/board/remove")
				.attr("method", "post");
			formobj.submit();
		}else if(operation === 'modify'){
			formobj.attr("action","/board/modify")
			.attr("method", "post");
		formobj.submit();
	}
	});
		
	
	
})
</script>

<script>
$(document).ready(function() {
	(function(){
	
		var bno ='<c:out value="${board.bno}"/>';
		
		$.getJSON("/board/getAttachList",{bno: bno}, function(arr){
			
			console.log(arr);
			
			var str = "";
			
			$(arr).each(function(i, attach){
				//image type
				if(attach.fileType){
					var fileCallPath = encodeURIComponent( attach.uploadPath + "/s_"+attach.uuid +"_"+attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<span> "+attach.fileName+" </span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'"
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str + "</li>";
				}else{
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
					str += "<span> "+ attach.fileName+"</span><br/>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'"
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'>";
					str += "</div>";
					str +"</li>";
				} 
			});
			$(".uploadResult ul").html(str);
		}) //end getJSON
	})();//end function
});
</script>
<%@include file="../includes/footer.jsp" %>