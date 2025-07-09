<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
 <%@ include file="../common/head.jsp" %>

</head>
<body class="bg-light">
 <%@ include file="../common/nav.jsp" %>
  <div class="container my-3">
	  <!-- 탭 메뉴 -->
	  <form>
	  <ul class="nav nav-tabs mb-2 justify-content-center gap-5" id="infoTabs" role="tablist">
	    <li class="nav-item" role="presentation">
	      <a href="${cp}/info/recommendlist?recomContenttype=ATTRACTION" class="nav-link px-4 ${recommend.recomContenttype == 'ATTRACTION' ? 'active' : ''} " id="attraction-tab" type="button" role="tab">관광</a>
	    </li>
	    <li class="nav-item" role="presentation">
	      <a href="${cp}/info/recommendlist?recomContenttype=RESTAURANT"  class="nav-link px-4 ${recommend.recomContenttype == 'RESTAURANT' ? 'active' : ''} " id="restaurant-tab" type="button" role="tab">먹거리</a>
	    </li>
	    <li class="nav-item" role="presentation">
	      <a href="${cp}/info/recommendlist?recomContenttype=FESTIVAL" class="nav-link px-4 ${recommend.recomContenttype == 'FESTIVAL' ? 'active' : ''} " id="festival-tab" type="button" role="tab">체험</a>
	    </li>
	  </ul>
	  </form>
  </div>

<div class="container py-2">

  <!-- 🔍 검색바 + 📝 글쓰기 버튼 -->
  <div class="d-flex justify-content-between align-items-center mb-4 search-container">

  <!-- 검색바 먼저 -->
  <form class="search-form d-flex align-items-center" method="get">
    <div class="search-center d-flex align-items-center">
      <input type="hidden" name="recomContenttype" value="${recommend.recomContenttype}">
      <select class="form-select form-select-sm me-2" style="width: 100px;" name="type">
        <option value="T">제목</option>
        <option value="C">내용</option>
        <option value="TC">제목+내용</option>
      </select>
      <input type="text" class="form-control form-control-sm me-2" name="keyword" placeholder="검색어 입력" value="${pageDto.cri.keyword}">
      <input type="hidden" name="page" value="1">
      <input type="hidden" name="amount" value="${pageDto.cri.amount}">
      <button class="btn btn-outline-secondary btn-sm search-button" type="submit">검색</button>
    </div>
  </form>

  <!-- 글쓰기 버튼은 오른쪽 -->
  <div class="d-flex align-items-center ms-3">
    <a href="${cp}/info/write?recomContenttype=${recommend.recomContenttype}&${pageDto.cri.qsRecom}" class="btn btn-primary btn-sm">
      <i class="fa-solid fa-pen-fancy"></i> 글쓰기
    </a>
  </div>

</div>

  <script>
            	$(".search-form").submit(function() { // keyword에 대하여 encoding 해주는 역할
            		event.preventDefault();
            		this.keyword.value = encodeURIComponent(this.keyword.value)
            		this.submit();
            	});
  </script>

  <!-- 카드 목록 -->
  <div class="row row-cols-1 row-cols-md-3 g-4">
  	<c:forEach items="${recommendlist}" var="r">
	  		<div class="col">
		      <div class="card h-100">
		        <img src="https://placehold.co/400x200" class="card-img-top" alt="장소 이미지">
		        <div class="card-body">
		          <div><a href="${cp}/info/view?recomNo=${r.recomNo}" class="card-title btn btn-outline-secondary">${r.title}</a></div> 
		          <div><p class="card-text text-truncate">${r.apiSubcontent}</p></div> 
		        </div>
		      </div>
		    </div>	
  	</c:forEach>
  </div>
</div> <!-- 컨테이너 닫는 div -->

   <!-- 페이지네이션 -->
        <div class="mt-4 d-flex justify-content-center">
          <ul class="pagination">
	          <c:if test="${pageDto.doubleLeft}">
			  	<li class="page-item"><a class="page-link" href="${cp}/info/recommendlist?&recomContenttype=${recommend.recomContenttype}&page=1&${pageDto.cri.qsRecom}"><i class="fa-solid fa-angles-left"></i></a></li>
			  </c:if>
			  <c:if test="${pageDto.left}">
			  	<li class="page-item"><a class="page-link" href="${cp}/info/recommendlist?recomContenttype=${recommend.recomContenttype}&page=${pageDto.start -1}&${pageDto.cri.qsRecom}"><i class="fa-solid fa-angle-left"></i></a></li>
			  </c:if>
			  <c:forEach begin="${pageDto.start}" end="${pageDto.end}" var="i">
			  	<li class="page-item ${pageDto.cri.page  == i ? 'active' : ''}"><a class="page-link" href="${cp}/info/recommendlist?recomContenttype=${recommend.recomContenttype}&page=${i}&${pageDto.cri.qsRecom}">${i}</a></li>
			  </c:forEach>
			  <c:if test="${pageDto.right}">
			  	<li class="page-item"><a class="page-link" href="${cp}/info/recommendlist?recomContenttype=${recommend.recomContenttype}&page=${pageDto.end + 1}&${pageDto.cri.qsRecom}"><i class="fa-solid fa-angle-right"></i></a></li>
			  </c:if>
			  <c:if test="${pageDto.doubleRight}">
			  	<li class="page-item"><a class="page-link" href="${cp}/info/recommendlist?recomContenttype=${recommend.recomContenttype}&page=${pageDto.realEnd}&${pageDto.cri.qsRecom}"><i class="fa-solid fa-angles-right"></i></a></li>
			  </c:if>
          </ul>
        </div>
 <%@ include file="../common/footer.jsp" %>
</body>
</html>
