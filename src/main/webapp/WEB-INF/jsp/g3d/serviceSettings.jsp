<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>서비스 관리</title>
</head>
<body>
서비스 관리 페이지입니다.<p/>
<a href="${pageContext.request.contextPath }/EgovContent.do">관리자홈</a><p/>
GeoServer URL : ${serviceSetting.url} <p/>
Coordinate System : ${serviceSetting.coordinateSystem}<p/>
Initial Position : ${serviceSetting.initialLon},  ${serviceSetting.initialLat}<p/>
Initial Zoom : ${serviceSetting.initialZoom} <p/>

<p/>
<p/>
Registered Rasters<p/>
<c:forEach var="raster" items="${serviceSetting.rasters}" varStatus="status">
<a>${raster}</a><p/>
</c:forEach>

Registered Vectors<p/>
<c:forEach var="vector" items="${serviceSetting.vectors}" varStatus="status">
<a>${vector}</a><p/>
</c:forEach>

<p/>
<p/>
<p/>

</body>
</html>