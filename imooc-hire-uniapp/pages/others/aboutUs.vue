<!-- 关于我们 -->
<template>
	<view>
		
		<view class="top">
			<view class="logo" style="">
				<text class="logo-text" style="font-size: 13px; font-weight: 900;">IMOOC</text>
				<text class="logo-text" style="font-size: 16px; font-weight: 900;">慕聘网</text>
			</view>
			
			<view class="version">
				<text class="version-words">V 0.0.1</text>
			</view>
			
			<image src="../../static/images/myQRCode.png" class="qrcode"></image>
		</view>
		
		<view class="copyright-box">
			<text class="copyright">Copyright © 2022 imooc.com All rights reserved.</text>
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
				logoutTouched: false
			}
		},
		onLoad() {
		},
		methods: {
			
		}
	}
</script>

<style>
	@import url("aboutUs.css");
</style>