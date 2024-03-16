<!-- 我的职务 -->
<template>
	<view class="page">
		<view class="single-line-box" style="">
			
			<input 
				class="nickname-input"
				type="text" 
				:value="position" 
				:model="position" 
				placeholder="请填入职务~"
				maxlength="12"
				@input="typingContent"/>
			
			<view class="counts-limt" style="margin-top: 10px;">
				<text class="tips">*注：填写职务名称可以让候选人更好的了解你. (每个月只能修改一次噢~)</text> 
				
				<text class="length-text">{{wordsLength}}/12</text> 
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				position: "",
				wordsLength: 0
			}
		},
		onNavigationBarButtonTap() {
			var position = this.position;
			console.log(position.length)
			if (position.length <= 0) {
				uni.showToast({
					icon: "none",
					title: "职位不能为空~"
				})
				return;
			}
			
			this.updatePosition();
		},
		onShow() {
			// 获得用户信息
			var currentUserInfo = getApp().getUserInfoSession();
			this.position = currentUserInfo.position;
			
			this.wordsLength = this.position.length;
		},
		methods: {
			updatePosition() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var position = this.position;
				
				var pendingUserInfo = {
					"userId": userId,
					"position": position
				};
				
				// 修改昵称
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/userinfo/modify",
					data: pendingUserInfo,
					success(result) {
						
						if (result.data.status == 200) {
							var userInfo = result.data.data;
							// 重置本地用户信息
							app.setUserInfoSession(userInfo);
							app.setUserSessionToken(userInfo.userToken);
							
							uni.showToast({
								title: "修改成功~",
								duration: 1500,
								// success() {
								// 	uni.navigateBack({
								// 		delta: 1,
								// 		animationType: "fade-out"
								// 	})
								// }
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
			
			typingContent(e) {
				var event = e;
				this.position = e.detail.value;
				this.wordsLength = this.position.length;
			},
		}
	}
</script>

<style>
	@import url("myPosition.css");
</style>
