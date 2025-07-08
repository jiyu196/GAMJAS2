<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/nav.jsp" %>
	<div class="container p-0 mt-5 pt-5">
  <main>
    <!-- 검색 영역 -->
    <div class="clearfix py-0 row align-items-center mb-3">
      <div class="col-2">
        <select class="form-select form-select-sm border-secondary-subtle">
          <option>10개씩 보기</option>
          <option>20개씩 보기</option>
          <option>50개씩 보기</option>
          <option>100개씩 보기</option>
        </select>
      </div>
      <form class="col input-group search-form">
        <select class="form-select form-select-sm border-secondary-subtle" name="type">
          <option value="T">제목</option>
          <option value="C">내용</option>
          <option value="I">작성자</option>
          <option value="TC">제목+내용</option>
          <option value="TI">제목+작성자</option>
          <option value="CI">내용+작성자</option>
          <option value="TCI">제목+내용+작성자</option>
        </select>

        <input type="text" class="form-control form-control-sm w-75 border-secondary-subtle"
               placeholder="Search" name="keyword">
        <input type="hidden" name="page" value="1">
        <input type="hidden" name="amount" value="${pageDto.cri.amount}">
        <input type="hidden" name="cno" value="${pageDto.cri.cno}">

        <button class="btn btn-outline-secondary btn-sm" type="submit">검색</button>
      </form>
  
<%-- <p>cViewType: ${c.cViewType}</p> --%>
		<script>
	      	$(".search-form").submit(function() {
	      		event.preventDefault();
	      		this.keyword.value = encodeURIComponent(this.keyword.value)
	      		this.submit();
	      	});
	    </script>

      <div class="col-2">
        <a href="write?${pageDto.cri.qs2}" class="btn btn-outline-success btn-sm float-end">
          <i class="fa-solid fa-pen-fancy"></i> 글쓰기
        </a>
      </div>
    </div>

<!-- 게시판 템플릿 (유지) -->
<%-- <jsp:include page="list_template/free.jsp" /> --%>
<%-- <jsp:include page="list_template/free.jsp" /> --%>

<c:forEach items="${cate}" var="c">
  <c:if  test="${c.cno == pageDto.cri.cno}">
    <c:choose>
      <c:when test="${c.getCViewType() == 'FREE'}">
        <jsp:include page="list_template/free.jsp" />
      </c:when>
      <c:when test="${c.getCViewType() == 'REVIEW'}">
        <jsp:include page="list_template/review.jsp" />
      </c:when>
      <c:when test="${c.getCViewType() == 'NOTICE'}">
        <jsp:include page="list_template/notice.jsp" />
      </c:when>
      <c:when test="${c.getCViewType() == 'QNA'}">
        <jsp:include page="list_template/qna.jsp" />
      </c:when>
    </c:choose>
  </c:if>
</c:forEach>


<!-- 페이지네이션 -->
<ul class="pagination pagination-sm justify-content-center mt-4" >
  <c:if test="${pageDto.doubleLeft}">
    <li class="page-item" >
      <a class="page-link border-0 text-success bg-transparent" href="list?page=1&${pageDto.cri.qs}" title="맨앞으로">
        <i class="fa-solid fa-angles-left" ></i>
      </a>
    </li>
  </c:if>

  <c:if test="${pageDto.left}">
    <li class="page-item">
      <a class="page-link border-0 text-success bg-transparent" href="list?page=${pageDto.start - 1}&${pageDto.cri.qs}" title="이전">
        <i class="fa-solid fa-angle-left"></i>
      </a>
    </li>
  </c:if>

  <c:forEach begin="${pageDto.start}" end="${pageDto.end}" var="i">
    <li class="page-item ${pageDto.cri.page == i ? 'active' : ''}">
      <a class="page-link ${pageDto.cri.page == i ? 'bg-success border-success text-white' : 'text-dark border-0'}"
         href="list?page=${i}&${pageDto.cri.qs}">
        ${i}
      </a>
    </li>
  </c:forEach>

  <c:if test="${pageDto.right}">
    <li class="page-item">
      <a class="page-link border-0 text-success bg-transparent" href="list?page=${pageDto.end + 1}&${pageDto.cri.qs}" title="다음">
        <i class="fa-solid fa-angle-right"></i>
      </a>
    </li>
  </c:if>

  <c:if test="${pageDto.doubleRight}">
    <li class="page-item">
      <a class="page-link border-0 text-success bg-transparent" href="list?page=${pageDto.realEnd}&${pageDto.cri.qs}" title="맨끝으로">
        <i class="fa-solid fa-angles-right"></i>
      </a>
    </li>
  </c:if>
</ul>


	</main>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>