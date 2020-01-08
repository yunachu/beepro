<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>NAME</title>

<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/matching/css/msg.css" rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/matching/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<%-- <link href="${pageContext.request.contextPath}/matching/css/bootstrap.css" rel="stylesheet">
 --%>
<!-- Custom fonts for this template -->
<link
	href="${pageContext.request.contextPath}/matching/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Kaushan+Script'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700'
	rel='stylesheet' type='text/css'>

<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/matching/css/agency.css"
	rel="stylesheet">

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<!-- heart button https://codepen.io/kieranfivestars/pen/PwzjgN-->
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700'
	rel='stylesheet' type='text/css'>
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css"
	rel="stylesheet">


<script type="text/javascript">
	function allsel(check){
		var chks = document.getElementsByName("chk");
		for(var i=0; i<chks.length;i++){
			chks[i].checked = check;
		}
	}
	function showMsgFunction(no){
 		var modal = document.getElementById('detailMsg'+no);
 	  	var cancle = document.getElementById("cancle"+no);
 	  	var close = document.getElementById("close"+no);
     	modal.style.display = "block";
    	window.onclick = function(event) {
     	   if (event.target == $('#detailMsg'+no)) {
    	        modal.style.display = "none";
   	     }
    	}
     	cancle.onclick = function() {
        	modal.style.display = "none";
        }	   
     	close.onclick = function() {
        	modal.style.display = "none";
        } 
     	
	}
	function reSendFunction(get_id){
		$('#sendMsgModal').css("display","block");
		$('#inputTo').val(get_id);
		$('#reset').click(function(){
			$('#sendMsgModal').css("display","none");
		});
		$('#close').click(function(){
			$('#sendMsgModal').css("display","none");
		});
	}
	
	function deleteMsgFunction(){
		if($("input[name='chk']:checked").length == 0){
			alert("삭제할 쪽지를 선택해 주세요.");
		}else{
			var delConfirm = confirm('선택한 쪽지를 삭제하시겠습니까?');
			if (delConfirm) {
				var list = [];
				var data;
				$("input[name='chk']:checked").each(function(i){  
					list.push($(this).val());
				});
			
				  $.ajaxSettings.traditional = true; 
				  $.ajax({
			            type : "POST",
			            url : "${pageContext.request.contextPath}/msg?command=deleteSendMsg",
			            data : {
			            	list :list
			            },
			            success : function(res){
			            	if(res>0){
			            		location.reload();
			            	}else{
			            		alert("삭제 실패");
			            	}
			            }
			         }); 
			}
		}
	}
	
</script>

</head>

<body id="page-top">

	<jsp:include page="common/sub_nav.jsp"></jsp:include>

	<!-- Header -->
	<header class="masthead" style="background-color: rgba(75, 97, 207);">
		<div class="container">
			<div class="intro-text"
				style="padding-top: 150px; padding-bottom: 100px;">
				<div class="intro-lead-in">by user</div>
				<div class="intro-heading text-uppercase">message</div>
			</div>
		</div>
	</header>



	<!-- project -->
	<section class="bg-light page-section">
		<div class="container">
			<div class="row">
				<div class="col-2">
					<div class="chk-block"
						style="margin-top: 50px; text-align: center; color:gray"
						onclick="location.href='${pageContext.request.contextPath}/msg?command=getAllMsg&u_id=${u_id }'">
						<h5>받은 쪽지함</h5>
					</div>
					<div class="chk-block"
						style="margin-top: 20px; text-align: center; background-color:#4e73df; color:white"
						onclick="location.href='${pageContext.request.contextPath}/msg?command=sendAllMsg&u_id=${u_id }'">
						<h5>보낸 쪽지함</h5>
					</div>
				</div>

				<!-- 본격적으로 내용이 담기는 div -->
				<div class="col-10">
					<!-- <div class="container-fluid">
						<div class="container">
							<div class="table-title">
								<div class="row">
									<div class="col-sm-4">
										<h5>
											&nbsp;<b>쪽지 목록</b>
										</h5>
									</div>
								</div>
								<hr>
							</div> -->
					<div class="table-wrapper" id="getBox">
						<input class="btn btn-primary"
							style="margin-bottom: 10px;" type="button"
							value="삭제" onclick="deleteMsgFunction();" />
						<form action="">
							<table class="table table-hover" id="boxTable"
								style="text-align: center; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
								<!-- 쪽지목록 추가 부분 -->
								<col width="3">
								<col width="40">
								<col width="200">
								<col width="70">
								<col width="5">
								<thead>
									<tr>
										<th><input type="checkbox" name="all"
											onclick="allsel(this.checked);" /></th>
										<th>받는사람</th>
										<th>내용</th>
										<th>날짜</th>
										<th>상태</th>
									</tr>
								</thead>
								<tbody style="background-color: white">
									<c:forEach var="list" items="${list }">
										<c:forEach var="readList" items="${readList}">
											<c:if test="${ readList eq list.msg_seq}">
												<script type="text/javascript">
												$( document ).ready(function() {
													$('#read${list.msg_seq}').text('읽음');
												});
										</script>
											</c:if>
										</c:forEach>
										<tr id="msg${list.msg_seq}">
											<td><input type="checkbox" name="chk" value="${list.msg_seq }"></td>
											<td>${list.get_id }</td>
											<td style="text-align: left;" onclick="showMsgFunction(${list.msg_seq});">${list.content }</td>
											<td><small>${list.regdate }</small></td>
											<td id="read${list.msg_seq}"></td>
										</tr>


										<!-- 쪽지 디테일 모달 -->
										<div class="modal show" id="detailMsg${list.msg_seq}">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header modal-header-info">
														<h4 class="modal-title">
															<span class="glyphicon glyphicon-envelope"></span> 보낸 쪽지
														</h4>
														<button type="button" class="close"
															id="close${list.msg_seq}" data-dismiss="modal"
															aria-hidden="true">×</button>
													</div>
													<div class="modal-body">
														<div class="form-group">
															<label class="col-sm-12" for="inputTo"><span
																class="glyphicon glyphicon-user"></span>받은 사람</label>
															<div class="col-sm-10">
																<input type="text" class="form-control" id="inputTo${list.msg_seq}"
																	placeholder="comma separated list of recipients"
																	readonly="readonly" name="get_id"
																	value="${list.get_id }">
															</div>
														</div>
														<div class="form-group">
															<label class="col-sm-12" for="inputBody"><span
																class="glyphicon glyphicon-list"></span>쪽지 내용</label>
															<div class="col-sm-12">
																<textarea class="form-control" id="inputBody${list.msg_seq}" rows="8"
																	name="content" readonly="readonly"
																	style="resize: none;">${list.content }</textarea>
															</div>
														</div>
														<div class="modal-footer">
															<input type="reset" class="btn btn-default pull-left"
																id="cancle${list.msg_seq}" data-dismiss="modal"
																style="border: 1px solid lightgray;" value="확인" /> 
														</div>
													</div>
												</div>
												<!-- /.modal-content -->
											</div>
											<!-- /.modal-dialog -->
										</div>
										<!-- /.modal compose message -->

									</c:forEach>
								</tbody>
							</table>
						</form>
					</div>
				</div>
			</div>


			<div class="row" style="display: block;">
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<li class="page-item disabled"><a class="page-link" href="#"
							tabindex="-1">Previous</a></li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item"><a class="page-link" href="#">Next</a>
						</li>
					</ul>
				</nav>
			</div>
		</div>


	</section>

	<jsp:include page="common/footer.jsp"></jsp:include>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="js/agency.js"></script>

	<!-- 쪽지 보내기 모달 -->
	<div class="modal show" id="sendMsgModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header modal-header-info">
					<h4 class="modal-title">
						<span class="glyphicon glyphicon-envelope"></span> 쪽지보내기
					</h4>
					<button type="button" class="close" id="close" data-dismiss="modal"
						aria-hidden="true">×</button>

				</div>
				<div class="modal-body">

					<form role="form" class="form-horizontal" action="${pageContext.request.contextPath}/msg">
						<input type="hidden" name="command"  value="sendMsg"/>
						<input type="hidden" name="send_id"  value="${u_id }"/>
						<div class="form-group">
							<label class="col-sm-12" for="inputTo"><span
								class="glyphicon glyphicon-user"></span>받는사람</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputTo"
									placeholder="comma separated list of recipients"
									readonly="readonly" name="get_id"
									style="width: 430px">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-12" for="inputBody"><span
								class="glyphicon glyphicon-list"></span>쪽지 내용</label>
							<div class="col-sm-12">
								<textarea class="form-control" id="inputBody" rows="8"
									name="content" style="resize: none;"></textarea>
							</div>
						</div>
						<div class="modal-footer">
							<input type="reset" id="reset" class="btn btn-default pull-left"
								data-dismiss="modal" style="border: 1px solid lightgray;"
								value="취소" />
							<!-- <button type="button" class="btn btn-warning pull-left">Save
								Draft</button> -->
							<input type="submit" class="btn btn-primary"
								style="background-color: #fec503; border-color: #fec503;"
								value="보내기" />

						</div>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal compose message -->

</body>
</html>
