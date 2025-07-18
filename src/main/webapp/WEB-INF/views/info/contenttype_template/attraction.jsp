<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

	<div class="container my-4">
		  <div class="row">
		    <!-- 왼쪽 컬럼 -->
		    <div class="col-md-6">
		      <ul class="list-group list-group-flush">
		
		        <c:if test="${not empty api.cmmnTelNo}">
		          <li class="list-group-item"><span class="fw-bold">문의 및 안내</span> : ${api.cmmnTelNo}</li>
		        </c:if>
		
		        <c:if test="${not empty api.address}">
		          <li class="list-group-item"><span class="fw-bold">주소</span> : ${api.address}</li>
		        </c:if>
		
		        <c:if test="${not empty api.cmmnRstde}">
		          <li class="list-group-item"><span class="fw-bold">휴일</span> : ${api.cmmnRstde}</li>
		        </c:if>
		
		        <c:if test="${not empty api.tag}">
		          <li class="list-group-item"><span class="fw-bold">판매 품목</span> : ${api.tag}</li>
		        </c:if>
		
		        <c:if test="${not empty api.bfDesc}">
		          <li class="list-group-item"><span class="fw-bold">화장실</span> : ${api.bfDesc}</li>
		        </c:if>
		
		        <c:if test="${not empty api.subwayInfo}">
		          <li class="list-group-item"><span class="fw-bold">지하철</span> : ${api.subwayInfo}</li>
		        </c:if>
		
		      </ul>
		    </div>
		
		    <!-- 오른쪽 컬럼 -->
		    <div class="col-md-6">
		      <ul class="list-group list-group-flush">
		
		        <c:if test="${not empty api.cmmnHmpgUrl}">
		          <li class="list-group-item"><span class="fw-bold">홈페이지</span> : 
		            <a href="${api.cmmnHmpgUrl}" target="_blank">${api.cmmnHmpgUrl}</a>
		          </li>
		        </c:if>
		
		        <c:if test="${not empty api.cmmnUseTime}">
		          <li class="list-group-item"><span class="fw-bold">이용시간</span> : ${api.cmmnUseTime}</li>
		        </c:if>
		
		        <c:if test="${not empty api.cmmnBsnde}">
		          <li class="list-group-item"><span class="fw-bold">주차</span> : ${api.cmmnBsnde}</li>
		        </c:if>
		
		        <c:if test="${not empty api.newAddress}">
		          <li class="list-group-item"><span class="fw-bold">신주소</span> : ${api.newAddress}</li>
		        </c:if>
		
		        <c:if test="${not empty api.cmmnFax}">
		          <li class="list-group-item"><span class="fw-bold">팩스</span> : ${api.cmmnFax}</li>
		        </c:if>
		
		      </ul>
		    </div>
		  </div>
		</div>
