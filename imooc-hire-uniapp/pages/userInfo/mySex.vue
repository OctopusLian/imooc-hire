<!-- 我的称谓（性别） -->
<template>
	<view class="">
		
		
			<radio-group class="radio-group" style="margin-top: 30px;margin-left: 20px;">
				<view class="radio-item" @click="chooseSex(1)">
					<radio value="1" :checked="sex == 1"/>
					<text class="radio-words">先生</text>
				</view>
				<view class="radio-item" style="margin-top: 20px;" @click="chooseSex(0)">
					<radio value="0" :checked="sex == 0"/>
					<text class="radio-words">女士</text>
				</view>
				<view class="radio-item" style="margin-top: 20px;" @click="chooseSex(2)">
					<radio value="2" :checked="sex == 2"/>
					<text class="radio-words">保密</text>
				</view>
			</radio-group>
			
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				sex: 0
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
					"sex": me.sex
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
			this.sex = currentUserInfo.sex;
		},
		methods: {
			chooseSex(sex) {
				this.sex = sex;
			}
		}
	}
</script>

<style>
	@import url("myName.css");
</style>
