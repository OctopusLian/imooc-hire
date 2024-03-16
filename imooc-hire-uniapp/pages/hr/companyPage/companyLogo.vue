<!-- 公司logo上传页面 -->
<template>
	<view>
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 20px;">
				<text class="title-one">上传公司 LOGO</text>
				<text class="title-two">上传的公司LOGO将会出现在公司主页以及公司下展示的所有职位中，建议上传清晰规范的LOGO图片~</text>
			</view>
			
			<view class="business-license-wrapper">
				<image v-show="logo != null && logo != ''" :src="logo" class="business-license" @click="uploadLogo()"></image>
				
				<image v-show="logo == null || logo == ''" src="../../../static/images/upload.png" class="upload-icon" @click="uploadLogo()"></image>
				<text v-show="logo == null || logo == ''" class="upload-words" @click="uploadLogo()">上传logo</text>
			</view>
		
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				logo: ""
			}
		},
		onShow() {
		},
		onLoad(options) {
			this.companyId = options.companyId;
		},
		onNavigationBarButtonTap() {
			this.modifyLogo();
		},
		methods:{
			modifyLogo() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var logo = this.logo;
				
				if (logo == null || logo == "" || logo == undefined) {
					uni.showToast({
						title: "图片不能为空",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"logo": logo
				};
				
				// 修改昵称
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
							
							uni.navigateBack({
								delta: 1,
								animationType: "fade-out"
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
			
			uploadLogo() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				uni.chooseImage({
					count: 1,
					sizeType: ["compressed"],
					success: (e) => {
						var companyLogo = e.tempFilePaths[0];
						
						// 上传
						var serverUrl = app.globalData.serverUrl;
						uni.uploadFile({
							header: {
								headerUserId: userId,
								headerUserToken: app.getUserSessionToken()
							},
							url: serverUrl + "/file/uploadLogo",
							name: "file",
							filePath: companyLogo,
							success(result) {
								
								if (result.statusCode == 200) {
									var res = JSON.parse(result.data);
									
									if (res.status == 200) {
										var companyLogoNew = res.data;
										me.logo = companyLogoNew;
										
										uni.showToast({
											title: "LOGO上传成功~",
											duration: 1500
										})
										
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
			},
			
			gotoTags() {
				uni.navigateTo({
					url: "./hrTags",
					animationType: "slide-in-bottom"
				});
			}
		}
	}
</script>

<style>
	@import url("companyLogo.css");
</style>
