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
<link href="<%=basePath%>js/bootstrap/css/bootstrap.css"
	rel="stylesheet" type="text/css">
<link href="<%=basePath%>css/uploadStyle.css" rel="stylesheet"
	type="text/css">
<link href="<%=basePath%>js/layui/css/layui.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>css/font-awesome-4.7.0/css/font-awesome.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<%=basePath%>js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/layui/layui.js"></script>
<script type="text/javascript"
	src="<%=basePath%>js/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/upload.js"></script>
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<style type="text/css">
@media ( min-width : 1200px) {
	.container {
		width: 1096px;
	}
}
</style>
</head>
<body>
	<div id="myApp" v-cloak>
		<div class="container-fluid pcnavbar">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="logo">
							<a href="cgj.html"><img src="<%=basePath %>images/logo.png"></a>
						</div>
						<div class="dlzc">
							<div class="z-row">
								<div class="topss">
									<a href="#" class="searchbtn"><i class="fa fa-search fa-fw">
									</i></a> <input placeholder="关键词搜索" type="text" />
								</div>
								<div class="z-col">
									<a href="#" class="btn btn-success btn-sm">登录</a>
								</div>
								<div class="z-col">
									<a href="#" class="btn btn-default btn-sm">注册</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="container-fluid">
			<div class="container">
				<div class="gjldbox">
					<form role="form">
						<div class="z-row">
							<div class="z-col">
								<select id="firstSelect" class="form-control"
									@change="firstTypeChange($event.target.value)">
									<option>请选择父类构件（例如：建筑）</option>
									<option v-for="i in firstTypeMenuList" :value=i.ID>{{i.CLASS_NAME}}</option>
								</select>
							</div>
							<div class="width15"></div>
							<div class="z-col">
								<select id="secondSelect" class="form-control"
									@change="secondTypeChange($event.target.value)">
									<option>请选择子类构件（例如：墙）</option>
									<option v-for="i in secondTypeMenuList" :value=i.ID>{{i.CLASS_NAME}}</option>
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="szlbox">
					<div class="z-row zlbtitle">
						<div class="z-col zlbtitlename">{{secondChoosed}}</div>
						<div v-show="delBtn">
							<button @click="delThirdType" class="btn btn-danger btnnewzl">删除分类</button>
						</div>
						<div class="z-col">
							<input type="text" class="form-control" id=addThirdType
								placeholder="请输入名称">
						</div>
						<div>
							<button @click="addThirdType" class="btn btnnewzl">添加分类</button>
						</div>
					</div>

					<div class="z-row">
						<div class="z-col padTB10">
							<span @click="chooseThirdType($event,i.ID)"
								class="fenleidetail thirdTypeList" v-for="i in thirdTypeMenuList" :value=i.ID>{{i.CLASS_NAME}}</span>
						</div>
					</div>
					<div class="z-row togglebtnbox">
						<div class="z-col">
							<a class="btn btn-default togglebtn">点击展开<i
								class="fa fa-caret-down fa-fw"> </i></a>
						</div>
					</div>
					<!------切换按钮------>
				</div>
				<div class="z-row marB15">
					<div class="slt">
						<div class="z-row">
							<div class="z-col">
								<div class="sltimgbox">
									<img src="<%=basePath%>images/mximg1.png">
								</div>
							</div>
						</div>
						<div class="z-row">
							<div class="z-col">
								<div class="z-row">
									<div class="z-col">
										<button type="button"
											class="btn btn-default width100 borderradius0" id="test6">
											<i class="layui-icon"></i>上传图片
										</button>
									</div>
									<div class="z-col">
										<button type="button"
											class="btn btn-default width100 borderradius0" id="test7">
											<i class="layui-icon"></i>上传构件
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="z-col gjxxsrbox">
						<div class="z-row marB15">
							<div class="gjmcbt">构件名称：</div>
							<div class="z-col">
								<input type="text" class="form-control" id="detailName"
									placeholder="请输入">
							</div>
						</div>
						<div class="z-row">
							<div class="gjmcbt">构件revit版本：</div>
							<div class="z-col">
								<input type="text" class="form-control" id="detailVersion"
									placeholder="请输入">
							</div>
							<div class="gjmcbt">构件标签：</div>
							<div class="z-col">
								<input type="text" class="form-control" id="detailTag"
									placeholder="请输入">
							</div>
						</div>
					</div>

				</div>

				<div class="z-row">
					<div class="z-col"></div>
					<div>
						<button @click="sendDetail" class="btn btn-success">保存</button>
					</div>
					<div class="z-col"></div>
				</div>

			</div>
		</div>

		<footer>
			<div class="container">
				<div class="row">
					<div class="col-lg-12">北京市保障性住房建设投资中心</div>
				</div>
			</div>
		</footer>
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.17/dist/vue.js"></script>
<script>
	layui.use([ 'form', 'upload','jquery' ], function() {
		var form = layui.form,
			upload = layui.upload,
			$ = layui.jquery;

		//设定文件大小限制
		upload.render({
			elem : '#test6',
			url : '../myUpload/uploadIMGfile',
			done: function(res, index){ //上传后的回调
  				if(res.success){
  					$('.sltimgbox img').attr('src','<%=basePath%>rfa-img/'+res.imgName);
  					var data = {
  						imgName:res.imgName
  					}
  					window.dispatchEvent(
  						new CustomEvent('imgName',{'detail':data})
  					)
  				}else if(res.error){
  					alert(res.error);
  				}
  			},
		  	accept: 'images', //允许上传的文件类型
		  	size: 51200 //最大允许上传的文件大小
		});

		//设定文件大小限制
		upload.render({
			elem : '#test7',
			url : '../myUpload/uploadIMGfile',
			done: function(res, index){ //上传后的回调
  				if(res.success){
  					var data = {
  						rfaName:res.rfaName,
  						sizeKb:res.sizeKb
  					}
  					window.dispatchEvent(
  						new CustomEvent('rfaName',{'detail':data})
  					)
  				}else if(res.error){
  					alert(res.error);
  				}
  			},
		  	accept: 'file', //允许上传的文件类型
		  	size: 51200 //最大允许上传的文件大小
		});
		
		$('.borderradius0').click(function(){
			$('.borderradius0').removeClass('btn-success');
			$(this).addClass('btn-success');
		})

	});
</script>
</html>