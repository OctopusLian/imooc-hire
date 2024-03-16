<template>
	<view>
		
		<view class="top">
			<image src="../../../static/images/success.png" class="result-img"></image>
		</view>
		
		<view class="middle">
			<text class="info">审核成功</text>
			<text class="msg">欢迎入驻慕聘网企业级在线招聘平台！</text>
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
	@import url("success.css");
</style>