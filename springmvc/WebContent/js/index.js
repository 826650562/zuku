$(function(){
  //渲染父类类型
  var  pageSize=18;
  function getParentType(){
	  $.ajax({
			type : "POST",
			url :  window.path+"/home/questTypeById",
			async : false,
			cache : false,
			data : {
				_id : 0
			},
			contentType : "application/x-www-form-urlencoded",
			success : function(data) {
				var res = JSON.parse(data);
				for(var i =0;i<res.length;i++){
					$(".parentType"). append("<a _id="+res[i].ID+" class='ptcgJsItem'>"+ res[i]. CLASS_NAME +"</a>");
				}
			},
			error : function(data) {
				console.log("error:" + data.responseText);
			}
		});

  } 
  
  //根据传来的结果 更新页面列表
  /*
   function updateListOfindex(res){
	   for(){
		   
	   }
   }*/
  
  // 父类点击事件
  function parentClick(){
	  $(".ptcgJsItem").unbind().click(function(){
		  //绿色框样式操作
		  //1.清楚所有的active
		  $(".ptcgJsItem").removeClass("ptcgJsItemActive");
		  $(this).addClass("ptcgJsItemActive");
		  
		  //当显示全部分类时，隐藏子分类的内容
		  if($(this).text()== "全部专业"){
			  $("#firstChildType").css({'display': 'none'});
			  showimglist();
		  }else{
			  var id = $(this).attr("_id");
			  $.ajax({
					type : "POST",
					url :  window.path+"/home/questchildType",
					async : false,
					cache : false,
				    data : {
						_id : id
					}, 
					contentType : "application/x-www-form-urlencoded",
					success : function(data) {
						$('.fenlei').html('');
						var res = JSON.parse(data);
						for(var i =0;i<res[0].length;i++){
						  $(".fenlei").append("<div class='z-row fenleiitem'> <div class='fenleititle' child_id="+res[0][i].ID+"><a href='javascript:;'>"+res[0][i].CLASS_NAME+"</a>&nbsp;></div> <div class='z-col Cchild' child_id="+res[0][i].ID+"> </div> </div>");   
						}
					 	for(var j in res[1]){
							if(j){
							$(".Cchild").each(function(index,item){
								var child_id=$(item).attr("child_id");
								if(child_id==j){
									var len = res[1][j].length-1;
									res[1][j].map(function(citem,index){
										$(item).append("<span class='fenleidetail' data-id="+citem.ID+"><a href='javascript:;'>"+citem.CLASS_NAME+"</a></span>");
									})
								}
							});	
							}
						}
					 	/*三级菜单点击事件*/
					 	$(".fenleidetail").unbind().click(function(){
					 		var id = $(this).attr("data-id");
					 		fenleiDetailClick(id);
						})
						
						/*二级菜单点击事件*/
						$(".fenleititle").unbind().click(function(){
					 		var id = $(this).attr("child_id");
					 		fenleiParentDetailClick(id);
						})
						
					},
					error : function(data) {
						console.log("error:" + data.responseText);
					}
				});
			 
			  $("#firstChildType").css({'display': 'block'});
		  }
	  })
  }
  
  //显示前端列表
  function showimglist(){

	//调取数据库中上传文件及内容
	 	/*$.ajax({
           type: "POST",
           url: window.path+"/home/getContent",
           dataType: "json",
           success: function(data){
        	   pageindexshow(data);
           }
       });*/
	   var  pageIndex=0;
  		//调取数据库中上传文件及内容
  		getPageRes(pageIndex,pageSize);
  		function getPageRes(pi,ps){
  		//根据 页码和每页数据 获取列表	
  			  $.ajax({
  		           type: "POST",
  		           url: window.path+"/home/getContent",
  		           dataType: "json",
  		           data:{
  		        	   _pageIndex:pi,
  		        	   _pageSize:ps
  		        	   
  		           },
  		           success: function(dataJson){
  		        	   console.log(dataJson);
  		        	  pageinationchange(dataJson[0]._total,pi,function(pi,ps){
  		        		   getPageRes(pi,ps);
  		        	   });
  		        	   //遍历结果  更新页码的构件列表 
  		        	   var data = dataJson[0].list;
  		        	   pageindexshow(data);
  		           }
  		   });
  		}

	  
	$('.ptcgJsItem').click(function(){
		var id = $(this).attr("_id");
		var  pageIndex=0;
		//调取数据库中上传文件及内容
		getPageRes(pageIndex,pageSize);
		function getPageRes(pi,ps){
		//根据 页码和每页数据 获取列表	
			  $.ajax({
		           type: "POST",
		           url: window.path+"/home/questTypeBygrandprentid",
		           dataType: "json",
		           data:{
		        	   _id : id,  
		        	   _pageIndex:pi,
		        	   _pageSize:ps
		        	   
		           },
		           success: function(dataJson){
		        	   pageinationchange(dataJson[0]._total,pi,function(pi,ps){
		        		   getPageRes(pi,ps);
		        	   });
		        	   //遍历结果  更新页码的构件列表 
		        	   var data = dataJson[0].list;
		        	   pageindexshow(data);
		           },
		           error : function(dataJson) {
		   			console.log("error:" + dataJson.responseText);
		   		}
		   });
		}
			
	})
	 	
  }
    
  /*二级菜单点击事件*/
	function fenleiParentDetailClick(id){
	$.ajax({
		type : "POST",
		url :  window.path+"/home/questTypeByPparentid",
		async : false,
		cache : false,
		data : {
			_id : id
		},
		
		contentType : "application/x-www-form-urlencoded",
		success : function(dataJson) {
			var data = JSON.parse(dataJson);
			pageindexshow(data);
		},
		error : function(data) {
			console.log("error:" + data.responseText);
		}
	});
}

	/*三级菜单点击事件*/
	function fenleiDetailClick(id){
	$.ajax({
		type : "POST",
		url :  window.path+"/home/questTypeByparentid",
		async : false,
		cache : false,
		data : {
			_id : id
		},
		contentType : "application/x-www-form-urlencoded",
		success : function(dataJson) {
			var data = JSON.parse(dataJson);
			pageindexshow(data);
		},
		error : function(dataJson) {
			console.log("error:" + dataJson.responseText);
		}
	});
}
	//首页列表公共代码
	function pageindexshow(data){
		$('#listBox').html('');
		for(var i =0;i<data.length;i++){
			var html = '<div class="col-lg-2 dataitemcont">'
				+'<div class="dataitemouter">'
			 +'<div class="dataItem">'
			 +'<div class="row">'
			    +'<div class="col-lg-12 dataimg">'
			      +'<img src="'+window.path+'/rfa-img/'+ data[i].SLT_PATH+'">'
			    +'</div>'
			 +'</div>'
			 +'<div class="row">'
			    +'<div class="col-lg-12 dataItemTxtsmall">'+ data[i].NAME +'</div>'
			    +'<div class="col-lg-12 text-center">'
			     +' <a class="btn btn-info rfadetail" data-id="'+data[i].ID+'">查看详情&nbsp;<i class="fa fa-long-arrow-right fa-fw"> </i></a>'
			    +'</div></div></div></div></div>'
			    $('#listBox').append(html);
			//点击详情，进入detail页面
			$('.rfadetail').unbind().click(function(){
				var id=$(this).attr('data-id');
	            window.location.href= window.path +'/home/homedetail?id='+id;
			})
		}
	}
	
  
  //实现首页分页功能
  function pageinationchange(_total,_pageIndex,callback){
      var demo1 = BootstrapPagination($("#pagination"), {
          //记录总数。
    	  total: _total,
          //当前页索引编号。从其开始（从0开始）的整数。
          pageIndex: _pageIndex,
          pageSize: pageSize,
          pageSizeList: [],
          //当分页更改后引发此事件。
          pageChanged: function (pageIndex, pageSize) {
        	  callback(pageIndex, pageSize);
          },
      });

  }
  
  
  
  getParentType(); //获取父类
  parentClick(); //执行父类点击事件
  showimglist(); //显示前端列表

})