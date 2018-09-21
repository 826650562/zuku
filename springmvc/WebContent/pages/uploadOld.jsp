<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="<%=basePath%>images/ico.png" type="image/x-icon">
<title>族库</title>
<link href="<%=path%>/js/bootstrap/css/bootstrap.css" rel="stylesheet"
	type="text/css">
<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/font-awesome-4.7.0/css/font-awesome.css"
	rel="stylesheet" type="text/css" />
<script>
	window.path = "<%=path%>"
</script>
<script src="<%=path%>/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script type="text/javascript"
	src="<%=path%>/js/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=path%>/js/upload.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<style type="text/css">
@media ( min-width : 1200px) {
	.container {
		margin: 7% auto;
		width: 1096px;
	}
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="container">
			<div class="upload-icon">
				<i class="fa fa-cloud-upload text-center" aria-hidden="true"></i>
			</div>
			<div class="typeUpload" style="width:100%">
				<div class="btnGroup">
					<a class="btn dropdown-toggle parenttitle2" data-toggle="dropdown"
						href="#"> 请选择父类构件（例如：建筑） <span class="caret"></span>
					</a>
					<ul class="dropdown-menu parent-menu2">
					</ul>
				</div>
				<div class="btnGroup">
					<a class="btn dropdown-toggle firstchildtitle2"
						data-toggle="dropdown" href="#"> 请选择子类构件（例如：墙） <span
						class="caret"></span>
					</a>
					<ul class="dropdown-menu firstchild-menu2">
					</ul>
				</div>
				<div class="btnGroup secondchildmenu">
					<a class="btn dropdown-toggle secondchildtitle"
						data-toggle="dropdown" href="#"> 请选择子类构件（例如：建筑墙） <span
						class="caret"></span>
					</a>
					<ul class="dropdown-menu secondchild-menu2">
					</ul>
				</div>
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				    <div class="modal-dialog">
				        <div class="modal-content">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				                <h4 class="modal-title" id="myModalLabel">添加自定义分类名称</h4>
				            </div>
				            <div class="modal-body"><input id="addThirdType" placeholder="分类名称"></div>
				            <div class="modal-footer">
				                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				                <button type="button" class="btn btn-primary" data-dismiss="modal" id="subThirdType">提交更改</button>
				            </div>
				        </div><!-- /.modal-content -->
				    </div><!-- /.modal -->
				</div>
			</div>
			<div class="menu-container">
				<div class="btnGroup">
					<a class="btn dropdown-toggle parenttitle" data-toggle="dropdown"
						href="#"> 请选择父类构件（例如：建筑） <span class="caret"></span>
					</a>
					<ul class="dropdown-menu parent-menu">
					</ul>
				</div>
				<div class="btnGroup">
					<a class="btn dropdown-toggle firstchildtitle"
						data-toggle="dropdown" href="#"> 请选择子类构件（例如：墙） <span
						class="caret"></span>
					</a>
					<ul class="dropdown-menu firstchild-menu">
					</ul>
				</div>
				<div class="btnGroup secondchildmenu">
					<a class="btn dropdown-toggle secondchildtitle"
						data-toggle="dropdown" href="#"> 请选择子类构件（例如：建筑墙） <span
						class="caret"></span>
					</a>
					<ul class="dropdown-menu secondchild-menu">
					</ul>
				</div>
				<!-- 上传略缩图 -->
				<div class="btnGroup">
					<div id="uploadIMGForm">
						<label for="file">上传缩略图:</label><input type="file" name="imgfile"
							id="imgfile" class="inputfile" />
					</div>

					<div class="btnGroup">
						<div id="uploadForm">
							<label for="file">上传rfa文件:</label><input id="file" type="file" />
						</div>
					</div>

					<!--   上传基本信息 -->
					<form class="form-horizontal">

						<div class="control-group">
							<label class="control-label" for="inputNAME">构件名称</label>
							<div class="controls">
								<input type="text" id="inputNAME" placeholder="NAME"
									name="inputNAME">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputVERSION">构件Revit版本</label>
							<div class="controls">
								<input type="text" id="inputVERSION" placeholder="VERSION"
									name="inputVERSION">
							</div>
						</div>

						<!-- <div class="control-group">
				    <label class="control-label" for="inputCLASSIFY">构件分类</label>
				    <div class="controls">
				      <input type="text" id="inputCLASSIFY" placeholder="CLASSIFY" name="inputCLASSIFY">
				    </div>
				  </div> -->

						<div class="control-group">
							<label class="control-label" for="inputSIGN">构件标签</label>
							<div class="controls">
								<input type="text" id="inputSIGN" placeholder="SIGN"
									name="inputSIGN">
							</div>
						</div>
						<button type="button" class="btn" id="uploadINFO">提交构件信息</button>
						<!-- <div class="control-group">
				    <div class="controls">
				      <button type="button" class="btn" id="uploadINFO" >提交构件信息</button>
				    </div>
				  </div> -->
					</form>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<div>
			<div class="row">
				<div class="col-lg-12">北京市保障性住房建设投资中心</div>
			</div>
		</div>
	</footer>
</body>
</html>