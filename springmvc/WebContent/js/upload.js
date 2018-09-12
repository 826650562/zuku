/**
 * 上传页面
 */

$(function(){
  //渲染父类类型
  function getParentTypeToo(){
	  $.ajax({
			type : "POST",
			url :  window.path+"/home/questParentType",
			async : false,
			cache : false,
			contentType : "application/x-www-form-urlencoded",
			success : function(data) {
				var res = JSON.parse(data);
				for(var i =0;i<res.length;i++){
					$(".parent-menu"). append("<li><a _id="+res[i].ID+" class='ptcgJsItem'>"+ res[i]. CLASS_NAME +"</a></li>");
				}
			},
			error : function(data) {
				console.log("error:" + data.responseText);
			}
		});

  }
  
  function getChildTypeToo(){
	  $(".parent-menu").unbind().click(function(){
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
					$('.firstchild-menu').html('');
					var res = JSON.parse(data);
					console.log(res);
					for(var i =0;i<res[0].length;i++){
						$(".firstchild-menu"). append("<li><a _id="+res[i].ID+" class='ptcgJsItem'>"+ res[i]. CLASS_NAME +"</a></li>");
					}
//				 	for(var j in res[1]){
//						if(j){
//						$(".Cchild").each(function(index,item){
//							var child_id=$(item).attr("child_id");
//							if(child_id==j){
//								var len = res[1][j].length-1;
//								res[1][j].map(function(citem,index){
//									$(item).append("<span class='fenleidetail'><a href='#'>"+citem.CLASS_NAME+"</a></span>");
//								})
//							}
//						});	
//						}
//					}  
					
				},
				error : function(data) {
					console.log("error:" + data.responseText);
				}
			});
		 
		  $("#firstChildType").css({'display': 'block'});	  
	  })
  
  }
  
  /*渲染子类及孙类数据*/
  getParentTypeToo(); //获取父类
  getChildTypeToo();//获取崽崽和孙子类
	
})