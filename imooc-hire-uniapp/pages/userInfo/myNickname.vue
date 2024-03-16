<!-- 修改昵称页面 -->
<template>
	<view class="page">
		<view class="single-line-box" style="">
			
			<input 
				class="nickname-input"
				type="text" 
				:value="nickname" 
				:model="nickname" 
				placeholder="请填入昵称~"
				maxlength="12"
				@input="typingContent"/>
			
			<view class="counts-limt" style="margin-top: 10px;">
				<text class="tips">*注：请设置2-12的昵称长度</text> 
				
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
				// oldNickname: getApp().getUserInfoSession().nickname,
				// nickname: getApp().getUserInfoSession().nickname,
				nickname: "",
				wordsLength: 0
			}
		},
		onNavigationBarButtonTap() {
			var nickname = this.nickname;
			if (nickname.length > 12 || nickname.length < 2) {
				uni.showToast({
					icon: "none",
					title: "昵称长度为2-12"
				})
				return;
			}
			
			this.updateNickname();
		},
		onShow() {
			// 获得用户信息
			var currentUserInfo = getApp().getUserInfoSession();
			this.nickname = currentUserInfo.nickname;
			
			
			this.wordsLength = this.nickname.length;
		},
		methods: {
			updateNickname() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var nickname = this.nickname;
				
				var pendingUserInfo = {
					"userId": userId,
					"nickname": nickname
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
				this.nickname = e.detail.value;
				this.wordsLength = this.nickname.length;
			},
		}
	}
</script>

<style>
	@import url("myNickname.css");
</style>
