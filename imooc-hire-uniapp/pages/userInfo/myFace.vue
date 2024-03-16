<!-- 上传头像页面 -->
<template>
	<view class="page">
		
		<view class="bg-wrapper">
			<image :src="faceUrl" class="bg-size" style="align-self: center;"></image>
			
			<view 
				class="button-change-bg"
				@click="changeFace()"
				style="width: 250rpx;height: 80rpx;border-radius: 50px;display: flex;flex-direction: column;justify-content: center;margin-top: 150rpx;align-self: center;">
				<text style="color: #FFFFFF;align-self: center;">更换头像</text>
			</view>
		</view>
		
	</view>
</template>

<script>
	var system = uni.getSystemInfoSync();
	var app = getApp();
	export default {
		data() {
			return {
				// faceUrl: "http://www.itzixi.com/img/arrow.png",
				faceUrl: app.getUserInfoSession().face,
			}
		},
		methods: {
			changeFace() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				uni.chooseImage({
					count: 1,
					sizeType: ["compressed"],
					crop: {
						quality: 60,
						width: 300,
						height: 300
					},
					success: (e) => {
						var newFace = e.tempFilePaths[0];
						me.faceUrl = newFace;
						
						// return;
						
						// 上传
						var serverUrl = app.globalData.serverUrl;
						uni.uploadFile({
							header: {
								headerUserId: userId,
								headerUserToken: app.getUserSessionToken()
							},
							url: serverUrl + "/file/uploadFace?userId=" + userId,
							name: "file",
							filePath: newFace,
							success(result) {
								console.log(result);
								console.log(result.data);
								// return;
								
								if (result.statusCode == 200) {
									var res = JSON.parse(result.data);
									
									if (res.status == 200) {
										var faceNewUrl = res.data;
										// 重置本地用户信息
										// app.setUserInfoSession(userInfo);
										// app.setUserSessionToken(userInfo.userToken);
										
										
										uni.request({
											method: "POST",
											url: serverUrl + "/userinfo/modify",
											data: {
												"userId": userId,
												"face": faceNewUrl
											},
											header: {
												headerUserId: userId,
												headerUserToken: app.getUserSessionToken()
											},
											success(result) {
												var status = result.data.status;
												if (status == 200) {
													var userInfo = result.data.data;
													app.setUserInfoSession(userInfo);
													app.setUserSessionToken(userInfo.userToken);
													
													uni.showToast({
														title: "用户头像修改成功~",
														duration: 1500
													})
													
												} else if (status != 200) {
													uni.showToast({
														title: result.data.msg,
														icon: "none",
														duration: 3000
													});
												}
											}
										});
										
										
										
										// uni.navigateBack({
										// 	delta: 1,
										// 	animationType: "fade-out"
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
								
							}
						})
					}
				})
			} 
		}
	}
</script>

<style>
	@import url("myFace.css");
</style>