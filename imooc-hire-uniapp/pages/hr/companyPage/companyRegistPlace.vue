<!-- 公司介绍页面 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 50px;">
				<text class="title-one">编辑注册地址</text>
				<text class="title-two">完善企业信息有助于候选人查看~</text>
			</view>
			
			<input 
				:value="registPlace"
				:model="registPlace" 
				maxlength="36" 
				class="textarea"
				placeholder="请填写公司注册地址" 
				placeholder-class="placeholder"
				@input="typingContent"/>
			
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				registPlace: "",
			}
		},
		onShow() {
		},
		onLoad(options) {
			this.companyId = options.companyId;
			this.registPlace = options.registPlace;
		},
		onNavigationBarButtonTap() {
			// console.log(123);
			this.modify();
		},
		methods: {
			typingContent(e) {
				var event = e;
				this.registPlace = e.detail.value;
			},
			
			modify() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var registPlace = this.registPlace;
				
				if (registPlace == null || registPlace == "" || registPlace == undefined) {
					uni.showToast({
						title: "请填写注册地址",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"registPlace": registPlace
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
			
			submitChoose() {
				uni.navigateBack({
					delta: 1
				})
			}
			
		}
	}
</script>

<style>
	@import url("companyAddress.css");
</style>
