<!-- 切换为候选人页面 -->
<template>
	<view>
		
		<view class="top">
			<image src="../../static/images/hr2.png" class="hr"></image>
			
			<view class="words-wrappe">
				<text class="words">你当前的身份为“招聘者”</text>
			</view>
		</view>
		
		<view class="btn-wrapper">
			 <!-- style="margin-top: 160px;" -->
			<view class="btn-change" @click="changeToCandidate()">
				<text class="change-words">切换为“求职者”身份</text>
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
			changeToCandidate() {
				var candUserType = this.userType.candidate;
				uni.setStorageSync('userType', candUserType);
				// app.changeToCandidate();
				
				// uni.reLaunch({
				// 	url: "../candidate/position"
				// });
				
				// uni.switchTab({
				//     url: '../candidate/position'
				// });
				
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
	@import url("changeToCand.css");
</style>