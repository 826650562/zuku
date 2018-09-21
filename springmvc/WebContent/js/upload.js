/**
 * 上传页面
 */

$(function(){
  //渲染父类类型
  function getParentTypeToo(){
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
					$(".parent-menu"). append("<li><a _id="+res[i].ID+" class='parentContent'>"+ res[i]. CLASS_NAME +"</a></li>");
				}
			},
			error : function(data) {
				console.log("error:" + data.responseText);
			}
		});

  }
   
  function getfirstChildTypeToo(){
	  $(".parentContent").unbind().click(function(){
		  $('.parenttitle').text($(this).text());
		  var id = $(this).attr("_id");
		  $.ajax({
				type : "POST",
				url :  window.path+"/home/questTypeById",
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
					
					for(var i=0;i<res.length;i++){
						$(".firstchild-menu"). append("<li><a class='firstchild' fchild_id="+res[i].ID+">"+ res[i]. CLASS_NAME +"</a></li>");
					}
					
					$('.firstchild').unbind().click(function(){
						$('.firstchildtitle').text($(this).text());
						var id = $(this).attr("fchild_id");
						  $.ajax({
								type : "POST",
								url :  window.path+"/home/questTypeById",
								async : false,
								cache : false,
								data : {
									_id : id
								}, 
								contentType : "application/x-www-form-urlencoded",
								success : function(data) {
									var res = JSON.parse(data);
									console.log(res);
									for(var i =0;i<res.length;i++){
										$(".secondchild-menu"). append("<li><a schild_id="+res[i].ID+" class='secondchild'>"+ res[i]. CLASS_NAME +"</a></li>");
									}
									
									$('.secondchild').unbind().click(function(){
										$('.secondchildtitle').text($(this).text());
									})
								},
								error : function(data) {
									console.log("error:" + data.responseText);
								}
							});
					})			
				},
				error : function(data) {
					console.log("error:" + data.responseText);
				}
			});  
	  })
  
  }
  
function uploadIMGfiles(){
	  var formData = new FormData();
	  formData.append('imgfile',$('#imgfile')[0].files[0]);
	  formData.append('rfafile',$('#file')[0].files[0]);
	  $.ajax({
		  url: window.path+"/myUpload/uploadIMGfile",  
	      type: 'POST',
	      cache: false,
	      data: formData,
	      processData: false,
	      contentType: false
	  }).done(function(res) {}).fail(function(res) {});
  }
function uploadBaseInfo(){
	  $("#uploadINFO").click(function(){
		  /*if($('.control-label').val()!="" && $('.control-label').val()!= undefined){
			  
		  }*/
		  $.ajax({
			  url: window.path+"/myUpload/questFORM",
		      type: 'POST',
		      cache: false,
		      data: {
		    	  _name:$("#inputNAME").val(),
		    	  _version:$("#inputVERSION").val(),
		    	  _sign:$("#inputSIGN").val(),
		      },
		      success:function(res){
		    	  if(res=='uploadSuccess'){
		    		  uploadIMGfiles();
		    	  }
		      },
		      error:function(e){
		    	  
		      }
		  }) 
	  }) 	  
}

  
  /*渲染子类及孙类数据*/
  getParentTypeToo(); //获取父类
  getfirstChildTypeToo();//获取崽崽和孙子	
  uploadBaseInfo();/*上传构件的信息*/
  //上传其他
  
})