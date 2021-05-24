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
	                           		<textarea rows="5" cols="50" name="content" class="form-control"> '<c:out value="${board.title}"/>'</textarea>
                               </div>
	                           
	                           <div class="form-group">
	                           		<label>Writer</label>
	                           		<input class="form-control" name="writer" value= '<c:out value="${board.title}"/>'>
	                           </div>
                           
	                           <button class="btn btn-default" data-oper='modify'>Modify</button>
	                           <button class="btn btn-danger" data-oper='remove'>Remove</button>
	                           <button class="btn btn-info" data-oper='list'>List</button> 
                           
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
<script>
$(document).ready(function() {
	
	$('.btn').click(function(e){
		// 기본 동작을 먼저 막아준다.
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
	});
		
	
	
})
</script>
<%@include file="../includes/footer.jsp" %>