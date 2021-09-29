<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Register</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <style>
.uploadResult {
	
	width : 100%;
	background-color : gray;
	
}

.uploadResult ul{
	display : flex;
	flex-flow : row;
	justify-content : center;
	align-items : center;
}

.uploadResult ul li{
	list-style : none;
	padding : 10px;
	aligin-content: center;
	text-align: center;
}

.uploadResult ul li img{
	width : 20px;
}
.uploadResult ul li span {
	color: white;
}


.bigPictureWrapper {
	position: absolute;
	display: none; 
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	heighit: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255,255,255,0.5);
}
.bigPicture{
	position: relative;
	display: flex;
	justify-content: center;
	align-tiems: center;
}
.bigPicture img{
	width: 600px;
}
</style>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Register
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                           <form action="/board/register" method="post">
	                           <div class="form-group">
	                           		<label>Title</label>
	                           		<input class="form-control" name="title">
	                           </div>
	                           
	                           <div class="form-group">
	                           		<label>Content</label>
	                           		<textarea rows="5" cols="50" name="content" class="form-control"></textarea>
                               </div>
	                           
	                           <div class="form-group">
	                           		<label>Writer</label>
	                           		<input class="form-control" name="writer">
	                           </div>
                           
	                           <button type="submit" class="btn btn-default">Submit Button</button>
	                           <button type="reset" class="btn btn-default">Reset Button</button> 
                           </form> 
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
<div class="row">
	<div class = "col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">File Attach
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="form-group upoadDiv">
					<input type="file" name='uploadFile' multiple>
				</div>
				
				<div class='uploadResult'>
					<ul>
					
					</ul>
				</div>
			</div>
			<!-- end panel-body -->
		</div>
	</div>
</div>

<script>
//Submit Button 클릭시 기본 동작을 막는 작업 
$(document).ready(function (e){
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		console.log("submit clicked");
	});
	// 파일 업로드 
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); // 정규식을 통한 exe,sh,zip 검사
	var maxSize = 5242880; // 5MB
	
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	$("input[type='file']").change(function(e){

		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
			
		// formdata 객체를 통해 파일을 전송 하는 방식 
		for(var i = 0; i < files.length; i++){
				
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,data:
				formData,type: 'POST',
				dataType : 'json',
				success: function(result){
					console.log(result);
					
					showUploadResult(result); // 업로드 결과 처리 함수 
					
				}
		}); //$.ajax
	});
	/* end.input[type='file'] */
	
	 function showUploadResult(uploadResultArr){
		if(!uploadResultArr || uploadResultArr.length == 0){ retunr;}
		
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		
		$(uploadResultArr).each(function(i,obj){
				/* if(!obj.image){
					
					var fileCallPath = encodeURIComponent( obj.uploadPath+"/"+obj.uuid + "_" + obj.fileName);
					
					str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+"<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"+"<span data-file=\'"+fileCallPath+"\' data-type='file'> X </span>"+"<div></li>" 
				
							
				}else {
					//str += "<li>" + obj.fileName + "</li>";
					var fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					
					// 원본이미지 경로
					var originPath = obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName; 
					originPath = originPath.replace(new RegExp(/\\/g),"/");
					
					str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+"<img src='display?fileName="+fileCallPath+"'></a>"+"<span data-file=\'"+fileCallPath+"\' data-type='image'> X</span>" + "<li>";
					
					} */
					
					if(obj.image){
					
						var fileCallPath = encodeURIComponent(obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
					
						str += "<li><div>";
						str += "<span>" + obj.fileName+"</span>";
						str += "<button type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?fileName="+fileCallPath+"'>";
						str += "</div>";
						str + "</li>";
					}else{
						/* imag 아닌 다른 파일 일경우 */
						var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
						var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
						
						str += "<li><div>";
						str += "<span> "+ obj.filName+"</span>";
						str += "<button type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/img/attach.png'></a>";
						str += "</div>";
						str + "</li>";
						
						
					}
					
			}); 
			    
		uploadUL.append(str);
		}
	

	
});
/* end.ready */
</script>
        
<%@include file="../includes/footer.jsp" %>