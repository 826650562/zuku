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
<script src="<%=path %>/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path %>/js/bootstrap/js/bootstrap.min.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->   

<style type="text/css">

@media (min-width: 1200px)
{
.container {
    width: 1096px;
}
}

</style>
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






<div class="container-fluid ddailbox">
<div class="container">
<div class="row">
<div class="col-lg-12 zxgd">

<div class="z-row ddailmiaoshu">
  <div class="ddailbzimg"><img src="<%=path %>/images/data1detailimg1.png"></div>
  <div class="z-col padLR25">
     <div class="row">
       <div class="col-lg-12"><div class="ddailtitle">带回风箱的风机盘管机组 - 卧式 - DX - 后回风</div></div>
       <div class="col-lg-12">
           <div class="ddailtxtcont">
              <span>Revit版本：</span>2014<br/>
              <span>大小：</span>276.03KB<br/>
              <span>专业：</span>暖通<br/>
              <span>分类：</span>空气处理设备/风机盘管<br/>
              <span>标签：</span>
           </div>
         </div>
     </div>
  </div>
</div>

<div class="cgdtltabcont">


<ul id="myTab" class="nav nav-tabs">
    <li class="active"><a href="#wenxian" data-toggle="tab">族参数</a></li>
    <li><a href="#doc" data-toggle="tab">族详情</a></li>
</ul>
<div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="wenxian">
       <div class="ddailtxt">
         <h3>电气</h3>  
         <p>
            <form role="form">
                <div class="form-group">
                    <label for="name">选择列表</label>
                    <select class="form-control">
                        <option>564LPS</option>
                        <option>564LPS</option>
                        <option>564LPS</option>
                        <option>564LPS</option>
                        <option>564LPS</option>
                    </select>
                </div>
            </form>
         </p>
         
         
         
         
         <h3>电气</h3>  
         <p>
             <span>电压：</span><span>120.00 V</span><br/>
             <span>负荷分类：</span><span> </span><br/>
             <span>极数：</span><span> </span>
         </p>
       </div>
       
    </div>
    
    
    <div class="tab-pane fade" id="doc">
       <div class="ddailtxt">
             <h3>电气</h3>  
             <p>
                 <span>电压：</span><span>120.00 V</span><br/>
                 <span>负荷分类：</span><span> </span><br/>
                 <span>极数：</span><span> </span>
             </p>
       </div>
    </div>
    
</div>
<script>
    $(function(){
        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            // 获取已激活的标签页的名称
            var activeTab = $(e.target).text();
            // 获取前一个激活的标签页的名称
            var previousTab = $(e.relatedTarget).text();
            $(".active-tab span").html(activeTab);
            $(".previous-tab span").html(previousTab);
        });
    });
</script>


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