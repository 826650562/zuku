/**
 * 上传页面
 */

$(function() {
	window.addEventListener('imgName',function(e){
		vm.imgName = e.detail.imgName;
	});
	window.addEventListener('rfaName',function(e){
		vm.rfaName = e.detail.rfaName;
		vm.sizeKb = e.detail.sizeKb;
	});
	var vm = new Vue({
		el:'#myApp',
		data:{
			firstTypeMenuList:[],
			secondTypeMenuList:[],
			thirdTypeMenuList:[],
			secondChoosed:'第二级类别名称',
			firstChoosedId:'',
			secondChoosedId:'',
			thirdChoosedId:'',
			delBtn:false,
			imgName:'',
			rfaName:'',
			sizeKb:''
		},
		methods:{
			//第一级菜单选中改变事件
			firstTypeChange(id){
				this.firstChoosedId = id;
				this.secondTypeMenuLsit = [];
				this.thirdTypeMenuLsit = [];
				$.ajax({
					type : "POST",
					url : "questTypeById",
					async : false,
					cache : false,
					data : {
						_id : id
					},
					contentType : "application/x-www-form-urlencoded",
					success : function(data) {
						var res = JSON.parse(data);
						vm.secondTypeMenuList = res;
					},
					error : function(data) {
						console.log("error:" + data.responseText);
					}
				});		
			},
			//第二级菜单选中改变事件
			secondTypeChange(id){
				this.secondChoosed = $("#secondSelect option:selected").text();//获取第二级选中类别名称
				this.secondChoosedId = id;
				this.thirdTypeMenuLsit = [];
				$('.fleidActive').removeClass('fleidActive');
				vm.delBtn = false;
				$.ajax({
					type : "POST",
					url :"questTypeById",
					async : false,
					cache : false,
					data : {
						_id : id
					},
					contentType : "application/x-www-form-urlencoded",
					success : function(data) {
						var res = JSON.parse(data);
						vm.thirdTypeMenuList = res;
					},
					error : function(data) {
						console.log("error:" + data.responseText);
					}
				});
			},
			chooseThirdType(el,id){				
				if($(el.target).hasClass('fleidActive')){
					$(el.target).removeClass('fleidActive');
					this.delBtn = false;
				}else{
					$('.thirdTypeList').removeClass('fleidActive');
					$(el.target).addClass('fleidActive');
					this.delBtn = true;
				}
				this.thirdChoosedId = id;
			},
			delThirdType(){
				if(this.thirdChoosedId){
					this.delBtn = false;
					$.ajax({
						url:'../myUpload/delThirdType',
						data:{
							typeId:vm.thirdChoosedId
						},
						type:"POST",
						dataType:'JSON',
						success:function(res){
							if(res.success){
								alert(res.success);
							}else if(res.error){
								alert(res.error);
							}
							vm.secondTypeChange(vm.secondChoosedId);
						},
						error:function(res){
							console.log(res);
						}
					})
				}
			},
			addThirdType(){
				$.ajax({
					url: '../myUpload/setThirdType',
					data:{
						parentId:vm.secondChoosedId,
						type:$('#addThirdType').val()
					},
					dataType:'JSON',
					type:'POST',
					success:function(res){
						if(res.success){
							vm.secondTypeChange(vm.secondChoosedId);
							alert(res.success);							
						}else if(res.error){
							alert(res.error);
						}
					},
					error:function(res){
						console.log(res);					
					}
				})
			},
			sendDetail(){
				if(this.firstChoosedId&&this.secondChoosedId&&this.thirdChoosedId&&this.imgName&&this.rfaName&&this.sizeKb){
					$.ajax({
						url : "../myUpload/questFORM",
						type : 'POST',
						cache : false,
						data : {
							_name : $("#detailName").val(),
							_version : $("#detailVersion").val(),
							_sign : $("#detailTag").val(),
							thirdTypeId : vm.thirdChoosedId,
							rfaName:vm.rfaName,
							imgName:vm.imgName,
							sizeKb:vm.sizeKb,
							firstTypeId:vm.firstChoosedId,
							secondTypeId:vm.secondChoosedId
						},
						dataType:'JSON',
						success : function(res) {
							if (res.uploadSuccess) {
								alert(res.uploadSuccess);
							}else if(res.uploadError){
								alert(res.uploadError);
							}
						},
						error : function(e) {
							console.log(e);
						}
					})
				}else if(!this.firstChoosedId){
					alert('请选择一级分类!');
				}else if(!this.secondChoosedId){
					alert('请选择二级分类!');
				}else if(!this.thirdChoosedId){
					alert('请选择三级分类!');
				}else if(!this.imgName){
					alert('请上传缩略图!');
				}else if(!this.rfaName){
					alert('请上传rfa文件!');
				}else if(!$("#detailName").val()){
					alert('请填写构件名称!');
				}else if(!$("#detailVersion").val()){
					alert('请填写构件revit版本!');
				}else if(!$("#detailTag").val()){
					alert('请填写构件标签!');
				}
			}
		}
	})
	//获取第一级分类列表
	function getParentTypeToo() {
		$.ajax({
			type : "POST",
			url : "questTypeById",


/*$(function() {
	var getId;
	var GrandparentId;
	var GreatgrandparentId;
	//渲染父类类型
	function getParentTypeToo() {
		$.ajax({
			type : "POST",
			url : window.path + "/home/questTypeById",*/

			async : false,
			cache : false,
			data : {
				_id : 0
			},
			contentType : "application/x-www-form-urlencoded",
			success : function(data) {
				var res = JSON.parse(data);

				vm.firstTypeMenuList = res;
				/*for (var i = 0; i < res.length; i++) {
					$(".parent-menu").append("<li><a _id=" + res[i].ID + " class='parentContent'>" + res[i].CLASS_NAME + "</a></li>");
					$(".parent-menu2").append("<li><a _id=" + res[i].ID + " class='parentContent2'>" + res[i].CLASS_NAME + "</a></li>");
				}*/	

				for (var i = 0; i < res.length; i++) {
					$(".parent-menu").append("<li><a _id=" + res[i].ID + " class='parentContent'>" + res[i].CLASS_NAME + "</a></li>");
					$(".parent-menu2").append("<li><a _id=" + res[i].ID + " class='parentContent2'>" + res[i].CLASS_NAME + "</a></li>");
				}				

			},
			error : function(data) {
				console.log("error:" + data.responseText);
			}
		});
	}

	getParentTypeToo(); //获取第一级分类列表


	function getfirstChildTypeToo() {
		$(".parentContent").unbind().click(function() {
			$('.parenttitle').text($(this).text());
			var id = $(this).attr("_id");
			GreatgrandparentId = $(this).attr("_id");
			setFirstChildMenu(id,'');
			
		})
		$(".parentContent2").unbind().click(function() {
			$('.parenttitle2').text($(this).text());
			var id = $(this).attr("_id");
			GreatgrandparentId = $(this).attr("_id");
			setFirstChildMenu(id,'2');			
		})
	}
	//获取第二级分类列表
	function setFirstChildMenu(id,el){
		$.ajax({
			type : "POST",
			url : window.path + "/home/questTypeById",
			async : false,
			cache : false,
			data : {
				_id : id
			},
			contentType : "application/x-www-form-urlencoded",
			success : function(data) {
				$(".firstchild-menu"+el).html('');
				var res = JSON.parse(data);
				for (var i = 0; i < res.length; i++) {
					$(".firstchild-menu"+el).append("<li><a class='firstchild"+ el +"' fchild_id=" + res[i].ID + ">" + res[i].CLASS_NAME + "</a></li>");
				}
				getSecondTypeToo();
			},
			error : function(data) {
				console.log("error:" + data.responseText);
			}
		});		
	}
	//第二级类表点击事件
	function  getSecondTypeToo(){
		$('.firstchild').unbind().click(function() {
			$('.firstchildtitle').text($(this).text());
			var id = $(this).attr("fchild_id");
			GrandparentId = $(this).attr("fchild_id");
			setThirdTypeMenu(id,'')
		})	
		$('.firstchild2').unbind().click(function() {
			$('.firstchildtitle2').text($(this).text());
			var id = $(this).attr("fchild_id");
			parentId = $(this).attr("fchild_id");
			GrandparentId = $(this).attr("fchild_id");
			setThirdTypeMenu(id,"2")
		})
	}
	
	//获取第三级分类列表
	function setThirdTypeMenu(id,el){
		$.ajax({
			type : "POST",
			url : window.path + "/home/questTypeById",
			async : false,
			cache : false,
			data : {
				_id : id
			},
			contentType : "application/x-www-form-urlencoded",
			success : function(data) {
				var res = JSON.parse(data);
				console.log(res);
				$(".secondchild-menu"+el).html('');
				for (var i = 0; i < res.length; i++) {
					$(".secondchild-menu"+el).append("<li><a schild_id=" + res[i].ID + " class='secondchild"+ el +"'>" + res[i].CLASS_NAME + "</a></li>");
				}
				if(el!=''){
					$(".secondchild-menu"+el).append("<li><a schild_id='setCustom' id='setCustom'  data-toggle='modal' data-target='#myModal'> 添加自定义 </a></li>");
				}
				//第三级列表点击事件
				$('.secondchild'+ el +'').unbind().click(function() {
					if(el==''){
						getId = $(this).attr('schild_id');	
					}			
					$(this).parents('.secondchildmenu').find('.secondchildtitle').text($(this).text());
				});
			},
			error : function(data) {
				console.log("error:" + data.responseText);
			}
		});		
	}
	//上传文件
	function uploadIMGfiles() {
		var formData = new FormData();
		formData.append('imgfile', $('#imgfile')[0].files[0]);
		formData.append('rfafile', $('#file')[0].files[0]);
		$.ajax({
			url : window.path + "/myUpload/uploadIMGfile",
			type : 'POST',
			cache : false,
			data : formData,
			processData : false,
			contentType : false,
			dataType:'JSON',
			success:function(res) {
				if(res=='uploadSuccess'){
					alert("上传成功！");
				}
			},
			error:function(res) {console.log('e'+res)}
		});
	}
	//数据参数
	function uploadBaseInfo() {
		$("#uploadINFO").click(function() {
			if (getId) {
				$.ajax({
					url : window.path + "/myUpload/questFORM",
					type : 'POST',
					cache : false,
					data : {
						_name : $("#inputNAME").val(),
						_version : $("#inputVERSION").val(),
						_sign : $("#inputSIGN").val(),
						_getId : getId,
						_GrandparentId : GrandparentId,
						_GreatgrandparentId : GreatgrandparentId
						
					},
					success : function(res) {
						if (res == 'uploadSuccess') {
							uploadIMGfiles();
						}
					},
					error : function(e) {
						console.log(e);
					}
				})
			}
		})
	}
	//第三级类别添加自定按钮事件
	$('#subThirdType').unbind().click(function(){
		if($('#addThirdType').val()){
			$.ajax({
				url: window.path + '/myUpload/setThirdType',
				data:{
					parentId:parentId,
					type:$('#addThirdType').val()
				},
				dataType:'JSON',
				type:'POST',
				success:function(res){
					if(res.success){
						alert(res.success);
						setThirdTypeMenu(parentId,"2");
					}
				},
				error:function(res){
					console.log(res);					
				}
			})
		}
	})
	/*渲染子类及孙类数据*/
	getParentTypeToo(); //获取父类
	getfirstChildTypeToo(); //获取崽崽和孙子	
	uploadBaseInfo(); /*上传构件的信息*/
	//上传其他
})