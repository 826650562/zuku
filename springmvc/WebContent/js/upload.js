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
			},
			error : function(data) {
				console.log("error:" + data.responseText);
			}
		});
	}
	getParentTypeToo(); //获取第一级分类列表
})