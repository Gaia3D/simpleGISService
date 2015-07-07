<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   	<meta content="IE=edge" http-equiv="X-UA-Compatible">
    <title>관리자용 서비스 관리</title>
    <link href="css/style.css" type="text/css" rel="stylesheet" />
</head>
<body>
<div id="header">
	<h1>관리자용 서비스관리</h1>
</div>
<div id="nav">
	<p>
    	<label>URL</label>
        <input type="text" value="GEOServer URL" size="50">
        <button onClick="" class="btnsm" type="button">접근확인</button>
    </p>
    <p class="message">
        <span class="ok">사용가능한 URL이 아닙니다. 접근확인을 다시 실행해 주세요.</span>
    </p>
    <p>
    	<label>좌표체계</label>
        <input type="text">
    </p>
    <p>
    	<label>초기좌표</label>
        <input type="text">
    </p>
    <p>
    	<label>초기확대배율</label>
        <input type="text">
    </p>

</div>
<!-- END HEADER -->
    
<div id="contents">
    <div class="section">
        <h2>Raster Layer List</h2>
        <ul class="list">
            <li><a href="#">raster_layer_1</a>  </li>
            <li><a href="#">raster_layer_2</a>  </li>
            <li><a href="#">raster_layer_3</a>  </li>
            <li><a href="#">raster_layer_4</a>  </li>
            <li><a href="#">raster_layer_5</a>  </li>
            <li><a href="#">raster_layer_6</a>  </li>
            <li><a href="#">raster_layer_7</a>  </li>
            <li><a href="#">raster_layer_8</a>  </li>
            <li><a href="#">raster_layer_9</a>  </li>
            <li><a href="#">raster_layer_10</a>  </li>            	          	
        </ul>
        <ul class="btns">
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
        </ul>
        <div class="AlignRight">
            <button onClick="" class="btnsm" type="button">추가</button>
            <button onClick="" class="btnsm" type="button">제거</button>
        </div>        
    </div>
    <!-- END Raster Layer List -->
    <div class="section">
        <h2>Vector Layer List</h2>
        <ul class="list">
            <li><a href="#">raster_layer_1</a>  </li>
            <li><a href="#">raster_layer_2</a>  </li>
            <li><a href="#">raster_layer_3</a>  </li>
            <li><a href="#">raster_layer_4</a>  </li>
            <li><a href="#">raster_layer_5</a>  </li>
            <li><a href="#">raster_layer_6</a>  </li>
            <li><a href="#">raster_layer_7</a>  </li>
            <li><a href="#">raster_layer_8</a>  </li>
            <li><a href="#">raster_layer_9</a>  </li>
            <li><a href="#">raster_layer_10</a>  </li>            	          	
        </ul>
        <ul class="btns">
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
            <li>
                <button onClick="" class="imgbtn up" type="button" title="UP">up</button>
                <button onClick="" class="imgbtn down" type="button" title="down">down</button>
                <button onClick="" class="imgbtn delete" type="button" title="delete">delete</button>
                <span>alpha <input type="text"></span>
            </li>
        </ul>
        <div class="AlignRight">
            <button onClick="" class="btnsm" type="button">추가</button>
            <button onClick="" class="btnsm" type="button">제거</button>
        </div>
    </div>
    <!-- END Raster Layer List -->
</div>
<!-- END CONTENTS -->

<div id="sectionadd" style="display:;">
	<h2>추가</h2>
    <div class="addlist">
    	내용
    </div>
    <div class="AlignCenter">
        <button onClick="" class="btnsm" type="button">확인</button>
        <button onClick="" class="btnsm" type="button">취소</button>
    </div>
</div>
<!-- END SECTION ADD -->
<div id="btns">
    <button onClick="" class="btn" type="button">저장</button>
    <button onClick="" class="btn" type="button">취소</button>
</div>
<!-- END BTNS -->
</body>
</html>