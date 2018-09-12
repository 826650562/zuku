<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
    <link rel="stylesheet" href="<%=path %>/css/self.css"><!------自定义css样式------>
    <link rel="stylesheet" type="text/css" media="all" href="<%=path %>/css/myscroll.css" />
    <link rel="stylesheet" href="http://localhost:8080/arcgis2/esri/css/esri.css">
    <link rel="stylesheet" href="http://localhost:8080/arcgis2/dijit/themes/claro/claro.css">
    <link href="<%=path %>/css/jquery-ui.css" rel="stylesheet">
   <%--  <script src="<%=path %>/js/index.js"></script> --%>
    <style>
        html, body, #map {
            height: 100%; width: 100%; margin: 0; padding: 0;
        }
        .searchResult{display:none;}
        .maximize{display:none;}
        .esriPopup .titlePane {
	    background-color: #444444;
	    color: #FFFFFF;
	    line-height: 20px;
	    padding-left: 6px;
	    border-radius: 5px 5px 0px 0px;
	    -webkit-border-radius: 5px 5px 0px 0px;
	    cursor: default;
	}
	.actionList{display:none;}
	.actionsPane{display:none;}
	.esriPopup .titlePane {
    background-color: #444444;
    color: #FFFFFF;
    line-height: 25px;
    padding-left: 6px;
    border-radius: 5px 5px 0px 0px;
    height:25px;
    -webkit-border-radius: 5px 5px 0px 0px;
    cursor: default;
}
.esriPopup .titleButton.close {
    right: 6px;
    top: 4px;
}
.esriPopup .titlePane {padding-left:10px;}
.esriPopup .titlePane {
    background-color: #2161b1;
    color: #FFFFFF;
    line-height: 25px;
    border-radius: 5px 5px 0px 0px;
    cursor: default;
}  
.inputOfPcs {
    height: 30px;
    margin-bottom: 10px;
    }
 .inputOfPcs label {
    float: left;
    width: 120px;
    height: 30px;
    font-size: 14px;
    line-height: 30px;
    text-align: right;
    padding-right: 10px;
}.inputOfPcs input {
    float: left;
    width: 300px;
    height: 28px;
    padding-left: 5px;
    border: #ccc 1px solid;
}
    </style>
	<script type="text/javascript" src="<%=path %>/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="<%=path %>/js/jquery-ui.min.js"></script>


    <script src="http://localhost:8080/arcgis2/init.js"></script>
    
    <script src="<%=path %>/js/dbs_config.js"></script>
     <script src="<%=path %>/js/objects/converToObje.js"></script>
    <script src="<%=path %>/js/dbsMian2.js"></script>


    <script type="text/javascript">
        $(function(){
          $("#peoSearch").attr("SearchNum",0);
          function checkLength(obj) {
          var t=true;
            obj.each(function(e){
               if($(this).val().trim()==''){
                  $(this).addClass( "ui-state-error" );
                  t=false;
               }else{
                  $(this).removeClass( "ui-state-error" );
               }
            });
            return t;
       }
	 
            $(".searchActive").show();
            $(".searchTab").on('click','li',function(){
                var thisIndex=$(this).index();

                $(".searchJiantou").removeClass("searchActive");
                $(".searchJiantou").eq(thisIndex).addClass("searchActive");

                $(".searchbox").removeClass("searchActive");
                $(".searchbox").eq(thisIndex).addClass("searchActive");
                $(".searchBtn").attr("SearchNum",thisIndex);
            });
			$( "#addpcs" ).dialog({
				autoOpen: false,
				width: 500,
				modal:true,
				buttons: [
					{
						text: "确定",
						click: function() {
						    var t=   checkLength($( ".apcs" ));
						    if(t){
						    var pcsname="'"+$("input[name='pcsname1']").val().trim()+"'";
						    var pcsssqy="'"+$("input[name='pcsssqy1']").val().trim()+"'";
						    var pcsdz="'"+$("input[name='pcsdz1']").val().trim()+"'";;
						    var pcsbh="'"+$("input[name='pcsbh1']").val().trim()+"'";
						    var pcsdh="'"+$("input[name='pcsdh1']").val().trim()+"'";
						    
						    var sql="(id,pcsmc,pcsbh,ssqu,pcsdz,dh) values("+pcsbh+","+pcsname+","+pcsbh+","+pcsssqy+","+pcsdz+","+pcsdh+")";
						    $.ajax({
				                type: 'POST',
				                url: DBS_BACKURL.AddPcs,
				                data: {ls_conditions: sql},
				                success: function (msg) {
				                    if (msg == "1" ||msg == 1) {
				                      alert("增加成功！");
				                    }else{
				                     alert("增加失败！");
				                    }
				                }
                           });
						      $( this ).dialog( "close" );
						    }
							
						}
					},
					{
						text: "取消",
						click: function() {
							$( this ).dialog( "close" );
						}
					}
				]
			});
			 $( "#updatepcs" ).dialog({
				autoOpen: false,
				width: 500,
				modal:true,
				buttons: [
					{
						text: "确定",
						click: function() {
						    var t=   checkLength( $( ".upcs" ));
						    if(t){
						    var a=_currentObject[0].attr;
						    
						    var pcsname=$("input[name='pcsname2']").val().trim()||a.pcsname;
						    var pcsssqy=$("input[name='pcsssqy2']").val().trim()||a.pcsssqy;
						    var pcsdz=$("input[name='pcsdz2']").val().trim()||a.pcsdz;
						    var pcsbh=$("input[name='pcsbh2']").val().trim()||a.pcsbh;
						    var pcsdh=$("input[name='pcsdh2']").val().trim()||a.pcsdh;
						    
						    var sql="set id="+ pcsbh+ ",pcsmc="+"'"+pcsname+"'"+",pcsbh="+"'"+pcsbh+"'"+",ssqu="+"'"+pcsssqy+"'"+",pcsdz="+"'"+pcsdz+"'"+",dh="+"'"+pcsdh+"'"+" where pcsbh="+"'"+pcsbh+"'";
						    $.ajax({
				                type: 'POST',
				                url: DBS_BACKURL.updatePcs,
				                data: {ls_conditions: sql},
				                success: function (msg) {
				                    if (msg == "1" ||msg == 1) {
				                      alert("修改成功！");
				                    }else{
				                     alert("修改失败！");
				                    }
				                } 
                           });
						      $( this ).dialog( "close" );
						    }
							
						}
					},
					{
						text: "取消",
						click: function() {
							$( this ).dialog( "close" );
						}
					}
				]
			});
        });
    </script>

   <!--  <script type="text/javascript">
        //加载美化过的滚动条，带自动计算
        (function($){
            $(window).load(function(){

                $("#content-1").mCustomScrollbar({
                    scrollInertia:150
                }); //调用一个滚动条

                $("#content-2").mCustomScrollbar({
                    scrollInertia:150
                }); //调用第二个滚动条

            });
        })(jQuery);
    </script>  -->

</head>
<body>
 

<div id="addpcs" title="增添派出所">
   <div style="margin-top:20px">
   <div class='inputOfPcs'><label>名称：</label> <input type="text" class='apcs' name="pcsname1" value='' /></div>
   <div class='inputOfPcs'><label>编号：</label> <input type="text"  class='apcs' name="pcsbh1" value='' /></div>
   <div class='inputOfPcs'><label>所属区域： </label><input type="text"  class='apcs' name="pcsssqy1" value='' /></div>
   <div class='inputOfPcs'><label>地址：</label> <input type="text" class='apcs'  name="pcsdz1" value='' /></div>
   <div class='inputOfPcs'><label>电话：</label> <input type="text" class='apcs' name="pcsdh1" value='' /></div>
</div>
</div>	

<div id="updatepcs" title="修改派出所">
   <div style="margin-top:20px">
   <div class='inputOfPcs'><label>名称：</label> <input type="text" class='upcs' name="pcsname2" value='' /></div>
   <div class='inputOfPcs'><label>编号：</label> <input type="text"  class='upcs' name="pcsbh2" value='' /></div>
   <div class='inputOfPcs'><label>所属区域： </label><input type="text"  class='upcs' name="pcsssqy2" value='' /></div>
   <div class='inputOfPcs'><label>地址：</label> <input type="text" class='upcs'  name="pcsdz2" value='' /></div>
   <div class='inputOfPcs'><label>电话：</label> <input type="text" class='upcs' name="pcsdh2" value='' /></div>
</div>
</div>


<div id="map"></div><!----地图层----->
<div id="left-panel">

    <div class="searchTab">
        <ul>
            <li>
                <div class="searchJiantou searchActive"></div>
                <div class="tabItemXtb" style="margin-top: 10px;margin-right: 5px;"><img src="<%=path %>/images/icon/dw.png" width="20" height="20"></div>
                <div class="tabItemTxt">地址</div>
            </li>
            <li>
                <div class="searchJiantou"></div>
                <div class="tabItemXtb"><img src="<%=path %>/images/searchPeoTabXtb.png" width="30" height="38"></div>
                <div class="tabItemTxt">人员</div>
            </li>
            <li>
                <div class="searchJiantou"></div>
                <div class="tabItemXtb"><img src="<%=path %>/images/searchPeoLandXtb.png" width="30" height="38"></div>
                <div class="tabItemTxt">阵地</div>
            </li>
             <li>
                <div class="searchJiantou"></div>
                <div class="tabItemXtb" style="margin-top: 10px;margin-right: 5px;"><img src="<%=path %>/images/icon/aj.png" width="20" height="20"></div>
                <div class="tabItemTxt">案件</div>
            </li>
              <li>
                <div class="searchJiantou"></div>
                <div class="tabItemXtb" style="margin-top: 10px;margin-right: 5px;"><img src="<%=path %>/images/icon/pcs.png" width="20" height="20"></div>
                <div class="tabItemTxt">派出所</div>
            </li>
        </ul>
    </div>
    <div class="searchbox searchActive">
        <input type="text" class='searchinput' value="地址"/>
        <div class="delInputTxtBtn"></div>
        <div class="searchBtn" searchnum="0" ><img src="<%=path %>/images/searchXtb.png" width="60" height="38"></div>
    </div>
    <div class="searchbox">
        <input type="text" class='searchinput'  value="人员"/>
        <div class="delInputTxtBtn"></div>
        <div class="searchBtn" ><img src="<%=path %>/images/searchXtb.png" width="60" height="38"></div>
    </div>
     <div class="searchbox">
        <input type="text" class='searchinput' value="阵地"/>
        <div class="delInputTxtBtn"></div>
        <div class="searchBtn"  ><img src="<%=path %>/images/searchXtb.png" width="60" height="38"></div>
    </div>
    <div class="searchbox">
        <input type="text" class='searchinput'  value="案件"/>
        <div class="delInputTxtBtn"></div>
        <div class="searchBtn" ><img src="<%=path %>/images/searchXtb.png" width="60" height="38"></div>
    </div>
       <div class="searchbox">
        <input type="text" class='searchinput'  value="派出所"/>
        <div class="delInputTxtBtn"></div>
        <div class="searchBtn" ><img src="<%=path %>/images/searchXtb.png" width="60" height="38"></div>
    </div>

    <div class="searchResult">
        <div id="content-1" class="content">
			<div id="accordion1">
				
			</div>   
        </div><!-- -------------content-1 -->
    </div>
</div>


   
</body>
</html>