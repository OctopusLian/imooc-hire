<!-- 播放视频消息 -->
<template>
	<view>
		
		<!-- <view class="video-box"> -->
			 <!-- autoplay 自动播放 -->
			 <!-- muted 静音播放 -->
			 <!-- object-fit	视频大小与 video 容器大小不一致时，视频的表现形式。contain：包含，fill：填充，cover：覆盖	App、微信小程序、字节跳动小程序、飞书小程序、H5、京东小程序 -->
			 <!-- poster	视频封面的图片网络资源地址 -->
			<video 
				:src="src" 
				:object-fit="fit"
				autoplay
				muted
				show-fullscreen-btn="false"
				class="video-display"
				:style="{'weight': videoWeight + 'upx', 'height': videoHeight + 'upx'}"
				@click="controlsToggle">
			<!-- :style="{'weight': videoWeight + 'upx', 'height': videoHeight + 'upx'}" -->
			
				<cover-view class="control-box">
					<cover-image src="../../static/icons/msg/icon-video-goback.png" class="icon-video-goback" @click="goback"></cover-image>
					<cover-image src="../../static/icons/msg/icon-video-download2.png" class="icon-video-download" @click="download"></cover-image>
				</cover-view>
				
			</video>
		<!-- </view> -->
		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				src: "",
				src1: "https://vkceyugu.cdn.bspapp.com/VKCEYUGU-a510f11a-afcf-48f9-bcff-848ce1501f2f/7a604f54-c4a2-4eb3-81c5-67983502ea0b.mp4",
				src2: "http://192.168.1.5:8099/video/1654401525828.mp4",
				pageHeight: 500,
				videoWeight: 750,
				videoHeight: 500,
				// videoWeight: 0,
				// videoHeight: 0,
				
				fit: ""
			}
		},
		onReachBottom() {
		},
		onLoad(params) {
			console.log(params);
			
			// 等比缩放
			var width = params.width;
			var height = params.height;
			console.log("width = " + width);
			console.log("height = " + height);
			
			this.src = params.src;
			
			if (width >= height) {
				this.fit = "cover"
			} else {
				this.fit = "fill"
			}
			var videoHeight = this.videoWeight * height / width;
			this.videoHeight = videoHeight;
			
		},
		onShow() {
			
		},
		onReady() {
			//获取整个页面的高度，从而计算出页面可用的高度，因为使用了自定义的navbar所以this.pageHeight不是单纯的res.windowHeight。（ps: uview组件的navbar高度是固定的44px,不包括statusBarHeight）
			uni.getSystemInfo({
				success: (res) => {
					this.pageHeight = res.windowHeight - 80;
					this.pageWeight = res.windowWidth;
				}
			});
			
			
		},
		methods: {
			controlsToggle() {
				
			},
			
			goback() {
				uni.navigateBack({
					delta: 1
				})
			},
			
			download() {
				
				var videoTemplate = this.src;
				
				// H5不支持下载文件
				// #ifdef H5
					uni.showModal({
						title: "H5可以直接右键下载噢~",
						cancelText: "好吧",
						confirmText: "我知道了",
						confirmColor: "#31B9B3",
						success(e) {
							if (e.confirm) {
							}
						}
					});
				// #endif
				
				// #ifdef APP
					var platform = uni.getSystemInfoSync().platform;
					console.log(platform);
						uni.downloadFile({
							url: videoTemplate, //仅为示例，并非真实的资源
							success: (res) => {
								if (res.statusCode === 200) {
									console.log('下载成功');
									console.log(res);
								}
								let that = this;
								
								uni.saveVideoToPhotosAlbum({
								// uni.saveImageToPhotosAlbum({
									filePath: res.tempFilePath,
									success() {
										uni.showToast({
											title: "下载成功",
											icon: "none",
											duration: 1000
										})
									},
									fail() {
										uni.showToast({
											title: '保存失败，请稍后重试！',  
											icon: 'none'  
										})  
									}
								})
								
								// uni.saveFile({
								// 	tempFilePath: res.tempFilePath,
								// 	// tempFilePath: this.fileNameEscape(res.tempFilePath),
								// 	success: function(res) {
								// 		that.file = res.savedFilePath
								// 		console.log(res)
										
								// 			//打开文档查看
								// 			uni.openDocument({
								// 				filePath: that.file,
								// 				success: function(res) {
								// 					console.log('打开文档成功');
								// 				},
								// 				fail: function() {
								// 					console.log('打开失败');
								// 				}
								// 			});
								// 	},
								// 	fail(e) {
								// 		console.log(e);
								// 	}
								// });
							},
							fail(e) {
								console.log(e);
							}
						});
				// #endif
			}
		}
	}
</script>

<style>
	@import url("msgVideo.css");
</style>

