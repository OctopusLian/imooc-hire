<template>
	<view>
		
		<view class="top">
			<image src="../../../static/images/failed.png" class="result-img"></image>
		</view>
		
		<view class="middle">
			<text class="info">审核失败</text>
			<!-- <text class="msg">公司名称和营业执照不一致</text> -->
			<text class="msg">{{reviewReplay}}</text>
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
				reviewReplay: ""
			}
		},
		onShow() {
			
		},
		onHide() {
			uni.showTabBar();
		},
		onLoad(params) {
			var reviewReplay = params.reviewReplay;
			this.reviewReplay = reviewReplay;
		},
		methods: {
			iknow() {
				uni.navigateBack({
					delta: 1
				})
			},
			goBack() {
				
			}
		}
	}
</script>

<style>
	@import url("failed.css");
</style>