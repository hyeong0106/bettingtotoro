<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,member.model.vo.Member" %>
<%
	List<Member> list = (List<Member>)request.getAttribute("list");
	
	//파라미터핸들링
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	
	String pageBar = (String)request.getAttribute("pageBar");
	int cPage = (Integer)request.getAttribute("cPage");
	
	int numPerPage = (Integer)request.getAttribute("numPerPage");
%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/admin.css" />
<script src="<%=request.getContextPath()%>/js/jquery-3.4.0.js"></script>
<script>
	$(function(){
		$("#searchType").change(function(){
			var type = $(this).val();
			$("#search-memberId, #search-memberName").hide();
			$("#search-"+type).css('display','inline-block');
		});
		$("#numPerPage").change(function(){
			$("#numPerPageFrm").submit();
		});
		$(".select").click(function(){
			var memberId = this.cells[0].innerText;
			location.href="<%=request.getContextPath()%>/admin/userView?memberId="+memberId;
		});
	});
</script>
<style>
	div#search-memberId{
		display: <%=searchType==null || "memberId".equals(searchType)?"inline-block":"none"%>;
	}
	div#search-memberName{
		display: <%="memberName".equals(searchType)?"inline-block":"none"%>;
	}
</style>
<section>
	<div id="UserListTable1">
		<div id="search-container">
			검색타입: 
			<select id="searchType">
				<option value="memberId" <%="memberId".equals(searchType)?"selected":"" %>>아이디</option>
				<option value="memberName" <%="memberName".equals(searchType)?"selected":"" %>>회원명</option>
			</select>
			<div id="search-memberId">
				<form action="<%=request.getContextPath() %>/admin/userFinder">
					<input type="hidden" name="searchType" value="memberId" />
					<input type="search" name="searchKeyword" size="25" 
						   placeholder="검색할 아이디를 입력하세요."
						   value="<%="memberId".equals(searchType)?searchKeyword:""%>" />
					<input type="submit" class="submit-btn" value="검색"/>
				</form>
			</div>
			<div id="search-memberName">
				<form action="<%=request.getContextPath() %>/admin/userFinder">
					<input type="hidden" name="searchType" value="memberName" />
					<input type="search" name="searchKeyword" size="25" 
						   placeholder="검색할 회원명을 입력하세요." 
						   value="<%="memberName".equals(searchType)?searchKeyword:""%>"/>
					<input type="submit" class="submit-btn" value="검색"/>
				</form>
			</div>	
		</div>
		<!-- numPerPage 설정 -->
		<div id="numPerPage-container">
			페이지당 회원수: 
			<form name="numPerPageFrm"
				  id="numPerPageFrm"
				  action="<%=request.getContextPath()%>/admin/userFinder">
				<input type="hidden" name="searchType" value="<%=searchType%>"/>
				<input type="hidden" name="searchKeyword" value="<%=searchKeyword%>"/>
				<select name="numPerPage" id="numPerPage">
					<option value="10" <%=numPerPage==10?"selected":"" %> >10</option>
					<option value="5" <%=numPerPage==5?"selected":"" %>>5</option>
					<option value="3" <%=numPerPage==3?"selected":"" %>>3</option>
				</select>
			</form>
		</div>
	</div>
	<div id="UserListTable2">
      <table class="table">
      	<thead class="thead-dark">
          <tr>
              <th scope="col">아이디</th>
              <th scope="col">회원이름</th>
              <th scope="col">이메일</th>
              <th scope="col">전화번호</th>
              <th scope="col">실적</th>
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
				for(Member m : list){ 
		  %>
			<tr class="select">
				<td><%=m.getMemberId()%></td>
				<td><%=m.getMemberName()%></td>
				<td><%=m.getEmail()!=null?m.getEmail():""%></td>
				<td><%=m.getPhone()%></td>
				<td><%=m.getScore()%></td>
					
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
</section>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
