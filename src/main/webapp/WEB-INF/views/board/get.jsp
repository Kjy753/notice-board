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
                </div>
                <!-- /.col-lg-12 -->
            </div>
<!-- js 모듈 불러오기 -->
<script type = "text/javascript" src="/resources/js/reply.js"></script>
<script type = "text/javascript">
/* reply.js 관련 스크립트 */
	
	console.log("=========");
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>'
	
	//테스트
	
	replyService.add(
			{reply:"JS Test", replyer:"tester", bno:bnoValue}
			,
			function(result){
				alert("RESULT: "+ result);
			}
		);
	
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