<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/nav.jsp" %>
<div class="container p-0">
    <main>

        <form method="post" action="modify" id="modifyForm">
            <div class="small border-bottom border-3" style="border-color: #6A8D73;">
            <span style="color: #6A8D73;">
            <c:forEach items="${cate}" var="c">
                <c:if test="${c.cno == cri.cno}">
                    ${c.cname}
                </c:if>
            </c:forEach>
            </span> 카테고리
            </div>
            <div class="small p-0 py-2">
                <input placeholder="title" class="form-control" name="title" id="title" value="${board.title}">
            </div>
            <div class="p-0 py-3 ps-1 small border-bottom border-1 border-muted">
                <textarea name="content" id="editor1" class="form-control resize-none">${board.content}</textarea>
            </div>
            <div class="my-4">
                <a href="${cp}/board/list?${cri.qs2}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-list-ul"></i> 목록
                </a>
                <div class="float-end">
                    <button class="btn btn-outline-success btn-sm">
                        <i class="fa-solid fa-pen-fancy"></i> 글수정
                    </button>
                </div>
            </div>
            <input type="hidden" name="id" value="${member.id}">
            <input type="hidden" name="bno" value="${board.bno}">
            <input type="hidden" name="cno" value="${cri.cno}">
            <input type="hidden" name="page" value="${cri.page}">
            <input type="hidden" name="amount" value="${cri.amount}">
            <input type="hidden" name="type" value="${cri.type}">
            <input type="hidden" name="keyword" value="${cri.keyword}">
            <input type="hidden" name="encodedStr" value="">
        </form>

        <!-- 첨부파일 -->
        <div class="mb-4">
            <label class="form-label fw-semibold d-inline-block me-3">
                <i class="fa-solid fa-paperclip me-1 text-secondary"></i> 첨부파일
            </label>
            <label class="btn btn-outline-success btn-sm align-text-bottom">
                파일 선택 <input type="file" multiple class="d-none" id="f1">
            </label>
            <ul class="list-group my-2 attach-list"></ul>
            <div class="row justify-content-start attach-thumb"></div>
        </div>

        <ul class="list-group my-3 attach-list">
            <c:forEach items="${board.attachs}" var="a">
                <li class="list-group-item d-flex align-items-center justify-content-between"
                    data-uuid="${a.uuid}"
                    data-origin="${a.origin}"
                    data-image="${a.image}"
                    data-path="${a.path}"
                    data-size="${a.size}"
                    data-odr="${a.odr}">
                    <a href="${cp}/download?uuid=${a.uuid}&origin=${a.origin}&path=${a.path}">${a.origin}</a>
                    <i class="fa-solid fa-circle-xmark float-end text-danger"></i>
                </li>
            </c:forEach>
        </ul>
        <div class="row justify-content-arround w-75 mx-auto attach-thumb">
            <c:forEach items="${board.attachs}" var="a">
                <c:if test="${a.image}">
                    <div class="my-2 col-12 col-sm-4 col-lg-2 " data-uuid="${a.uuid}">
                        <div class="my-2"
                             style="height: 150px; background-size: cover; background-image:url('${cp}/display?uuid=t_${a.uuid}&path=${a.path}'); border: 1px solid #6A8D73; border-radius: 5px;">
                            <i class="fa-solid fa-circle-xmark float-end text-danger m-2"></i>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </main>
</div>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>
    $(function () {
        CKEDITOR.replace('editor1', {
            language: 'ko',
            height: 400
        });
    });
</script>

<!--  <style>
 .attach-list{cursor: grab;}
 .attach-list:active{cursoe: grabbing;}
 </style> -->

<script>
    $(function () {
        $(".attach-list").sortable();

        function validateFiles(files) {
            const MAX_COUNT = 5;
            const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
            const MAX_TOTAL_SIZE = 50 * 1024 * 1024; // 50MB
            const BLOCK_EXT = ['exe', 'sh', 'jsp', 'java', 'class', 'html', 'js']

            if (files.length > MAX_COUNT) {
                alert('파일은 최대 5개만 업로드 가능합니다');
                return false;
            }

            let totalSize = 0;
            const isValid = files.every(f => {
                const ext = f.name.split(".").pop().toLowerCase(); // 확장자 추출
                totalSize += f.size;
                return !BLOCK_EXT.includes(ext) && f.size <= MAX_FILE_SIZE;
            }) && totalSize <= MAX_TOTAL_SIZE

            if (!isValid) {
                alert('다음 파일확장자는 업로드가 불가합니다. [exe, sh, jsp, java, class, html, js] \n 또한 각 파일은 10MB 이하 전체합계는 50MB이하여야 합니다. ')
            }
            return isValid;
        }

        $(".attach-area").on("click", "i", function () {
            const uuid = $(this).closest("[data-uuid]").data("uuid");
            console.log(uuid);
            $('[data-uuid="' + uuid + '"]').remove();
        });

        $('#f1').change(function () {

            event.preventDefault();
            const formData = new FormData();

            console.log(formData);
            const files = this.files; //현재 input type file

            const data = []; // 기존 파일목록이 들어갈 곳
            $(".attach-list li").each(function () {
                //console.log({...this.dataset});
                data.push({...this.dataset});
            });

            console.log('기존', data);
            console.log('신규', [...files]);

            const mixedFiles = [...data.map(d => {
                return {name: d.origin, size: d.size / 1}
            }), ...files];
            console.log(mixedFiles);

            for (let i = 0; i < files.length; i++) {
                formData.append("f1", files[i]);
            }

            const valid = validateFiles(mixedFiles);
            if (!valid) {
                return;
            }

            $.ajax({//비동기형식으로 교체하자
                url: '${cp}/upload',
                method: 'POST',
                data: formData,
                processData: false, //data를 queryString으로 쓰지 않겠다.
                contentType: false, //multipart/form-data; 이후에 나오게 될 브라우저 정보도 포함시킨다. 즉 기본 브라우저 설정을 따르는 옵션
                success: function (data) {
                    console.log(data);
                    let str = "";
                    let thumbStr = "";
                    for (let a of data) {// 확인용 코드
                        // $(".container").append("<p>" + data[a].origin + "x</p>");
                        str += `<li class="list-group-item d-flex align-items-center justify-content-between"
						  data-uuid="\${a.uuid}"
						  data-origin="\${a.origin}"
						  data-image="\${a.image}"
						  data-path="\${a.path}"
						  data-size="\${a.size}"
						  data-odr="\${a.odr}"
						>
							<a href="${cp}/download?uuid=\${a.uuid}&origin=\${a.origin}&path=\${a.path}">\${a.origin}</a>
							<i class="fa-solid fa-circle-xmark float-end text-danger"></i>
						</li>`;
                        if (a.image) {
                            thumbStr += `<div class="my-2 col-12 col-sm-4 col-lg-2 "
							   data-uuid="\${a.uuid}"
							>
								<div class="my-2 bg-primary" 
								style="height: 150px; background-size: cover; background-image:url('${cp}/display?uuid=t_\${a.uuid}&path=\${a.path}')">
									<i class="fa-solid fa-circle-xmark float-end text-danger m-2"></i>
								</div>
								</div>`
                        }
                    }
                    $(".attach-list").append(str);
                    $(".attach-thumb").append(thumbStr);
                    // console.log(thumbStr);
                    // console.log(str);
                    //이미지인 경우와 아닌경우 -> 이미지 파일은 썸네일,
                }
            })
        })
        $('#modifyForm').submit(function () {
            event.preventDefault();
            if (!confirm("수정하시겠습니까?")) {
                return;
            }
            const data = [];
            $(".attach-list li").each(function () {
                //console.log({...this.dataset});
                data.push({...this.dataset});
            });
            console.log(JSON.stringify(data));
            data.forEach((item, idx) => item.odr = idx);
            $("[name='encodedStr']").val(JSON.stringify(data));
            this.submit();

        })

    })
</script>
<%@ include file="../common/footer.jsp" %>
</body>
</html>