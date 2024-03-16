<!-- 选择公司页面 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper">
				<text class="title-one">选择公司</text>
			</view>
			
			<view class="company-wrapper">
				
				<!-- <image src="../../static/images/imooc.png" class="company-logo"></image> -->
				<image :src="companyInfo.logo" class="company-logo"></image>
				
				<view class="company-box">
					<view class="company-name">
						<!-- 慕课网 -->
						{{companyInfo.shortName}}
					</view>
					<view class="company-info">
						<!-- <text class="industry">互联网·计算机</text>
						<text class="counts">已有10位HR入驻</text> -->
						<text class="industry">{{companyInfo.industry}}</text>
						<text class="counts">已有{{companyInfo.hrCounts}}位HR入驻</text>
					</view>
				</view>
				
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			
			
			
			<!-- 上传授权书 -->
			<view class="title-wrapper" style="margin-top: 50px;">
				<text class="title-one">入驻授权书</text>
				<text class="title-two">企业需要对HR招聘授权方可入驻平台</text>
				
				<view class="book-box">
					<text class="title-three" @click="previewImage()">查看示例图</text>
					<text class="title-four" @click="downloadTemplate()">下载授权书模板</text>
				</view>
			</view>
			
			
			<view class="upload-box" v-if="authLetter == null || authLetter == ''">
				<image src="../../static/images/upload.png" class="upload-img" @click="uploadAuthLetter()"></image>
				<view class="upload-words" @click="uploadAuthLetter()">
					<text class="upload-words">上传授权书</text>
				</view>
			</view>
			
			<image v-if="authLetter != null && authLetter != ''" :src="authLetter" class="auth-letter" @click="uploadAuthLetter()"></image>
			
			
			<view class="btn-next-wrapper" @click="confirmJoinCompany()">
				<text class="btn-next-words">确认加入公司</text>
			</view>
			<!-- <button type="default" class="btn-next" :disabled="disabled" @click="next()">确认加入公司</button>	 -->
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				authLetter: "",
				
				docTemplate: "https://vkceyugu.cdn.bspapp.com/VKCEYUGU-a510f11a-afcf-48f9-bcff-848ce1501f2f/74ba4194-4793-4e52-9d23-1202208f5ea6.png",
				// docTemplate: "https://vkceyugu.cdn.bspapp.com/VKCEYUGU-a510f11a-afcf-48f9-bcff-848ce1501f2f/ba3bdaff-59b9-40d5-b5f4-20373751548b.docx"
				
				backPageCounts: 0,
				companyId: "",
				companyInfo: "",
			}
		},
		onNavigationBarButtonTap() {
			
		},
		onShow() {
		},
		onLoad(options) {
			
			var backPageCounts = options.backPageCounts;
			this.backPageCounts = backPageCounts
			console.log(backPageCounts);
			
			var companyId = options.companyId;
			this.companyId = companyId;
			console.log(companyId);
			
			// 再次查询企业基本信息，以及企业目前绑定的HR数
			this.getCompanyInfo(companyId);
		},
		methods: {
			getCompanyInfo(companyId) {
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/getInfo?companyId=" + companyId + "&withHRCounts=true",
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var companyInfo = result.data.data;
							me.companyInfo = companyInfo;
							
							// console.log(companyInfo);
						} else {
							uni.showToast({
								title: result.data.msg,
								icon: "none",
								duration: 3000
							});
						}
						
					}
				})
			},
			
			confirmJoinCompany() {
				// 确认加入并且返回，这里要从上一个页面进来判断，判断返回的页面栈数是几页
				var me = this;
				
				if (this.authLetter == null || this.authLetter == "" || this.authLetter == undefined) {
					uni.showToast({
						title: "请上传授权书",
						icon: 'error'
					});
					return;
				}
				
				var userId = app.getUserInfoSession().id;
				
				var reviewCompanyBO = {
					"hrUserId": userId,
					"realname": "",
					"companyId": me.companyId,
					"companyName": me.companyInfo.companyName,
					"authLetter": me.authLetter
				};
				
				uni.setStorageSync("reviewCompanyBO", reviewCompanyBO);
				var backPageCounts = parseInt(me.backPageCounts);
				uni.navigateBack({
					delta: backPageCounts
				})
				
				return;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/goReviewCompany",
					data: reviewCompanyBO,
					success(result) {
						
						if (result.data.status == 200) {
							
							uni.showToast({
								title: "企业信息已提交，请耐心等待审核~",
								duration: 2500,
								success() {
									setTimeout(() => {
										var backPageCounts = parseInt(me.backPageCounts);
										uni.navigateBack({
											delta: backPageCounts
										})
									}, 2500)
								}
							})
							
						} else {
							uni.showToast({
								title: result.data.msg,
								icon: "none",
								duration: 3000
							});
						}
						
					}
				})
				
				
				
				
				
				
				
				// var backPageCounts = parseInt(me.backPageCounts);
				// uni.navigateBack({
				// 	delta: backPageCounts
				// })
			},
			
			previewImage() {
				uni.previewImage({
					urls: ["../../static/files/授权书样例.png"]
				})
			},
			
			downloadTemplate() {
				
				var docTemplate = this.docTemplate;
				
				// H5不支持下载文件
				// #ifdef H5
					uni.showModal({
						title: "请到app端下载授权书模板（H5不支持）",
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
							url: docTemplate, //仅为示例，并非真实的资源
							success: (res) => {
								if (res.statusCode === 200) {
									console.log('下载成功');
									console.log(res);
								}
								let that = this;
								
								uni.saveImageToPhotosAlbum({
									filePath: res.tempFilePath,
									success() {
										uni.showModal({
											title: "授权书模板已保存到相册，请打印并完善盖章后上传~",
											cancelText: "好的",
											confirmText: "我知道了",
											confirmColor: "#31B9B3",
											success(e) {
											}
										});
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
			},
			/**
			 * ios下文件名中文处理
			 * @param {String} filename
			 */
			fileNameEscape(filename) {
				if (uni.getSystemInfoSync().platform == "ios") {
					filename = escape(filename);
				}
				return filename;
			},
			
			downloadTemplate2() {
				
				// H5不支持下载文件
				// #ifdef H5
					uni.showModal({
						title: "请到app端下载授权书模板（H5不支持）",
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
				console.log(123987)
				
				uni.downloadFile({
					url: "http://www.imoocnews.com:8099/AuthLetterTemplate.png",
					success: function(result) {
						console.log(result);
						var tempFilePath = result.tempFilePath;
						// console.log(tempFilePath);
						uni.saveImageToPhotosAlbum({
							filePath: tempFilePath,
							success: function() {
								uni.showToast({
									title: "保存成功",
									duration: 2000
								})
							},
							complete: function() {
								uni.hideLoading();
							}
						})
					},
					fail(e) {
						console.log(e);
					}
				})
				
				
				
				// uni.downloadFile({
				// 	// url: 'http://localhost:8099/AuthLetterTemplate.png',
				// 	url: 'http://www.imoocnews.com:8099/AuthLetterTemplate.png',
				// 	success(res) {
				// 		console.log(res);
				// 		if (res.statusCode === 200) {
				// 			var tempPath = res.tempFilePath;
							
							
				// 			uni.saveImageToPhotosAlbum({  
				// 				filePath: tempPath,  
				// 				success() {  
				// 					uni.showToast({  
				// 						title: '保存成功！',  
				// 						icon: 'none'  
				// 					})  
				// 				},  
				// 				fail() {  
				// 					uni.showToast({  
				// 						title: '保存失败，请稍后重试！',  
				// 						icon: 'none'  
				// 					})  
				// 				}  
				// 			});  
							
							
							
				// 		}
				// 	},
				// 	fail(e) {
				// 		console.log(e);
				// 		console.log('下载失败');
				// 		uni.showToast({
				// 			icon: 'none',
				// 			mask: true,
				// 			title: '失败请重新下载'
				// 		});
				// 	}
					
				// });
				// #endif
				
			},
			
			uploadAuthLetter() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				uni.chooseImage({
					count: 1,
					success: (e) => {
						var authLetter = e.tempFilePaths[0];
						// me.authLetter = authLetter;
						
						// 上传
						var serverUrl = app.globalData.serverUrl;
						uni.uploadFile({
							header: {
								headerUserId: userId,
								headerUserToken: app.getUserSessionToken()
							},
							url: serverUrl + "/file/uploadAuthLetter",
							name: "file",
							filePath: authLetter,
							success(result) {
								
								if (result.statusCode == 200) {
									var res = JSON.parse(result.data);
									
									if (res.status == 200) {
										var authLetterNew = res.data;
										me.authLetter = authLetterNew;
										
										uni.showToast({
											title: "授权书上传成功~",
											duration: 1500
										})
										
									} else {
										uni.showToast({
											title: res.msg,
											icon: 'error'
										})
									}
								} else {
									uni.showToast({
										title: "上传失败",
										icon: 'error'
									})
								}
								
							}
						})
					}
				});
			}
		}
	}
</script>

<style>
	@import url("chooseCompany.css");
</style>
