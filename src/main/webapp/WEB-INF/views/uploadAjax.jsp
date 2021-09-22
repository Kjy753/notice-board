<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> Upload with Ajax</h1>

<style>
.uploadResult {
	
	width : 100%;
	background-color : gray;
	
}

.uploadResult ul{
	display : flax;
	flex-flow : row;
	justify-content : center;
	align-items : center;
}

.uploadResult ul li{
	list-style : none;
	padding : 10px;
}

.uploadResult ul li img{
	width :20px;
}
</style>
<div class='uploadDiv'>
	<input type='file' name='uploadFile' multiple>
</div>
	<div class='uploadResult'>
		<ul>
		</ul>
	</div>

<button id='uploadBtn'>Upload</button>

<!-- jQuery CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
     integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" 
     crossorigin="anonymous"></script>
     
<script>
$(document).ready(function(){
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|zlz)$"); // 정규식을 통한 exe,sh,zip 검사
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
	var cloneObj = $(".uploadDiv").clone();  // uploadDiv 객체를 복사

	$("#uploadBtn").on("click", function(e){
	
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		console.log(files);
			
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
			contentType: false,
			data: formData,
				type: 'POST',
				dataType : 'json',
				success: function(result){
					console.log(result);
					
					showUploadedFile(result);
					
					$(".uploadDiv").html(cloneObj.html()); // 복사한 div를 다시 붙여넣어준다.
				}
		}); //$.ajax
		
	});
	
	var uploadResult = $(".uploadResult ul");
	
	 function showUploadedFile(uploadResultArr){
		
		var str = "";
		
		$(uploadResultArr).each(
			function(i,obj){
			if(!obj.image){
				
				var fileCallPath = encodeURIComponent( obj.uploadPath+"/"+obj.uuid + "_" + obj.fileName);
				
				str += "<li><a href='/download?fileName="+fileCallPath+"'>"						
						+"<img src='/resources/img/attach.png'>"+obj.fileName+"</a></li>"
						
			}else {
				//str += "<li>" + obj.fileName + "</li>";
				var fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				
				str += "<li><img src='/display?fileName="+fileCallPath+"' <li>";
				
			}
				
		}); 
		    
		uploadResult.append(str);
	}
});
</script>
</body>
</html>