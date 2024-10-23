<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="xyz.itwill.dao.ProductDAO"%>
<%@ page import="xyz.itwill.dto.ProductDTO"%>

<%
//비정상적으로 JSP 문서를 요청한 경우에 대한 응답 처리
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
String imgMainProduct=multipartRequest.getFilesystemName("imgMainProductModify");
String imgSubProduct=multipartRequest.getFilesystemName("imgSubProductModify");

// 기존 이미지 값을 가져옴
String existingMainImg = multipartRequest.getParameter("existingMainImg");
String existingSubImg = multipartRequest.getParameter("existingSubImg");

// 업로드된 이미지 파일이 없는 경우 기존 이미지 값을 사용
if (imgMainProduct == null) {
    imgMainProduct = existingMainImg;
}
if (imgSubProduct == null) {
    imgSubProduct = existingSubImg;
}

int numProduct=Integer.parseInt(multipartRequest.getParameter("numProductModify"));
String nameProduct=multipartRequest.getParameter("nameProductModify");
int priceProduct=Integer.parseInt(multipartRequest.getParameter("priceProductModify"));
String comProduct=multipartRequest.getParameter("comProductModify");
String brandProduct=multipartRequest.getParameter("brandProductModify");
String originProduct=multipartRequest.getParameter("originProductModify");
int typeProduct=Integer.parseInt(multipartRequest.getParameter("typeProductModify").substring(0, 1));
int statusProduct=Integer.parseInt(multipartRequest.getParameter("statusProductModify").substring(0, 1));
int rankProduct=Integer.parseInt(multipartRequest.getParameter("rankProductModify").substring(0, 1));

ProductDTO product=new ProductDTO();
product.setProductNum(numProduct);
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

// DAO를 사용하여 데이터베이스 업데이트
ProductDAO.getDAO().updateProduct(product);

// 클라이언트에게 URL 주소를 전달하여 응답
request.setAttribute("returnUrl", request.getContextPath() + "/index.jsp?workgroup=admin&work=admin_product");
%>
