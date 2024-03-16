<!-- 修改昵称页面 -->
<template>
	<view class="page">
		<view class="single-line-box" style="">
			
			<input 
				class="nickname-input"
				type="text" 
				:value="nickname" 
				:model="nickname" 
				placeholder="请填入邮箱地址~"
				@input="typingContent"/>
			
			<view class="" style="width: 95%; margin-top: 10px;">
				<text class="tips">*注：填写正确的邮箱有助于候选人联系你噢~</text> 
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				nickname: "",
				wordsLength: 0
			}
		},
		onNavigationBarButtonTap() {
			var nickname = this.nickname;
			console.log("nickname = " + nickname);
			
			if (nickname.length <= 0) {
				uni.showToast({
					icon: "none",
					title: "邮箱不能为空"
				})
				return;
			}
			
			this.updateEmail();
		},
		onShow() {
			// 获得用户信息
			var currentUserInfo = getApp().getUserInfoSession();
			this.nickname = currentUserInfo.email;
			
			this.wordsLength = this.nickname.length;
		},
		methods: {
			typingContent(e) {
				var event = e;
				this.nickname = e.detail.value;
				this.wordsLength = this.nickname.length;
			},
			
			updateEmail() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var email = this.nickname;
				
				var pendingUserInfo = {
					"userId": userId,
					"email": email
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
			
		}
	}
</script>

<style>
	@import url("myEmail.css");
</style>
