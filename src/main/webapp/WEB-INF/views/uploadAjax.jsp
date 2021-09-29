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
<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>
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

function showImage(fileCallPath){
	 //alert(fileCallPath);
	 
	 $(".bigPictureWrapper").css("display","flex").show();
	 
	 $(".bigPicture")
	 .html("<img src='/display?fileName="+ encodeURI(fileCallPath)+"'>")
	 .animate({width:'100%', height: '100%'}, 1000);
	 
	 $(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'100%', height: '100%'}, 1000);
		setTimeout(function(){
			$('.bigPictureWrapper').hide();
		},1000);
	 });
}

//첨부파일 삭제인 x 표시에 대한 ㅣ벤트 처리
$(".uploadResult").on("click","span", function(e){
	
	var targetFile = $(this).data("file");
	var type = $(this).data("type");
	console.log(targetFile);
	
	$.ajax({
		url: '/deleteFile',
		data: {fileName: targetFile, type:type},
		dataType:'text',
		type:'POST',
			success:function(result){
				alert(result);
			}
	}); //$.ajax
});

$(document).ready(function(){
	
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
				
				str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+"<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"+"<span data-file=\'"+fileCallPath+"\' data-type='file'> X </span>"+"<div></li>"
						
			}else {
				//str += "<li>" + obj.fileName + "</li>";
				var fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				
				// 원본이미지 경로
				var originPath = obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName; 
				originPath = originPath.replace(new RegExp(/\\/g),"/");
				
				str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+"<img src='display?fileName="+fileCallPath+"'></a>"+"<span data-file=\'"+fileCallPath+"\' data-type='image'> X</span>" + "<li>";
				
				}
				
		}); 
		    
		uploadResult.append(str);
	}
	 
	 
});
</script>
</body>
</html>