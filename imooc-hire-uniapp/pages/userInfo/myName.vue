<!-- 修改昵称页面 -->
<template>
	<view class="page">
		
		<view class="big-box">
			
			<view class="name-box">
				<text class="name-text">姓名</text>
				<text class="authentication-text">(已认证，姓名不可更改)</text>
			</view>
			
			<view class="my-name-box">
				<text class="my-name">风间影月</text>
			</view>
			
			<view class="" style="width: 95%; margin-top: 10px;">
				<text class="tips">*注：姓名与当时入驻绑定企业的时候一致，更改则需要解绑企业重新入驻~</text> 
			</view>
			
			<view class="outter-box">
				<view class="name-box" >
					<text class="name-text">对外展示名称</text>
				</view>
				<radio-group class="radio-group">
					<view class="radio-item" style="margin-top: 20px; display: flex; justify-content: space-between;" @click="chooseType(1)"> 
						<view class="chosen-item">
							<text class="radio-words">姓名</text>
							<text class="small-words" v-if="currentUserInfo == null">(风间影月)</text>
							<text class="small-words" v-if="currentUserInfo != null">({{currentUserInfo.realName}})</text>
							
						</view>
						<radio value="1" :checked="showNameType == 1"/>
					</view>
					<view class="radio-item" style="margin-top: 22px; display: flex; justify-content: space-between;" @click="chooseType(2)">
						<view class="chosen-item">
							<text class="radio-words">昵称</text>
							<text class="small-words">({{currentUserInfo.nickname}})</text>
						</view>
						<radio value="0" :checked="showNameType == 2"/>
					</view>
				</radio-group>
			</view>
			<view class="" style="width: 95%; margin-top: 10px;">
				<text class="tips">*注：使用真实姓名会提高候选人对你的真实性与信赖度噢~</text> 
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				showNameType: 1,
				currentUserInfo: null, 
			}
		},
		onNavigationBarButtonTap() {
			// console.log(this.sex);
			var me = this;
			var userId = getApp().getUserInfoSession().id;
			var serverUrl = app.globalData.serverUrl;
			uni.request({
				method: "POST",
				url: serverUrl + "/userinfo/modify",
				header: {
					headerUserId: userId,
					headerUserToken: app.getUserSessionToken()
				},
				data: {
					"userId": userId,
					"showWhichName": me.showNameType
				},
				success(result) {
					var status = result.data.status;
					if (status == 200) {
						var userInfo = result.data.data;
						app.setUserInfoSession(userInfo);
						app.setUserSessionToken(userInfo.userToken);
						
						uni.showToast({
							title: "修改成功~",
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
		},
		onShow() {
			// 获得用户信息
			var currentUserInfo = getApp().getUserInfoSession();
			this.currentUserInfo = currentUserInfo;
			this.showNameType = currentUserInfo.showWhichName;
		},
		methods: {
			chooseType(type) {
				this.showNameType = type;
			}
		}
	}
</script>

<style>
	@import url("myName.css");
</style>
