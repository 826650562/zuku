$(function(){
  //渲染父类类型
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
  
  // 父类点击事件
  function parentClick(){
	  $(".ptcgJsItem").click(function(){
		  //绿色框样式操作
		  //1.清楚所有的active
		  $(".ptcgJsItem").removeClass("ptcgJsItemActive");
		  $(this).addClass("ptcgJsItemActive");
		  
		  //当显示全部分类时，隐藏子分类的内容
		  if($(this).text()== "全部专业"){
			  $("#firstChildType").css({'display': 'none'});
		  }else{
			  var id = $(this).attr("_id");
			  $.ajax({
					type : "POST",
					url :  window.path+"/home/questchildType",
					async : false,
					cache : false,
				    data : {
						_id : id //传出父类
					}, 
					contentType : "application/x-www-form-urlencoded",
					success : function(data) {
						$('.fenlei').html('');
						var res = JSON.parse(data);
						for(var i =0;i<res[0].length;i++){
						  $(".fenlei").append("<div class='z-row fenleiitem'> <div class='fenleititle' >"+res[0][i].CLASS_NAME+"&nbsp;></div> <div class='z-col Cchild' child_id="+res[0][i].ID+"> </div> </div>");   
						}
					 	for(var j in res[1]){
							if(j){
							$(".Cchild").each(function(index,item){
								var child_id=$(item).attr("child_id");
								if(child_id==j){
									var len = res[1][j].length-1;
									res[1][j].map(function(citem,index){
										$(item).append("<span class='fenleidetail'><a href='#'>"+citem.CLASS_NAME+"</a></span>");
									})
								}
							});	
							}
						}
					 	//调取数据库中上传文件及内容
					 	/*$.ajax({
				             type: "POST",
				             url: window.path+"/home/getContent",
				             dataType: "json",
				             success: function(data){
				                        console.log(data);
				                      }
				         });*/
						
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
	  
	$('.ptcgJsItem').click(function(){
		var id = $(this).attr("_id");
		console.log(id);
		//调取数据库中上传文件及内容
			  $.ajax({
		           type: "POST",
		           url: window.path+"/home/getContent",
		           dataType: "json",
		           data:{
		        	   _id : id, //传出父类
		        	   pageSize:20,
		           	   pageIndex:1
		           },
		           success: function(data){
								console.log(data);
								
								for(var i =0;i<data.length;i++){
									var html = '<div class="dataitemouter">'
										 
									    +'<div class="col-lg-12 dataimg">'
									      +'<img src="'+window.path+'/rfa-img/'+ data[i].SLT_PATH+'">'
									    +'</div>'

									    +'<div class="col-lg-12 dataItemTxtsmall">'+ data[i].NAME +'</div>'
									    +'<div class="col-lg-12 text-center">'
									      +'<a class="btn btn-info rfadetail" data-id="'+data[i].ID+'">查看详情&nbsp;<i class="fa fa-long-arrow-right fa-fw"> </i></a>'
									    +'</div>'

									+'</div>';
									$(".dataitemcont"). append(html);
									$('.rfadetail').unbind().click(function(){
										var id=$(this).attr('data-id');
							            window.location.href= window.path +'/home/homedetail?id='+id;
									})
								}
		                    }
		       });
	})
	 	
  }
  
  //实现首页分页功能
  function pageinationchange(){
	  $(function () {
	        var demo1 = BootstrapPagination($("#demo1"), {
	            //记录总数。
	            total: 101,
	            //当前页索引编号。从其开始（从0开始）的整数。
	            pageIndex: 0,
	            //当分页更改后引发此事件。
	            pageChanged: function (pageIndex, pageSize) {
	                /*alert("page changed. pageIndex:" + pageIndex + ",pageSize:" + pageSize)*/
	            	/*alert("page changed. pageIndex:" + pageIndex + ",pageSize:" + 15)*/
	            	$.ajax({
	    	            type: "POST",
	    	            url: window.path+"/home/getContent",
	    	            dataType: "json",
	    	            data: {
	    	            	pageSize:pageSize,
	    	            	pageIndex:Number(pageIndex)+1,
	    	            	
	    	            },
	    	            success: function(data){
	    	 						console.log(data);
	    	 						$(".dataitemcont").html('');
	    	 						for(var i =0;i<data.length;i++){
	    	 							var html = '<div class="dataitemouter">'
	    	 								 
	    	 							    +'<div class="col-lg-12 dataimg">'
	    	 							      +'<img src="'+window.path+'/rfa-img/'+ data[i].SLT_PATH+'">'
	    	 							    +'</div>'

	    	 							    +'<div class="col-lg-12 dataItemTxtsmall">'+ data[i].NAME +'</div>'
	    	 							    +'<div class="col-lg-12 text-center">'
	    	 							      +'<a class="btn btn-info rfadetail" data-id="'+data[i].ID+'">查看详情&nbsp;<i class="fa fa-long-arrow-right fa-fw"> </i></a>'
	    	 							    +'</div>'

	    	 							+'</div>';
	    	 							$(".dataitemcont"). append(html);
	    	 							$('.rfadetail').unbind().click(function(){
	    	 								var id=$(this).attr('data-id');
	    	 					            window.location.href= window.path +'/home/homedetail?id='+id;
	    	 							})
	    	 						}
	    	                     }
	    	        });
	            },
	        });
	        
	        
	    });
  }
  
  
  
  getParentType(); //获取父类
  parentClick(); //执行父类点击事件
  showimglist(); //显示前端列表
  pageinationchange(); //分页功能
	
})