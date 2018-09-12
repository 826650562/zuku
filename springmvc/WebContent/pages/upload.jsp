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
<script type="text/javascript" src="<%=path %>/js/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=path %>/js/upload.js"></script>

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
	margin: 10% auto;
    width: 1096px;
}
}

</style>
</head>
<body>








<div class="container-fluid">
	<div class="container">
		<input type="file">
		<div class="upload-icon"><i class="fa fa-cloud-upload text-center" aria-hidden="true"></i></div>
		<div class="menu-container">
			<div class="btnGroup">
			  <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
			    请选择父类构件（例如：建筑）
			    <span class="caret"></span>
			  </a>
			  <ul class="dropdown-menu parent-menu">
			  </ul>
			</div>
			<div class="btnGroup">
				  <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
				    请选择子类构件（例如：墙）
				    <span class="caret"></span>
				  </a>
				  <ul class="dropdown-menu firstchild-menu">
				  </ul>
			</div>
			<div class="btnGroup">
				  <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
				    请选择子类构件（例如：建筑墙）
				    <span class="caret"></span>
				  </a>
				  <ul class="dropdown-menu secondchild-menu">
				  </ul>
			</div>
		</div>
		<button class="btn btn-style" type="button">上传族库构件</button>
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