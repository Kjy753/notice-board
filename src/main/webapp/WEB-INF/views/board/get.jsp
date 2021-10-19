<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Read</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Read
                        </div>
                        <!-- /.panel-headifng -->
                        <div class="panel-body">
                        	   <div class="form-group">
	                           		<label>BNO</label>
	                           		<input class="form-control" name="title" readonly="readonly" value= '<c:out value="${board.bno}"/>'>
	                           </div>
                        
	                           <div class="form-group">
	                           		<label>Title</label>
	                           		<input class="form-control" name="title" readonly="readonly" value= '<c:out value="${board.title}"/>'>
	                           </div>
	                           
	                           <div class="form-group">
	                           		<label>Content</label>
	                           		<textarea rows="5" cols="50" name="content" class="form-control"> '<c:out value="${board.content}"/>'</textarea>
                               </div>
	                           
	                           <div class="form-group">
	                           		<label>Writer</label>
	                           		<input class="form-control" name="writer" value= '<c:out value="${board.writer }"/>'>
	                           </div>
                               <form id='actionForm' action="/board/list" method='get'>
	                            	<input type='hidden' name='pageNum' value = '${cri.pageNum }'>
	                            	<input type='hidden' name='amount' value = '${cri.amount }'>
	                            	<input type='hidden' name='bno' value = '${board.bno }'>
	                            	<input type='hidden' name='type' value = '${cri.type }'>
	                            	<input type='hidden' name='keyword' value = '${cri.keyword }'>
	                           </form>
	                           <button type="button" class="btn btn-default listBtn"><a href='/board/list'>List</a></button>
	                           <button type="button" class="btn btn-default modifyBtn"><a href='/board/modify?bno= <c:out value="${board.bno}"/> '>Modify</a></button>
                        </div> 
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
   
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
                     <div class = "panel panel-default">
                    	<!-- <div class = "panel-heading">
                    		<i class = "fa fa-comments fa-fw"></i> Reply
                    	</div> -->
                    	<div class="panel-heading">
                    	<i class="fa fa-comments fa-fw"></i> Reply
                    		<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
                    	</div>
                    	<!-- /.panel-heading -->
                    	<div class="panel-body">
                    		<ul class="chat">
                    		<!-- 댓글 시작점 -->
                    		<li class ="left clearfix" data-rno ='12'>
                    		<div>
                    		<div class="header">
                    			<strong class="primary-font">user00</strong>
                    			<small class="pull-right text-muted">2021-06-23 10:34</small>
                    		</div>
                    			<p>테스트</p>
                    		</div>
                    		</li>                    		
                    		</ul>
                    		
                    	</div>
                    	<!-- /.panel /.chat -->
                    	<div class="panel-footer">
                    	<h3>바닥부분	</h3>
                    	</div>
                    </div> 
                   
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
<!-- Modal -->
	 <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	  aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-header">
                	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
                </div>
                <div class="modal-body">
                	<div class="form-group">
                	<label>Reply</label>
                	<input class= "form-control" name='reply' value = 'New Reply!!!'>
                	</div>
                	
                	<div class="form-group">
                	<label>Replyer</label>
                	<input class= "form-control" name='replyer' value = 'replyer'>
                	</div>
                	<div class="form-group">
                	<label>Reply Date</label>
                	<input class= "form-control" name='replyDate' value = ''>
                	</div>
                	
                </div>
                    <div class="modal-footer">
                    	<button id='modalModBtn' type="button" class="btn btn-warining">Modify</button>
                    	<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
                    	<button id='modalCloseBtn' type="button" class="btn btn-default" >Close</button>
                    	<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
                	</div>
            </div>
            <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
            </div>
            <!-- /.modal  -->
                   
<!-- js 모듈 불러오기 -->
<script type = "text/javascript" src="/resources/js/reply.js"></script>
<script type = "text/javascript">
/* reply.js 관련 스크립트 */
	$(document).ready(function () {
		
		var bnoValue = '<c:out value="${board.bno}"/>'
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page){
			
			replyService.getList({bno:bnoValue, page: page || 1}, function(replyCnt, list) {
				//console.log(========댓글 목록 불러오기========);
				console.log("replyCnt:" + replyCnt);
				console.log("list: " + list);
				console.log(list);
				
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				var str = "";
				
				if(list == null || list.length == 0){
					//replyUL.html("");
					return;
				}
				
				for( var i = 0, len = list.length || 0; i < len; i++){
					str += "<li class ='left clearfix' data-rno='" + list[i].rno+"'>";
					str += "  <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
					str += "   <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
					str += "   <p>"+list[i].reply+"</p></div></li>";
				}
				replyUL.html(str);
				
				showReplyPage(replyCnt);
			});
		}
		
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
	
		$("#addReplyBtn").on("click", function(e){
			console.log("=========");
			console.log("addReplyBtn  TEST");
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
		});
		
		modalRegisterBtn.on("click", function(e){

			var reply = {
					reply: modalInputReply.val(),
					replyer: modalInputReplyer.val(),
					bno:bnoValue
			};
			
			replyService.add(reply, function(result){
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
				
				// 댓글 추가시 댓글 목록 갱신을 위해 추가
				//showList(1);
				showList(-1); // 새댓글 추가시 목록 -1을 넣어서 전체 댓글의 숫자를 먼저 파악
			});
		});
		
		// 댓글 조회중 클릭 이벤트 처리 
		$(".chat").on("click", "li", function(e){
			
			var rno = $(this).data("rno");
			
			//console.log(rno);
			
			replyService.get(rno, function(reply){
				
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
		});
		
		modalModBtn.on("click", function(e){
			
			var reply = {rno: modal.data("rno"), reply: modalInputReply.val()};
			
			replyService.update(reply, function(result){
				
				alert(result);
				
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		modalRemoveBtn.on("click", function(e){
			
			var rno = modal.data("rno");
			
			replyService.remove(rno, function(result){
				
				alert(result);
				
				modal.modal("hide");
				showList(pageNum);
				
			
			});
		});
		// 댓글 페이지번호를 출력 하기 위한 로직
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt){
			console.log("페이지번호출력");
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			
			var startNum = endNum -9;
			
			var prev = startNum != 1; 
			var next = false; 
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if(endNum * 10 < replyCnt){
				next = true;
			}
			
			var str = "<ul class='pagination pull-right'>";
			
			if(prev){
				str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
				
			}
			
			for(var i = startNum; i<=endNum; i++){
				var active = pageNum ==i? "active":"";
				
				str+="<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			
			if(next){
				str+="<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
			}
			
			str +="</ul></div>"
			console.log(str);
			replyPageFooter.html(str);
		}
		
		replyPageFooter.on("click","li a", function(e){
			e.preventDefault();
			console.log("page click");
			
			var targetPageNum = $(this).attr("href");
			
			console.log("targetPageNum: " + targetPageNum);
			
			pageNum = targetPageNum;
			
			showList(pageNum);
		});
});
	
	//테스트
	/*
	replyService.add(
			{reply:"JS Test", replyer:"tester", bno:bnoValue}
			,
			function(result){
				alert("RESULT: "+ result);
			}
		);
	
	replyService.getList(
			{bno:bnoValue, page:1}, function(list){
				for(var i = 0, len 	= list.length||0; i<len; i++){
				console.log(list[i]);
		}
	});
	
	replyService.remove(6, function(count){
		console.log(count);
		
		if(count === "sucess"){
			alert("REMOVED");
		}
	}, function(err){
		alert('ERROR...');
	});
	
	replyService.update({
		rno:22,
		bno:bnoValue,
		reply : "Modify Reply..."
	}, function(result){
		alert("수정 완료....");
	});
	 
	
	replyService.get(25, function(data){
		console.log("=========");
		console.log(data);
		console.log("=========");
	}); 
	*/
	
	
</script>

<script>

	var actionFrom = $("#actionForm");

	$(".listBtn").click(function(e){	
		e.preventDefault();
		actionFrom.find("input[name='bno']").remove();
		actionForm.submit();
	});

	$(".modifyBtn").click(function(e){	
		e.preventDefault();
		actionFrom.attr("action","/board/modify");
		actionForm.submit();
	});
</script> 

<script>

$(document).ready(function(){
	
	(function(){
		
		var bno = '<c:out value="${board.bno}"/>';
		
	  /*$.getJSON("/board/getAttachList",{bno:bno}, function(arr){
			
			console.log(arr);
		}); //end getjson  */
		$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
		
			console.log(arr);
			var str = "";
			
			$(arr).each(function(i,attach){
				
				 //image type
				if(attach.fileType){
					var fileCallPath = encodeURIComponent( attach.uploadPath + "/s_"+attach.uuid +"_"+attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str + "</li>";
				}else{
					
					 str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
					str += "<span> "+ attach.fileName+"</span><br/>";
					str += "<img src='/resources/img/attach.png'>";
					str += "</div>";
					str +"</li>";
					
					
				} 
				
				 
				
			});
			
			$(".uploadResult ul").html(str);
		});
		
	})();//end function
	
	$(".uploadResult").on("click","li", function(e){
		console.log("view image");
		
		var liObj = $(this);
		var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_"+liObj.data("filename"));
		
		
		if(liObj.data("type")){
			showImage(path.replace(new RegExp(/\\/g),"/"));
		}else{
			//download
			self.location = "/download?fileName="+path
		}
		
	});
	
	function showImage(fileCallPath){
		alert(fileCallPath);
		$(".bigPictureWrapper").css("display","flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath+"' >")
		.animate({width:'100%', height: '100%'}, 1000);
	}
	
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		setTimeout(function(){
			$('.bigPictureWrapper').hide();
		},1000);
	});	
	
	
});//end document.ready


</script>
<%@include file="../includes/footer.jsp" %>