<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>族库</title>
<link href="<%=path %>/js/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="<%=path %>/css/style.css" rel="stylesheet" type="text/css">
<link href="<%=path %>/css/font-awesome-4.7.0/css/font-awesome.css" rel="stylesheet" type="text/css" />
<script>
 window.path="<%=path %>"
</script>
<script src="<%=path %>/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="<%=path %>/js/index.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->   
<script type="text/javascript">
$(function(){
   var num=30;
   var Len=$(".dataItemTxtsmall").text().length;
   if(Len>num){
	   $(".dataItemTxtsmall").text($(".dataItemTxtsmall").text().substring(0,num)+"...");
	} 	  
})

</script>
</head>
<body>

<div class="container-fluid pcnavbar">
<div class="container">
<div class="row">
  <div class="col-lg-12">
     <div class="logo">
       <a href="cgj.html"><img src="<%=path %>/images/logo.png"></a>
     </div>
     <div class="dlzc">
       <div class="z-row">
         <div class="topss">
            <a href="#" class="searchbtn"><i class="fa fa-search fa-fw"> </i></a>
            <input placeholder="关键词搜索" type="text"/>
         </div>
         <div class="z-col"><a href="#" class="btn btn-success btn-sm">登录</a></div>
         <div class="z-col"><a href="#" class="btn btn-default btn-sm">注册</a></div>
       </div>
     </div>
  </div>
</div>
</div>
</div>

<div class="container-fluid padT15">
<div class="container padLR7">
    <div class="ptcgJianSuo">
      <div class="row flsxitem">
        <div class="col-lg-12">
           <a class="ptcgJsItem  ptcgJsItemActive">全部专业</a>
           <div class="parentType">
                <!-- 插入父类数据 -->
           </div>
        </div>
      </div>
    </div>
</div>
</div>
<div class="container-fluid padT15">
<div class="container padLR7" id="firstChildType">
<!-- 待会删 -->
<div class="row">
  <div class="col-lg-12 fenlei">
 
   
  
   
  </div>
  <div class="col-lg-12">
     <div class="z-row togglebtnbox"><div class="z-col"><a class="btn btn-default togglebtn">点击展开<i class="fa fa-caret-down fa-fw"> </i></a></div></div><!------切换按钮------>
  </div> 
</div>
<!-- 待会删 -->
</div>
</div>

<div class="container-fluid">
<div class="container">
<div class="row">
<!---->
<div class="col-lg-2 dataitemcont">
<div class="dataitemouter">
 <div class="dataItem">
 <div class="row">
    <div class="col-lg-12 dataimg">
      <img src="<%=path %>/images/mximg1.png">
    </div>
 </div>
 <div class="row">
    <div class="col-lg-12 dataItemTxtsmall">带回风箱的风机盘管机组 - 卧式 - DX - 后回风</div>
    <div class="col-lg-12 text-center">
      <a href="<%=path %>/home/homedetail" target ="_blank" class="btn btn-info">查看详情&nbsp;<i class="fa fa-long-arrow-right fa-fw"> </i></a>
    </div>
 </div>
 </div>
</div>
</div>
<!---->
<!---->
<div class="col-lg-2 dataitemcont">
<div class="dataitemouter">
 <div class="dataItem">
 <div class="row">
    <div class="col-lg-12 dataimg">
      <img src="<%=path %>/images/mximg1.png">
    </div>
 </div>
 <div class="row">
    <div class="col-lg-12 dataItemTxtsmall">带回风箱的风机盘管机组 - 卧式 - DX - 后回风</div>
    <div class="col-lg-12 text-center">
      <a href="<%=path %>/home/homedetail" target ="_blank" class="btn btn-info">查看详情&nbsp;<i class="fa fa-long-arrow-right fa-fw"> </i></a>
    </div>
 </div>
 </div>
</div>
</div>
<!---->
<!---->
<div class="col-lg-2 dataitemcont">
<div class="dataitemouter">
 <div class="dataItem">
 <div class="row">
    <div class="col-lg-12 dataimg">
      <img src="<%=path %>/images/mximg1.png">
    </div>
 </div>
 <div class="row">
    <div class="col-lg-12 dataItemTxtsmall">带回风箱的风机盘管机组 - 卧式 - DX - 后回风</div>
    <div class="col-lg-12 text-center">
      <a href="<%=path %>/home/homedetail" target ="_blank" class="btn btn-info">查看详情&nbsp;<i class="fa fa-long-arrow-right fa-fw"> </i></a>
    </div>
 </div>
 </div>
</div>
</div>
<!---->
<!---->
<div class="col-lg-2 dataitemcont">
<div class="dataitemouter">
 <div class="dataItem">
 <div class="row">
    <div class="col-lg-12 dataimg">
      <img src="<%=path %>/images/mximg1.png">
    </div>
 </div>
 <div class="row">
    <div class="col-lg-12 dataItemTxtsmall">带回风箱的风机盘管机组 - 卧式 - DX - 后回风</div>
    <div class="col-lg-12 text-center">
      <a href="<%=path %>/home/homedetail" target ="_blank" class="btn btn-info">查看详情&nbsp;<i class="fa fa-long-arrow-right fa-fw"> </i></a>
    </div>
 </div>
 </div>
</div>
</div>
<!---->
<!---->
<div class="col-lg-2 dataitemcont">
<div class="dataitemouter">
 <div class="dataItem">
 <div class="row">
    <div class="col-lg-12 dataimg">
      <img src="<%=path %>/images/mximg1.png">
    </div>
 </div>
 <div class="row">
    <div class="col-lg-12 dataItemTxtsmall">带回风箱的风机盘管机组 - 卧式 - DX - 后回风</div>
    <div class="col-lg-12 text-center">
      <a href="<%=path %>/home/homedetail" target ="_blank" class="btn btn-info">查看详情&nbsp;<i class="fa fa-long-arrow-right fa-fw"> </i></a>
    </div>
 </div>
 </div>
</div>
</div>
<!---->
<!---->
<div class="col-lg-2 dataitemcont">
<div class="dataitemouter">
 <div class="dataItem">
 <div class="row">
    <div class="col-lg-12 dataimg">
      <img src="<%=path %>/images/mximg1.png">
    </div>
 </div>
 <div class="row">
    <div class="col-lg-12 dataItemTxtsmall">带回风箱的风机盘管机组 - 卧式 - DX - 后回风</div>
    <div class="col-lg-12 text-center">
      <a href="<%=path %>/home/homedetail" target ="_blank" class="btn btn-info">查看详情&nbsp;<i class="fa fa-long-arrow-right fa-fw"> </i></a>
    </div>
 </div>
 </div>
</div>
</div>
<!---->
<div class="col-lg-12">
<div class="pagebox">
    <a class="prev disable hide" href="javascript:;"><i class="fa fa-angle-left"></i></a>
    <a href="javascript:;" class="page-item  pageactive">1</a>
    <a href="javascript:;" class="page-item ">2</a>
    <a href="javascript:;" class="page-item ">3</a>
    <a href="javascript:;" class="page-item ">4</a>
    <a href="javascript:;" class="page-item ">5</a>
    <span>...</span>
    <a href="javascript:;">7</a>
    <a class="next" href="javascript:;">&nbsp;<i class="fa fa-angle-right"></i></a>
    </div>
</div>
</div>
</div>
</div>

<footer>
<div class="container">
  <div class="row">
    <div class="col-lg-12">
      北京市保障性住房建设投资中心
    </div>
  </div>
</div>
</footer>

</body>
</html>