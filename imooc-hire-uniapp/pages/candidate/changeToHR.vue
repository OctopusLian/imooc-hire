<!-- 切换为HR页面 -->
<template>
	<view>
		
		<view class="top">
			<image src="../../static/images/cand.png" class="cand"></image>
			
			<view class="words-wrappe">
				<text class="words">你当前的身份为“求职者”</text>
			</view>
		</view>
		
		<view class="btn-wrapper">
			 <!-- style="margin-top: 160px;" -->
			<view class="btn-change" @click="changeToHR()">
				<text class="change-words">切换为“招聘者”身份</text>
			</view>
			
			<view class="btn-back" style="margin-top: 16px;" @click="goBack()">
				<text class="back-words">返回</text>
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		components: {
		},
		data() {
			return {
				whoami: ""
			}
		},
		onShow() {
			
		},
		onLoad() {
		},
		methods: {
			changeToHR() {
				var hrUserType = this.userType.hr;
				uni.setStorageSync('userType', hrUserType);
				// app.changeToHR();
				
				
				// uni.reLaunch({
				// 	url: "../hr/recommend"
				// });
				
				// uni.reLaunch({
				// 	url: "../welcome/blank?person=" + hrUserType
				// });
				
				// uni.showTabBar();
				
				// uni.switchTab({
				// 	url: "../hr/recommend"
				// })
				
				var me = this;
				setTimeout(function () {
					me.goBack();
				}, 100);
			},
			
			goBack() {
				uni.navigateBack({
					delta: 1
				})
			}
		}
	}
</script>

<style>
	@import url("changeToHR.css");
</style>