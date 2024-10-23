<%@page import="xyz.itwill.util.Utility"%>
<%@page import="xyz.itwill.dao.ClientDAO"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    if(request.getMethod().equals("GET")) {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        return;
    }

    request.setCharacterEncoding("utf-8");
    
    String id = request.getParameter("id");
    String passwd = Utility.encrypt(request.getParameter("passwd"));
    String name = request.getParameter("name");
    String emailinput = request.getParameter("email");
    String domain = request.getParameter("domainSel");
    
    // email 형식 변환
    String email = emailinput.contains("@") ? emailinput : emailinput + "@" + domain;
    
    // mobile 형식 변환
    String mobileinput = request.getParameter("mobile");
    int mlength = mobileinput.length();
    String mobile1 = mobileinput.substring(0, mlength - 8);
    String mobile2 = mobileinput.substring(mlength - 8, mlength - 4);
    
    String mobile3 = mobileinput.substring(mlength - 4);
    String mobile = mobile1 + "-" + mobile2 + "-" + mobile3;
    String zipcode = request.getParameter("zipcode");
    String address1 = request.getParameter("address1");
    String address2 = request.getParameter("address2");
    
    
    
    // DTO 전달값
    ClientDTO client = new ClientDTO();
    client.setClientId(id);
    client.setClientPasswd(passwd);
    client.setClientName(name);
    client.setClientEmail(email);
    client.setClientMobile(mobile);
    client.setClientZipcode(zipcode);
    client.setClientAddress1(address1);
    client.setClientAddress2(address2);

    ClientDAO.getDAO().insertClient(client);
    
    request.setAttribute("returnUrl", request.getContextPath() + "/index.jsp?workgroup=client&work=client_login");
%>

<%-- 
-- 동작안함 --

<script type="text/javascript">

alert("<%=name%>님 회원가입이 완료되었습니다.");

</script>
 --%>
