<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<title>관리자용 서비스 관리</title>
<link href="<c:url value='/css/g3d/css/style.css' />" type="text/css" rel="stylesheet" />
<script type="text/javaScript" language="javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"/>"></script>
<!-- <script type="text/javaScript" language="javascript" src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"/></script> -->
<!-- <script type="text/javaScript" language="javascript" src="<c:url value='/js/egovframework/com/jquery-1.4.2.min.js'/>"></script> -->
<!-- <script type="text/javaScript" language="javascript" src="<c:url value='/js/g3d/jquery-1.11.3.js'/>"></script> -->
<script type="text/javaScript" language="javascript">

// error message globalization !! - khj 20150717

// global variables
var showingNone = 0;
var showingRasters = 1;
var showingVectors = 2;
var candidateStatus = showingNone; 

var emptyUrl = 0;
var alreadyMade = 1;
var haveToCheck = 2;
var nowChecking = 3;
var checkedAsSuccess = 4;
var checkedAsFailure = 5;
var geoServerStatus = emptyUrl;

var upward = 0;
var downward = 1;

var wmsVersion = null;
var wfsVersion = null;

// initialization
$(function()
{
	// *********** initializing global variables ***********
	
	var url = $("#url").val();
	if(url == null || url.length == 0)
		geoServerStatus = emptyUrl;
	else
		geoServerStatus = alreadyMade;
	

	// *********** setting event handlers ***********
	
	// url이 변경됐을 때 전역변수 geoServerStatus 값 변경
	$("#url").keyup(function(){
		//alert("geoServerStatus : " + geoServerStatus);
		geoServerStatus = haveToCheck;
		wmsVersion = null;
		wfsVersion = null;
		$("#geoServerCheckResult").attr("class", "ok");
		$("#geoServerCheckResult").text("새로운 GeoServer URL이 입력됐습니다. 검증을 위해 '접근확인'을 눌러주세요.");
	});
	
	// '접근확인'을 눌렀을 때 GeoServer 사용 가능함 확인
	$("#checkGeoServer").click(function(){
		//alert('접근확인 클릭!');
	
		var url = $("#url").val() + "ows";
		//alert("url : " + url);
		
		var wfsParameters = {};
		wfsParameters.service="wfs";
		wfsParameters.request="GetCapabilities";
		
		var jqXHR = $.ajax({
			url: url,
			data: wfsParameters,
		})
		.done(function(data, textStatus, jqXHR)
		{
			//alert("wfs GetCapabilities arriven");
			var $xml = $(data);
			var rootNodeCount = $xml.find("WFS_Capabilities").length;
			if(rootNodeCount != 1)
			{
				resultOfCheckGeoServer(false, "해당 GeoServer의 WFS GetCapabilities가 정상응답 하지 않습니다.");
				return;
			}
			
			var rootNode = $xml.find("WFS_Capabilities")[0];
			var thisWfsVersion = $(rootNode).attr("version");
			if(thisWfsVersion == null)
			{
				resultOfCheckGeoServer(false, "해당 GeoServer의 WFS 버전을 확인할 수 없습니다.");
				return;
			}
			//alert("wfs version : " + thisWfsVersion);
			
			var wmsParameters = {};
			wmsParameters.service = "wms";
			wmsParameters.request = "GetCapabilities";
			
			$.ajax({
				url: url,
				data: wmsParameters,
			})
			.done(function(data, textStatus, jqXHR)
			{
				var $xml = $(data);
				var rootNodeCount = $xml.find("WMS_Capabilities").length;
				if(rootNodeCount != 1)
				{
					resultOfCheckGeoServer(false, "해당 GeoServer의 WMS GetCapabilities가 정상응답 하지 않습니다.");
					return;
				}
				
				var rootNode = $xml.find("WMS_Capabilities")[0];
				var thisWmsVersion = $(rootNode).attr("version");
				if(thisWmsVersion == null)
				{
					resultOfCheckGeoServer(false, "해당 GeoServer의 WMS 버전을 확인할 수 없습니다.");
					return;
				}
				//alert("wfs version : " + thisWfsVersion +", wms version : " + thisWmsVersion);
				wfsVersion = thisWfsVersion;
				wmsVersion = thisWmsVersion;
				resultOfCheckGeoServer(true, "사용 가능한 GeoServer URL입니다.");
			})
			.fail(function(jqXHR, textStatus, errorThrown)
			{
				resultOfCheckGeoServer(false, "유효하지 않은 GeoServer URL 입니다.");
			})
			.always(function(data, textStatus, jqXHR)
			{
		
			});
		})
		.fail(function(jqXHR, textStatus, errorThrown)
		{
			resultOfCheckGeoServer(false, "유효하지 않은 GeoServer URL 입니다.");
		})
		.always(function(wfsParameters, textStatus, jqXHR)
		{
			
		});
	});
	
	// raster zorder를 올렸을 때
	$(".rasterUp").click(function(){
		//alert('raster zorder up 클릭!');
		var selectedItem = $(this).parent();
		var selectedIndex = $("#rasterListUiList > li").index(selectedItem);
		//alert("selected item index : " + selectedIndex);
		
		if(selectedIndex <= 0)
			return;
		//alert("let's change zorder");
		
		var refRasterItem = $("#rasterList > li").eq(selectedIndex-1);
		var targetRasterItem = $("#rasterList > li").eq(selectedIndex);
		refRasterItem.before(targetRasterItem);
		
		var refUiItem = $("#rasterListUiList > li").eq(selectedIndex-1);
		var targetUiItem = $("#rasterListUiList > li").eq(selectedIndex);
		refUiItem.before(targetUiItem);
	});
	
	// raster zorder를 내렸을 때
	$(".rasterDown").click(function(){
		//alert('raster zorder down 클릭!');
		var selectedItem = $(this).parent();
		var selectedIndex = $("#rasterListUiList > li").index(selectedItem);
		//alert("selected item index : " + selectedIndex);
		
		if(selectedIndex >= $("#rasterListUiList > li").length-1)
			return;
		//alert("let's change zorder");
		
		var refRasterItem = $("#rasterList > li").eq(selectedIndex+1);
		var targetRasterItem = $("#rasterList > li").eq(selectedIndex);
		refRasterItem.after(targetRasterItem);
		
		var refUiItem = $("#rasterListUiList > li").eq(selectedIndex+1);
		var targetUiItem = $("#rasterListUiList > li").eq(selectedIndex);
		refUiItem.after(targetUiItem);
	});
	
	// raster를 지웠을 때
	$(".rasterDelete").click(function(){
		//alert('delete raster 클릭!');
		var selectedItem = $(this).parent();
		var selectedIndex = $("#rasterListUiList > li").index(selectedItem);
		//alert("selected item index : " + selectedIndex);
		
		$("#rasterListUiList > li").eq(selectedIndex).remove();
		$("#rasterList > li").eq(selectedIndex).remove();
	});
	
	// vector zorder를 올렸을 때
	$(".vectorUp").click(function(){
		//alert('vector zorder up 클릭!');
		var selectedItem = $(this).parent();
		var selectedIndex = $("#vectorListUiList > li").index(selectedItem);
		//alert("selected item index : " + selectedIndex);
		
		if(selectedIndex <= 0)
			return;
		//alert("let's change zorder");
		
		var refVectorItem = $("#vectorList > li").eq(selectedIndex-1);
		var targetVectorItem = $("#vectorList > li").eq(selectedIndex);
		refVectorItem.before(targetVectorItem);
		
		var refUiItem = $("#vectorListUiList > li").eq(selectedIndex-1);
		var targetUiItem = $("#vectorListUiList > li").eq(selectedIndex);
		refUiItem.before(targetUiItem);
	});
	
	// vector zorder를 내렸을 때
	$(".vectorDown").click(function(){
		//alert('vector zorder down 클릭!');
		var selectedItem = $(this).parent();
		var selectedIndex = $("#vectorListUiList > li").index(selectedItem);
		//alert("selected item index : " + selectedIndex);
		
		if(selectedIndex >= $("#vectorListUiList > li").length-1)
			return;
		//alert("let's change zorder");
		
		var refVectorItem = $("#vectorList > li").eq(selectedIndex+1);
		var targetVectorItem = $("#vectorList > li").eq(selectedIndex);
		refVectorItem.after(targetVectorItem);
		
		var refUiItem = $("#vectorListUiList > li").eq(selectedIndex+1);
		var targetUiItem = $("#vectorListUiList > li").eq(selectedIndex);
		refUiItem.after(targetUiItem);
	});
	
	// vector를 지웠을 때
	$(".vectorDelete").click(function(){
		//alert('delete vector 클릭!');
		var selectedItem = $(this).parent();
		var selectedIndex = $("#vectorListUiList > li").index(selectedItem);
		//alert("selected item index : " + selectedIndex);

		$("#vectorListUiList > li").eq(selectedIndex).remove();
		$("#vectorList > li").eq(selectedIndex).remove();
	});
	
	// raster list에서 '추가'를 눌렀을 때
	$("#rasterCandidates").click(function(){
		//alert('raster 추가 클릭!');
		candidateStatus = showingRasters;
		
		var headerNode = $("#sectionadd > h2")[0];
		$(headerNode).text("Raster Layer 추가");
		$("#addList").empty();
		
		var url = $("#url").val() + "ows";
		//alert("url : " + url);
		
		var data = {};
		data.service="wms";
		data.request="GetCapabilities";
		
		var jqXHR = $.ajax({
			url: url,
			data: data,
		})
		.done(function(data, textStatus, jqXHR)
		{
			extractRasterList(data);
		})
		.fail(function(jqXHR, textStatus, errorThrown)
		{
			//alert("wms:GetCapabilities ERROR");
			$("#addList").text("GeoServer의 WMS가 유효하지 않습니다.");
		})
		.always(function(data, textStatus, jqXHR)
		{
		});
	});
	
	// vector list에서 '추가'를 눌렀을 때
	$("#vectorCandidates").click(function(){
		//alert('vector 추가 클릭!');
		candidateStatus = showingVectors;
		
		var headerNode = $("#sectionadd > h2")[0];
		$(headerNode).text("Vector Layer 추가");
		$("#addList").empty();
		
		var url = $("#url").val() + "ows";
		//alert("url : " + url);
		
		var data = {};
		data.service="wfs";
		data.request="GetCapabilities";
		
		var jqXHR = $.ajax({
			url: url,
			data: data,
		})
		.done(function(data, textStatus, jqXHR)
		{
			extractVectorList(data);
		})
		.fail(function(jqXHR, textStatus, errorThrown)
		{
			//alert("wfs:GetCapabilities ERROR");
			$("#addList").text("GeoServer의 WFS가 유효하지 않습니다.");
		})
		.always(function(data, textStatus, jqXHR)
		{
		});
	});
	
	// candidate window에서 '확인'을 눌렀을 때
	$("#addLayers").click(function(){
		//alert('layer 추가 확인 클릭!');

		var bExistCandidates = $("#addList").children("ul").length;
		if(bExistCandidates === 0)
		{
			candidateStatus = showingNone;
			clearCandidateWindow();
			return;
		}

		var candidateList = $("#candidates").children("li");
		var listToBeAdded = [];

		for(i = 0; i < candidateList.length; i++)
		{
			var checkBox = $(candidateList[i]).children("input")[0];
			var isChecked = $(checkBox).is(":checked");
			if(isChecked)
				listToBeAdded.push($(candidateList[i]).text());
		}
		//alert("selected layers : " + listToBeAdded);
		
		addLayersToList(listToBeAdded);
		
		candidateStatus = showingNone;
		clearCandidateWindow();
	});
	
	// candidate window에서 '취소'를 눌렀을 때
	$("#cancelAddingLayers").click(function(){
		//alert('layer 추가 취소 클릭!');
		candidateStatus = showingNone;
		
		clearCandidateWindow();
	});
	
	// '저장'를 눌렀을 때
	$("#save").click(function(){
		//alert('저장 클릭!');
		if(!validateServiceSettings())
			return;
		
		$("#serviceSettingVO").submit();
	});
	
	// '취소'를 눌렀을 때
	$("#cancelSetting").click(function(){
		//alert('저장 취소클릭!');
		$("#serviceSettingVO").attr({action : "<c:url value='/uat/uia/actionMain.do'/>"});
		var msg = document.getElementById("serviceSettingVO").action;
		//alert("cancel url : " + msg);
		$("#serviceSettingVO").submit();
	});
}
);

function clearCandidateWindow()
{
	var headerNode = $("#sectionadd > h2")[0];
	$(headerNode).text("Layer 추가");
	$("#addList").empty();
}

function addLayersToList(listToBeAdded)
{
	var boundVarOfLayer;
	var boundVarOfAlpha;
	var targetList;
	var targetUiList;
	var upClass;
	var downClass;
	var deleteClass;
	
	if(candidateStatus == showingRasters)
	{
		boundVarOfLayer = "rasters";
		boundVarOfAlpha = "rasterAlphas";
		targetList = "#rasterList";
		targetUiList = "#rasterListUiList";
		upClass = "rasterUp";
		downClass = "rasterDown";
		deleteClass = "rasterDelete";
	}
	else if(candidateStatus == showingVectors)
	{
		boundVarOfLayer = "vectors";
		boundVarOfAlpha = "vectorAlphas";
		targetList = "#vectorList";
		targetUiList = "#vectorListUiList";
		upClass = "vectorUp";
		downClass = "vectorDown";
		deleteClass = "vectorDelete";
	}
	else
		return;

	for(i = 0; i < listToBeAdded.length; i++)
	{
		// layer name list
		var newList = $("<li></li>");
		
		var label = $("<a></a>");
		$(label).attr("href", "#");
		$(label).text(listToBeAdded[i]);
		$(newList).append(label);
		
		var input = $("<input>");
		$(input).attr("type", "hidden");
		$(input).attr("value", listToBeAdded[i]);
		$(input).attr("name", boundVarOfLayer);
		$(newList).append(input);
		
		$(targetList).append(newList);
		
		// layer name ui list
		var newUiList = $("<li></li>");
		
		var buttonUp = $("<button></button>");
		$(buttonUp).attr("class", "imgbtn up " + upClass);
		$(buttonUp).attr("type", "button");
		$(buttonUp).attr("title", "UP");
		var spanUp = $("<span></span>");
		$(spanUp).text("up");
		$(buttonUp).append(spanUp);
		$(newUiList).append(buttonUp);
		
		var buttonDown = $("<button></button>");
		$(buttonDown).attr("class", "imgbtn down " + downClass);
		$(buttonDown).attr("type", "button");
		$(buttonDown).attr("title", "down");
		var spanDown = $("<span></span>");
		$(spanDown).text("down");
		$(buttonDown).append(spanDown);
		$(newUiList).append(buttonDown);
		
		var buttonDelete = $("<button></button>");
		$(buttonDelete).attr("class", "imgbtn delete " + deleteClass);
		$(buttonDelete).attr("type", "button");
		$(buttonDelete).attr("title", "delete");
		var spanDelete = $("<span></span>");
		$(spanDelete).text("down");
		$(buttonDelete).append(spanDelete);
		$(newUiList).append(buttonDelete);
		
		var spanAlpha = $("<span></span>");
		$(spanAlpha).text("alpha");
		var inputAlpha = $("<input>");
		$(inputAlpha).attr("type", "text");
		$(inputAlpha).attr("value", "1.0");
		$(inputAlpha).attr("name", boundVarOfAlpha);
		$(spanAlpha).append(inputAlpha);
		$(newUiList).append(spanAlpha);
		
		$(targetUiList).append(newUiList);
		
		// zorder를 올렸을 때
		$(buttonUp).click(function(){
			//alert('vector zorder up 클릭!');
			var selectedItem = $(this).parent();
			var selectedIndex = $(targetUiList + " > li").index(selectedItem);
			//alert("selected item index : " + selectedIndex);
			
			if(selectedIndex <= 0)
				return;
			//alert("let's change zorder");
			
			var refVectorItem = $(targetList+ " > li").eq(selectedIndex-1);
			var targetVectorItem = $(targetList+ " > li").eq(selectedIndex);
			refVectorItem.before(targetVectorItem);
			
			var refUiItem = $(targetUiList + " > li").eq(selectedIndex-1);
			var targetUiItem = $(targetUiList + " > li").eq(selectedIndex);
			refUiItem.before(targetUiItem);
		});
		
		// zorder를 내렸을 때
		$(buttonDown).click(function(){
			//alert('raster zorder down 클릭!');
			var selectedItem = $(this).parent();
			var selectedIndex = $(targetUiList + " > li").index(selectedItem);
			//alert("selected item index : " + selectedIndex);
			
			if(selectedIndex >= $(targetUiList + " > li").length-1)
				return;
			//alert("let's change zorder");
			
			var refRasterItem = $(targetList+ " > li").eq(selectedIndex+1);
			var targetRasterItem = $(targetList+ " > li").eq(selectedIndex);
			refRasterItem.after(targetRasterItem);
			
			var refUiItem = $(targetUiList + " > li").eq(selectedIndex+1);
			var targetUiItem = $(targetUiList + " > li").eq(selectedIndex);
			refUiItem.after(targetUiItem);
		});
		
		// 지웠을 때
		$(buttonDelete).click(function(){
			//alert('delete raster 클릭!');
			var selectedItem = $(this).parent();
			var selectedIndex = $(targetUiList + " > li").index(selectedItem);
			//alert("selected item index : " + selectedIndex);
			
			$(targetUiList + " > li").eq(selectedIndex).remove();
			$(targetList+ " > li").eq(selectedIndex).remove();
		});
	}
}

function resultOfCheckGeoServer(bAvailable, msg)
{
	if(bAvailable)
	{
		geoServerStatus = checkedAsSuccess;
		$("#geoServerCheckResult").attr("class", "ok");
		$("#geoServerCheckResult").text("사용 가능한 GeoServer URL입니다.");
	}
	else
	{
		geoServerStatus = checkedAsFailure;
		$("#geoServerCheckResult").attr("class", "no");
		$("#geoServerCheckResult").text(msg);
	}
}

function extractRasterList(data)
{
	//alert("data arriven.");

	var $xml = $(data);

	var layerGroup = $xml.find("Capability").children("Layer")[0];
	if(layerGroup == null)
	{
		$("#addList").text("Geoserver가 제공하는 raster가 없습니다.");
		return;
	}
	//alert("layer group exists");

	var layerCount = $(layerGroup).children("Layer").length;
	if(layerCount <= 0)
	{
		$("#addList").text("Geoserver가 제공하는 raster가 없습니다.");
		return;
	}
	//alert("layers exist");

	var tmpLayerList = [];
	$(layerGroup).children("Layer").each(function(){
		var layerNameNode = $(this).children("Name")[0];
		tmpLayerList.push($(layerNameNode).text());
	});
	//alert("layer candidates count : : " + tmpLayerList.length);
	
	var rasterList = [];
	$("#rasterList").children("li").each(function(){
		var rasterNameNode = $(this).children("a")[0];
		rasterList.push($(rasterNameNode).text());
	});
	//alert("existing rasters : " + rasterList);

	var finalCandidateList = [];
	for(i = 0; i < tmpLayerList.length; i++)
	{
		var bAlreadyExist = false;
		for(j = 0; j < rasterList.length; j++)
		{
			if(tmpLayerList[i] === rasterList[j])
			{
				bAlreadyExist = true;
				break;
			}
		}
		
		if(!bAlreadyExist)
			finalCandidateList.push(tmpLayerList[i]);
	}
	//alert("final candidates : " + finalCandidateList);
	
	var newUlNode = $("<ul></ul>");
	$(newUlNode).attr("id", "candidates");
	$(newUlNode).appendTo("#addList");

	for(i = 0; i < finalCandidateList.length; i++)
	{
		var listItem = $("<li></li>");
		var inputItem = $("<input>");
		$(inputItem).attr("type", "checkbox");
		listItem.append(inputItem);
		listItem.append(finalCandidateList[i]);
		$(newUlNode).append(listItem);
	}
}

function extractVectorList(data)
{
	//alert("data arriven.");
	var $xml = $(data);
	
	var featureTypeGroup = $xml.find("FeatureTypeList")[0];
	if(featureTypeGroup == null)
	{
		$("#addList").text("Geoserver가 제공하는 vector가 없습니다.");
		return;
	}
	//alert("layer group exists")
	
	var layerCount = $(featureTypeGroup).children("FeatureType").length;
	if(layerCount <= 0)
	{
		$("#addList").text("Geoserver가 제공하는 vector가 없습니다.");
		return;
	}
	//alert("layers exist");
	
	var tmpLayerList = [];
	$(featureTypeGroup).children("FeatureType").each(function(){
		var layerNameNode = $(this).children("Name")[0];
		tmpLayerList.push($(layerNameNode).text());
	});
	//alert("layer candidates count : : " + tmpLayerList.length);
	
	var vectorList = [];
	$("#vectorList").children("li").each(function(){
		var rasterNameNode = $(this).children("a")[0];
		vectorList.push($(rasterNameNode).text());
	});
	//alert("existing rasters : " + rasterList);
	
	var finalCandidateList = [];
	for(i = 0; i < tmpLayerList.length; i++)
	{
		var bAlreadyExist = false;
		for(j = 0; j < vectorList.length; j++)
		{
			if(tmpLayerList[i] === vectorList[j])
			{
				bAlreadyExist = true;
				break;
			}
		}
		
		if(!bAlreadyExist)
			finalCandidateList.push(tmpLayerList[i]);
	}
	//alert("final candidates : " + finalCandidateList);

	var newUlNode = $("<ul></ul>");
	$(newUlNode).attr("id", "candidates");
	$(newUlNode).appendTo("#addList");

	for(i = 0; i < finalCandidateList.length; i++)
	{
		var listItem = $("<li></li>");
		var inputItem = $("<input>");
		$(inputItem).attr("type", "checkbox");
		listItem.append(inputItem);
		listItem.append(finalCandidateList[i]);
		$(newUlNode).append(listItem);
	}
}

// save & cancel
function actionSave()
{
	if(!validateServiceSettings())
		return;

	// form을 제출하기 전에 raster list와 vector list를
	// hidden 변수인 rasters와 vectors에 넣어줘야 한다.
	// 그래야 서버에서 자동으로 도메인 모델과 링크가 된다.
	document.serviceSettingVO.submit();
}

function actionCancel()
{
	document.serviceSettingVO.action="<c:url value='/uat/uia/actionMain.do'/>";
	document.serviceSettingVO.submit();
}

function validateServiceSettings()
{
	// geoserver availability
	if(geoServerStatus == emptyUrl)
	{
		alert("사용할 GeoServer URL이 정해지지 않았습니다.");
		return false;
	}
	if(geoServerStatus == haveToCheck)
	{
		alert("입력한 GeoServer URL이 검증되지 않습니다.");
		return false;
	}
	if(geoServerStatus == checkedAsFailure)
	{
		alert("입력한 GeoServer URL을 사용할 수 없습니다.");
		return false;
	}
	
	return true;
}
</script>
</head>
<!-- <body onload="initialize();"> -->
<body>
<form id="serviceSettingVO" name="serviceSettingVO" action ="<c:url value='/g3d/setNormalServiceSettings.do'/>" method="post">
<div id="header">
	<h1>관리자용 서비스관리</h1>
</div>
<div id="nav">
	<p>
		<input type="hidden" value="${serviceSetting.id}" name="id" >
    	<label>URL</label>
    	<c:choose>
	    	<c:when test="${serviceSetting.url == null}">
		<input id="url" type="text" size="100" name="url">
	        </c:when>
	        <c:otherwise>
		<input id="url" type="text" value="${serviceSetting.url}" size="100" name="url">
	        </c:otherwise>
        </c:choose>
        <input type="hidden" value="${serviceSetting.wmsVersion}" id="wmsVersion" name="wmsVersion">
        <input type="hidden" value="${serviceSetting.wfsVersion}" id="wfsVersion" name="wfsVersion">
        <button id="checkGeoServer" class="btnsm" type="button">접근확인</button>
    </p>
    <p class="message">
        <span class="ok" id="geoServerCheckResult">새 URL을 입력했을 경우 사용가능한 URL인지 확인하기 위해 '접근확인'을 눌러 주세요.</span>
    </p>
    <p>
    	<label>좌표체계</label>
        <input id="coordinateSystem" type="text" value="${serviceSetting.coordinateSystem}" name="coordinateSystem">
    </p>
    <p>
    	<label>초기좌표</label>
    	<c:choose>
	    	<c:when test="${serviceSetting.url == null}">
        경도<input id="initialLon" type="text" value="경도" name="initialLon">위도<input type="text" value="위도" name="initialLat">
        	</c:when>
	        <c:otherwise>
		경도 <input id="initialLon" type="text" value="${serviceSetting.initialLon}" name="initialLon">   위도 <input type="text" value="${serviceSetting.initialLat}" name="initialLat">
			</c:otherwise>
        </c:choose>
    </p>
    <p>
    	<label>초기확대배율</label>
        <input id="initialZoom" type="text" value="${serviceSetting.initialZoom}" name="initialZoom">
    </p>

</div>
<!-- END HEADER -->
    
<div id="contents">
    <div class="section">
        <h2>Raster Layer List</h2>
        <ul class="list" id="rasterList">
			<c:forEach var="layerName" items="${serviceSetting.rasters}" varStatus="status">
			<li><a href="#">${layerName}</a><input type="hidden" value="${layerName}" name="rasters"></li>
			</c:forEach>            	          	
        </ul>
        <ul class="btns" id="rasterListUiList">
			<c:forEach var="alpha" items="${serviceSetting.rasterAlphas}"  varStatus="status">
			<li>
                <button class="imgbtn up rasterUp" type="button" title="UP"><span>up</span></button>
                <button class="imgbtn down rasterDown" type="button" title="down"><span>down</span></button>
                <button class="imgbtn delete rasterDelete" type="button" title="delete"><span>delete</span></button>
                <span>alpha <input type="text" value="${alpha}" name="rasterAlphas"></span>
            </li>
			</c:forEach>
        </ul>
		<div class="AlignRight">
			<button id="rasterCandidates" class="btnsm" type="button">추가</button>
		</div>        
    </div>
    <!-- END Raster Layer List -->
    <div class="section">
        <h2>Vector Layer List</h2>
        <ul class="list" id="vectorList">
			<c:forEach var="layerName" items="${serviceSetting.vectors}" varStatus="status">
			<li><a href="#">${layerName}</a><input type="hidden" value="${layerName}" name="vectors"></li>
			</c:forEach>        	          	
        </ul>
        <ul class="btns" id="vectorListUiList">
			<c:forEach var="alpha" items="${serviceSetting.vectorAlphas}" varStatus="status">
			<li>
                <button class="imgbtn up vectorUp" type="button" title="UP"><span>up</span></button>
                <button class="imgbtn down vectorDown" type="button" title="down"><span>down</span></button>
                <button class="imgbtn delete vectorDelete" type="button" title="delete"><span>delete</span></button>
                <span>alpha <input type="text" value="${alpha}" name="vectorAlphas"></span>
            </li>
			</c:forEach>
        </ul>
        <div class="AlignRight">
            <button id="vectorCandidates" class="btnsm" type="button">추가</button>
        </div>
    </div>
    <!-- END Raster Layer List -->
</div>
<!-- END CONTENTS -->

<div id="sectionadd" style="display:;">
	<h2>Layer 추가</h2>
    <div class="addlist" id="addList">
    	
    </div>
    <div class="AlignCenter">
        <button id="addLayers" class="btnsm" type="button">확인</button>
        <button id="cancelAddingLayers" class="btnsm" type="button">취소</button>
    </div>
</div>
<!-- END SECTION ADD -->
<div id="btns">
    <button id="save" class="btn" type="button">저장</button>
    <button id="cancelSetting" class="btn" type="button">취소</button>
</div>
<!-- END BTNS -->
</form>
</body>
</html>