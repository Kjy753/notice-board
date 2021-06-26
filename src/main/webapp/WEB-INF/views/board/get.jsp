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
                     <div class = "panel panel-default">
                    	<div class = "panel-heading">
                    		<i class = "fa fa-comments fa-fw"></i> Reply
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
                    </div> 
                   
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
<!-- js 모듈 불러오기 -->
<script type = "text/javascript" src="/resources/js/reply.js"></script>
<script type = "text/javascript">
/* reply.js 관련 스크립트 */
	$(document).ready(function () {
		console.log("=========");
		console.log("JS TEST");
		
		var bnoValue = '<c:out value="${board.bno}"/>'
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page){
			
			replyService.getList({bno:bnoValue, page: page || 1}, function(list) {
				
				var str = "";
				if(list == null || list.length == 0){
					replyUL.html("");
					return;
				}
				
				for( var i = 0, len = list.length || 0; i < len; i++){
					str += "<li class ='left clearfix' data-rno='" + list[i].rno+"'>";
					str += "  <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
					str += "   <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
					str += "   <p>"+list[i].reply+"</p></div></li>";
				}
				replyUL.html(str);
			});
		}
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
				for(var i = 0, len = list.length||0; i<len; i++){
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
<%@include file="../includes/footer.jsp" %>