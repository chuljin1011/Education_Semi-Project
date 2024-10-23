<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // 비정상적으로 JSP 문서를 요청한 경우에 대한 응답 처리
    if(request.getMethod().equals("GET")) {
        request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
        return;
    }
    // POST 방식으로 요청하여 전달된 값을 읽기 위한 문자형태 변경
    request.setCharacterEncoding("utf-8");

    // 파일을 저장할 서버 디렉토리의 파일 시스템 경로를 반환받아 저장
    String saveDirectory=request.getServletContext().getRealPath("/img_product");

    // MultipartRequest 객체 생성 - 모든 전달파일이 서버 디렉토리에 자동으로 업로드 처리
    MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());

    // 업로드 처리된 파일의 이름을 반환받아 저장 - 전달파일이 없는 경우 [null] 반환
    String imgMainProduct=multipartRequest.getFilesystemName("imgMainProduct");
    String imgSubProduct=multipartRequest.getFilesystemName("imgSubProduct");

    String nameProduct=multipartRequest.getParameter("nameProduct");
    int priceProduct=Integer.parseInt(multipartRequest.getParameter("priceProduct"));
    String comProduct=multipartRequest.getParameter("comProduct");
    String brandProduct=multipartRequest.getParameter("brandProduct");
    String originProduct=multipartRequest.getParameter("originProduct");
    int typeProduct=Integer.parseInt(multipartRequest.getParameter("typeProduct").substring(0, 1));
    int statusProduct=Integer.parseInt(multipartRequest.getParameter("statusProduct").substring(0, 1));
    int rankProduct=Integer.parseInt(multipartRequest.getParameter("rankProduct").substring(0, 1));    

    ProductDTO product=new ProductDTO();
    product.setProductName(nameProduct);
    product.setProductPrice(priceProduct);
    product.setProductCom(comProduct);
    product.setProductBrand(brandProduct);
    product.setProductOrigin(originProduct);
    product.setProductType(typeProduct);
    product.setProductStatus(statusProduct);
    product.setProductMainImg(imgMainProduct);
    product.setProductSubImg(imgSubProduct);
    product.setProductRank(rankProduct);

    ProductDAO.getDAO().insertProduct(product);

    // 클라이언트에게 URL 주소를 전달하여 응답
    request.setAttribute("returnUrl", request.getContextPath() + "/index.jsp?workgroup=admin&work=admin_product");
%>
