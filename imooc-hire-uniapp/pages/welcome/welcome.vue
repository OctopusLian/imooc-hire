<template>
	<view class="content">
		<view class="slogan" @click="goto()">
			<text class="slogan-text" style="font-size: 28px; font-weight: bold;">找工作 招人</text>
			<text class="slogan-text">就 来 慕 聘 网</text>
		</view>
		
		<view class="logo" style="position: fixed; bottom: 140upx;">
			<text class="logo-text" style="font-size: 13px; font-weight: 900;">IMOOC</text>
			<text class="logo-text" style="font-size: 16px; font-weight: 900;">慕聘网</text>
		</view>
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				userIsLogin: false,
				title: 'Hello Lee' 
			}
		},
		onLoad() {
			// uni.setTabBarItem({
			// 	index: 4,
			// 	visible: false
			// });
			// uni.hideTabBar();
			
			// 判断当前用户是否登录，如果没有登录，则跳转至登录页面，如果已经登录，则继续流程
			// var me = this;
			// var userIsLogin = app.userIsLogin();
			// this.userIsLogin = userIsLogin;
			// setTimeout(function () {
			// 	if (userIsLogin) {
			// 		me.goto();
			// 	} else {
			// 		me.goLogin();
			// 	}
			// }, 2500);
		},
		onShow() {
			var me = this;
			var userIsLogin = app.userIsLogin();
			this.userIsLogin = userIsLogin;
			setTimeout(function () {
				if (userIsLogin) {
					me.goto();
				} else {
					me.goLogin();
				}
			}, 2500);
		},
		methods: {
			goLogin() {
				uni.navigateTo({
					url: "../loginRegist/loginRegist",
					animationType: "fade-in"
				})
			},
			
			goto() {
				var me = this;
				var userType = uni.getStorageSync('userType');
				// 如果没有，默认设置为候选人
				if (userType == undefined || userType == "" || userType == null) {
					uni.setStorageSync('userType', me.userType.candidate);
				}
				
				console.log(userType)
				if (userType == this.userType.hr) {
					app.changeToHR();
				} else {
					app.changeToCandidate();
				}
				
				// 判断，只有H5这么做，因为HR不兼容、不支持
				// #ifdef H5
				console.log("H5进入")
				uni.setStorageSync('userType', 2);
				uni.switchTab({
					url: "../candidate/position"
				});
				// #endif
			}
		}
	}
</script>

<style>
	@import url("welcome.css");
</style>
