<!-- 公司相册页面 -->
<template>
	<view>
		
		<view class="card-box">
			<view class="outer-box">
				<view class="title-box-num">
					<text class="title-words" style="font-weight: bold;">添加公司照片</text>
					<text :class="{'num-words': companyPhotoList.length <= 10, 'num-words-red': companyPhotoList.length > 10}">（{{companyPhotoList.length}}/10）</text>
				</view>
				<view class="title-box">
					<text class="title-second">展现公司的各个方面与办公环境企业文化等，吸引更多优秀人才~</text>
				</view>
			</view>
		</view>
		
		<view class="photo-block">
			<view class="photo-box">
				<view class="photo-wrapper" v-for="(photo, index) in companyPhotoList" :key="index">
					<image :src="photo" class="photo-item"></image>
					<image src="../../../static/icons/company/delete.png" class="icon-delete" @click="removePhoto(index)"></image>
				</view>
				
				<view class="business-license-wrapper">
					<image src="../../../static/images/upload.png" class="upload-icon" @click="uploadPhoto()"></image>
					<text class="upload-words" @click="uploadPhoto()">添加照片</text>
				</view>
			</view>
		</view>
			
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				checked: 0,
				companyPhotoList: [
				],
			}
		},
		onNavigationBarButtonTap() {
			this.updatePhotos();
		},
		onShow() {
		},
		onLoad(options) {
			this.companyId = options.companyId;
			this.getCompanyPhotos(options.companyId);
		},
		methods: {
			getCompanyPhotos() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/getPhotos?companyId=" + companyId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var companyPhotos = result.data.data;
							var photosTemp = companyPhotos.photos.split(",");
							// console.log(photosTemp);
							
							var arr = [];
							for (var i = 0 ; i < photosTemp.length ; i ++) {
								arr.push(photosTemp[i])
							}
							// console.log(arr);
							me.companyPhotoList = me.companyPhotoList.concat(arr);
							
						} else {
							uni.showToast({
								title: result.data.msg,
								icon: "none",
								duration: 3000
							});
						}
						
					}
				})
				
			},
			
			updatePhotos() {
				var companyPhotoList = this.companyPhotoList;
				console.log(companyPhotoList)
				if (companyPhotoList.length <= 0) {
					uni.showToast({
						title: "企业相册不能为空",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var photos = "";
				
				for (var i = 0 ; i < companyPhotoList.length ; i ++) {
					photos += companyPhotoList[i];
					if (i != (companyPhotoList.length-1) ) {
						photos += ","
					}
				}
				
				// console.log(photos);
				
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var photos = photos;
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"photos": photos
				};
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/modify",
					data: pendingInfo,
					success(result) {
						
						if (result.data.status == 200) {
							
							uni.showToast({
								title: "修改成功~",
								duration: 2000,
								success() {
									uni.navigateBack({
										delta: 1,
										animationType: "fade-out"
									})
								}
							})
						} else {
							uni.showToast({
								title: result.data.msg,
								icon: "none",
								duration: 3000
							});
						}
						
					}
				})
			},
			
			removePhoto(index) {
				var companyPhotoList = this.companyPhotoList;
				for (var i = 0 ; i < companyPhotoList.length ; i ++) {
					if (i == index) {
						companyPhotoList.splice(i, 1);
						break;
					}
				}
				this.companyPhotoList = companyPhotoList;
			},
			
			uploadPhoto() {
				var me = this;
				var companyId = this.companyId;
				var userId = app.getUserInfoSession().id;
				// uni.showLoading();
				uni.chooseImage({
					count: 9,
					sizeType: ["compressed"],
					success: (e) => {
						// console.log(e);
						// var photo = e.tempFilePaths[0];
						// me.companyPhotoList.push(photo);
						
						var path = e.tempFilePaths;
						var pathArr = e.tempFiles
						// me.companyPhotoList = me.companyPhotoList.concat(path);
						
						let tempFiles = e.tempFiles; //获取选中的图片数组          
						let arr = [];    //定义一个空数组，用于存放待会发送给后端的数组，格式为arr=[{name:'image1',url:'图片路径'}，{name:'image2',url:'图片路径'}]          
						let i = 0;        //设置初始值，进行数组的循环遍历          
						for (var item of tempFiles) {            
							i++;            
							var obj = {};            
							obj.name = "files";   
							obj.file = item;
							obj.url = item.path;            
							arr.push(obj);  
						}
						// console.log(arr);
						
						// return;
						
						var serverUrl = app.globalData.serverUrl;
						uni.uploadFile({
							header: {
								headerUserId: userId,
								headerUserToken: app.getUserSessionToken()
							},
							url: serverUrl + "/file/uploadPhoto?companyId=" + companyId,
							name: "file",
							files: arr,
							// filePath: path,
							success(result) {
								console.log(result);
								
								if (result.statusCode == 200) {
									var res = JSON.parse(result.data);
									
									if (res.status = 200) {
										var photoArr = res.data;
										// me.companyLogo = photoArr;
										// console.log(photoArr);
										me.companyPhotoList = me.companyPhotoList.concat(photoArr);
										
										// uni.showToast({
										// 	title: "LOGO上传成功~",
										// 	duration: 1500
										// })
									} else {
										uni.showToast({
											title: res.msg,
											icon: 'error'
										})
									}
								} else {
									uni.showToast({
										title: "上传失败",
										icon: 'error'
									})
								}
								// uni.hideLoading();
							},
							fail(e) {
								console.log(e);
							}
						})
					}
				})
			}
			
		}
	}
</script>

<style>
	@import url("companyPhoto.css");
</style>
