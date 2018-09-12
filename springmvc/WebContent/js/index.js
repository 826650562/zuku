$(function(){
  //渲染父类类型
  function getParentType(){
	  $.ajax({
			type : "POST",
			url :  window.path+"/home/questParentType",
			async : false,
			cache : false,
		/*	data : {
				_id : tag_id
			},*/
			contentType : "application/x-www-form-urlencoded",
			success : function(data) {
				var res = JSON.parse(data);
//				var parentTypeName = [];
				for(var i =0;i<res.length;i++){
					$(".parentType"). append("<a _id="+res[i].ID+" class='ptcgJsItem'>"+ res[i]. CLASS_NAME +"</a>");
				}
//				$(".parentType"). append("<a class='ptcgJsItem'>"+ res +"</a>");
			},
			error : function(data) {
				console.log("error:" + data.responseText);
			}
		});

  } 
  
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
						
					},
					error : function(data) {
						console.log("error:" + data.responseText);
					}
				});
			 
			  $("#firstChildType").css({'display': 'block'});
		  }
	  })
  }
  
  
  getParentType(); //获取父类
  parentClick(); //执行父类点击事件
	
})