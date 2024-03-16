<!-- 公司介绍页面 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 50px;">
				<text class="title-one">编辑公司介绍</text>
				<text class="title-two">可以简单介绍一下公司的发展状况、服务领域、主要产品等信息，有助于候选人对公司的了解~</text>
			</view>
			
			<textarea 
				:value="introduction"
				:model="introduction" 
				maxlength="888" 
				class="textarea"
				placeholder="请填写公司介绍(不得超过888个字)" 
				placeholder-class="placeholder"/>
			
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				introduction: "",
			}
		},
		onShow() {
		},
		onLoad(options) {
			this.companyId = options.companyId;
			this.introduction = options.introduction;
		},
		onNavigationBarButtonTap() {
			this.modifyIntroduction();
		},
		methods: {
			modifyIntroduction() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var introduction = this.introduction;
				
				
				if (introduction == null || introduction == "" || introduction == undefined) {
					uni.showToast({
						title: "请填写企业介绍",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"introduction": introduction
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
	@import url("companyIntroduce.css");
</style>
