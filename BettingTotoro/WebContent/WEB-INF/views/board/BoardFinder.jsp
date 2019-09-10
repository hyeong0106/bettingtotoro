<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,board.model.vo.Board" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/board.css" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Board> list = (List<Board>)request.getAttribute("list");
	
	//파라미터핸들링
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	
	String pageBar = (String)request.getAttribute("pageBar");
	int cPage = (Integer)request.getAttribute("cPage");
	
	int numPerPage = (Integer)request.getAttribute("numPerPage");
%>
<script src="<%=request.getContextPath()%>/js/jquery-3.4.0.js"></script>
<script>
	$(function(){
		$("#searchType").change(function(){
			var type = $(this).val();
			$("#search-memberId, #search-boardTitle").hide();
			$("#search-"+type).css('display','inline-block');
		});
		$("#numPerPage").change(function(){
			$("#numPerPageFrm").submit();
		});
		$(".select").click(function(){
			var boardNo = this.cells[0].innerText;
			location.href="<%=request.getContextPath()%>/board/boardView?boardNo="+boardNo;
		});
	});
</script>
<style>
	div#search-memberId{
		display: <%=searchType==null || "memberId".equals(searchType)?"inline-block":"none"%>;
	}
	div#search-boardTitle{
		display: <%="boardTitle".equals(searchType)?"inline-block":"none"%>;
	}
</style>
<section>
<div class="background">
<img src="<%=request.getContextPath()%>/images/축구게시판배경2.png" id="soccerbackground" alt="" />
	<div id="BoardListTable1">
      <div id="search-container">
                                   검색타입:
          <select id="searchType">
              <option value="memberId" <%=searchType.equals("memberId")?"selected":"" %>>작성자</option>
              <option value="boardTitle" <%=searchType.equals("boardTitle")?"selected":"" %>>제목</option>
          </select>
          <div id="search-memberId">
          	<form action="<%=request.getContextPath()%>/board/boardFinder">
                  <input type="hidden" name="searchType" value = "memberId" />
                  <input type="hidden" name="numPerPage" value="<%=numPerPage%>"/>
                  <input type="search" name="searchKeyword" size="25" 
                  		 placeholder="검색할 아이디를 입력하세요."
                  		 value="<%="memberId".equals(searchType)?searchKeyword:""%>"/>
                  <input type="submit" class="submit-btn" value="검색"/>
            </form>
          </div>
          <div id="search-boardTitle">
	          <form action="<%=request.getContextPath()%>/board/boardFinder">
                  <input type="hidden" name="searchType" value = "boardTitle" />
                  <input type="hidden" name="numPerPage" value="<%=numPerPage%>"/>
                  <input type="search" name="searchKeyword" size="25" 
                  		 placeholder="검색할 제목을 입력하세요."
                  		 value="<%="boardTitle".equals(searchType)?searchKeyword:""%>"/>
                  <input type="submit" class="submit-btn" value="검색"/> 
               </form>  
          </div>
          <!-- numPerPage 설정 -->
		<div id="numPerPage-container">
			페이지당 게시글수:
			<form name="numPerPageFrm"
				  id="numPerPageFrm"
				  action="<%=request.getContextPath()%>/board/boardFinder">
				<input type="hidden" name="searchType" value="<%=searchType%>"/>
				<input type="hidden" name="searchKeyword" value="<%=searchKeyword%>"/>
				<select name="numPerPage" id="numPerPage">
					<option value="10" <%=numPerPage==10?"selected":"" %>>10</option>
					<option value="5" <%=numPerPage==5?"selected":"" %>>5</option>
					<option value="3" <%=numPerPage==3?"selected":"" %>>3</option>
					
				</select>	  
			</form>
		</div>
      </div>
	</div>
	<div id="BoardListTable2">
		<%
  		if(memberLoggedIn != null){
 	  	%>
      	<button type="button" id="btn-add" class="btn btn-outline-secondary" onclick="InsertBorad();">글쓰기</button>
      	<%
  		}
      	%>
      	<table class="table">
		  <thead class="thead-dark">
		    <tr>
		      <th scope="col">번호</th>
		      <th scope="col">제목</th>
		      <th scope="col">작성자</th>
		      <th scope="col">작성일</th>
		      <th scope="col">조회수</th>
		    </tr>
		  </thead>
		  <tbody>
		    <% if(list==null||list.isEmpty()){ %>
			<tr>
				<td colspan="9" align="center"> 검색 결과가 없습니다. </td>
			</tr>
		  	<% 
			} 
			else {
				for(Board b : list){ 
		  	%>
			<tr class="select">
				<th scope="row"><%=b.getBoardNo() %></th>
				<td>
					<%=b.getBoardTitle() %>
					<%if(b.getCommentCnt()>0){ %>
		            (<%=b.getCommentCnt() %>)
		            <%} %>
				</td>
				<td><%=b.getBoardWriter() %></td>
				<td><%=b.getBoardDate() %></td>
				<td><%=b.getReadCount() %></td>
			</tr>		
		 	<%		} 
			}
			 %>
		  </tbody>
		</table>
      <div id="pageBar">
		<%=pageBar %>
	  </div>
  </div>
  </div>
</section>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>