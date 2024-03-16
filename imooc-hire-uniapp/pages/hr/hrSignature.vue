<!-- HR 个人签名页 -->
<template>
	<view>
		<view class="outer-box">
			<view class="title-box">
				<text class="title-words">编辑签名</text>
				<text class="title-second">一个好签名可以吸引更优秀的人才~</text>
			</view>
		</view>
			
		<view class="outer-box">
			<textarea :focus="focus" v-model="signature" class="sign-area" placeholder="请填写你的签名~" placeholder-class="placeholder-style" />
		</view>
		
		<view class="outer-box" style="margin-top: 20px;">
			<view class="title-box">
				<text class="other-words">求职者都关注这些：</text>
			</view>
			<view class="item-box-wrapper" style="margin-top: 6px;">
				<view class="item-box">
					<image src="../../static/icons/point.png" class="other-point"></image>
					<text class="point-words">团队氛围</text>
				</view>
				<view class="item-box" style="margin-left: 6px;">
					<image src="../../static/icons/point.png" class="other-point"></image>
					<text class="point-words">发展前景</text>
				</view>
				<view class="item-box" style="margin-left: 6px;">
					<image src="../../static/icons/point.png" class="other-point"></image>
					<text class="point-words">管理风格</text>
				</view>
				<view class="item-box" style="margin-left: 6px;">
					<image src="../../static/icons/point.png" class="other-point"></image>
					<text class="point-words">福利待遇</text>
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
				focus: false,
				signature: "",
				// signature: "我们有很好的团队氛围，归属感很强烈，待遇也十分丰厚~",
				
				currentUserInfo: null,
			}
		},
		onShow() {
			// 获得用户信息
			var currentUserInfo = getApp().getUserInfoSession();
			this.signature = currentUserInfo.hrSignature;
		},
		onLoad(e) {
		},
		onNavigationBarButtonTap() {
			this.focus = true;
			this.$nextTick(function() {
				this.focus = false;
			});
			// console.log("onNavigationBarButtonTap");
			this.updateSignature();
		},
		methods:{
			updateSignature() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var hrSignature = this.signature;
				
				var pendingUserInfo = {
					"userId": userId,
					"hrSignature": hrSignature
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
								success() {
									
									// uni.navigateBack({
									// 	delta: 1,
									// 	animationType: "fade-out"
									// })
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
		}
	}
</script>

<style>
	@import url("hrSignature.css");
</style>
