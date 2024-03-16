<!-- 公司介绍页面 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 50px;">
				<text class="title-one">编辑注册资本</text>
				<text class="title-two">完善企业信息有助于候选人查看~</text>
			</view>
			
			<input 
				:value="registCapital"
				:model="registCapital" 
				maxlength="12" 
				class="textarea"
				placeholder="请填写公司注册资本" 
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
				registCapital: "",
			}
		},
		onShow() {
		},
		onLoad(options) {
			this.companyId = options.companyId;
			this.registCapital = options.registCapital;
		},
		onNavigationBarButtonTap() {
			// console.log(123);
			this.modify();
		},
		methods: {
			typingContent(e) {
				var event = e;
				this.registCapital = e.detail.value;
			},
			
			modify() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var registCapital = this.registCapital;
				
				if (registCapital == null || registCapital == "" || registCapital == undefined) {
					uni.showToast({
						title: "请填写注册资本",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"registCapital": registCapital
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
