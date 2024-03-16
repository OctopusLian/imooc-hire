<template>
	<view>
		
		<view class="top">
			<image src="../../../static/images/verifying.png" class="result-img"></image>
		</view>
		
		<view class="middle">
			<text class="info">信息审核中</text>
			<text class="msg">请耐心等待~</text>
		</view>
		
		<view class="btn-wrapper">
			<view class="btn-change" @click="iknow()">
				<text class="change-words">确认</text>
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
			}
		},
		onShow() {
			
		},
		onHide() {
			uni.showTabBar();
		},
		onLoad() {
		},
		methods: {
			iknow() {
				uni.navigateBack({
					delta: 2
				})
			},
			goBack() {
				
			}
		}
	}
</script>

<style>
	@import url("verifying.css");
</style>