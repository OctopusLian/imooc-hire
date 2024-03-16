<!-- HR 我的页面 -->
<template>
	<view>
		<view class="myInfo">
			<view class="title">
				<!-- <text class="title-text">慕聘网</text> -->
			</view>
			
			<view class="navigation-bar" style="z-index: 99999;" :style="{opacity: opacity }">
				<image src="../../static/images/me.png" v-if="currentUserInfo == null" class="small-face"></image>
				<image :src="currentUserInfo.face" v-if="currentUserInfo != null" class="small-face"></image>
				
				<view class="small-nickname">
					<text class="title-text" v-if="currentUserInfo == null">风间影月</text>
					<text class="title-text" v-if="currentUserInfo != null">{{currentUserInfo.showWhichName == 1 ? currentUserInfo.realName : currentUserInfo.nickname}}</text>
				</view>
			</view>
			
			
			<view class="options">
				<!-- #ifndef H5 -->
				<image src="../../static/icons/icon-scan.png" style="width: 22px;height: 22px;margin-right: 10px;" @click="goScan()" ></image>
				<!-- #endif -->
				
				<image src="../../static/icons/settings.png" style="width: 22px;height: 22px;" @click="goToSettings()" ></image>
			</view>
			
			<view class="real-me">
				<image src="../../static/images/me.png" v-if="currentUserInfo == null" class="my-face"></image>
				<image :src="currentUserInfo.face" v-if="currentUserInfo != null" class="my-face"></image>
				
				<view class="my-name-wrapper">
					<view class="my-name-box">
						<text class="my-name" v-if="currentUserInfo == null">风间影月</text>
						<text class="my-name" v-if="currentUserInfo != null">{{currentUserInfo.showWhichName == 1 ? currentUserInfo.realName : currentUserInfo.nickname}}</text>
					</view>
					<view class="edit-wrapper">
						<view class="edit-my-resume-wrapper">
							<text class="edit-my-resume" v-if="currentUserInfo == null">慕课网 · 技术经理</text>
							<text class="edit-my-resume" v-if="currentUserInfo != null">{{companyInfo == null ? '慕课网' : companyInfo.shortName }} · {{currentUserInfo.position}}</text>
						</view>
					</view>
				</view>
			</view>
			
			<view class="numbers">
				<view class="num-item" @click="gotoMyCollectResume()">
					<text class="num-counts">{{hrCollectResumeCounts}}</text>
					<text class="num-text">收藏</text>
					<!-- HR收藏的简历 -->
				</view>
				
				<view class="num-item" @click="gotoMyReadResume()">
					<text class="num-counts">{{hrReadResumeRecordCounts}}</text>
					<text class="num-text">浏览</text>
					<!-- HR浏览过的历史简历 -->
				</view>
				
				<view class="num-item" @click="gotoMyPositionList()">
					<text class="num-counts">{{hrAllJobCounts}}</text>
					<text class="num-text">职位</text>
					<!-- HR的职位数，管理职位 -->
				</view>
				
				<view class="num-item" @click="gotoMyInterview()">
					<text class="num-counts">{{hrAllInterviewCounts}}</text>
					<text class="num-text">面试</text>
					<!-- 待处理面试，面试记录 -->
				</view>
			</view>
			
			<view class="vip-box">
				<view class="vip-wrapper">
					<view class="upgrade-vip" style="margin-left: 10px;">
						<view class="vip-left-part">
							<!-- <image src="../../static/icons/vip.png" style="width: 32px;height: 26px;align-self: center;"></image> -->
							<image src="../../static/icons/vip2.png" style="width: 45px;height: 28px;align-self: center; border-radius: 40px;"></image>
							<text class="about-words">开通VIP享受更多超值权益</text>
						</view>
						
						<view class="upgrade-vip-btn" @click="doUpgrade()">
							<text class="about-words" style="margin-left: 0px; color: #323232;align-self: center;">立即升级</text>
						</view>
					</view>
				</view>
			</view>
		</view>
		
		<view class="block-one">
			<view class="block-box">
				<view class="block-line" style="margin-top: 10px;" @click="goToHRInfo()">
					<view class="left-part">
						<image src="../../static/icons/account.png" style="width: 18px;height: 18px;align-self: center;"></image>
						<text class="left-part-words">个人信息</text>
					</view>
					
					<view class="right-part">
						<text class="right-part-words">个人信息修改</text>
						<image src="../../static/icons/right-arrow.png" style="width: 12px;height: 12px;align-self: center;"></image>
					</view>
				</view>
				
				<view class="block-line" @click="goToHRPage()">
					<view class="left-part">
						<image src="../../static/icons/me.png" style="width: 18px;height: 18px;align-self: center;"></image>
						<text class="left-part-words">我的主页</text>
					</view>
					
					<view class="right-part">
						<text class="right-part-words">个性页面展示</text>
						<image src="../../static/icons/right-arrow.png" style="width: 12px;height: 12px;align-self: center;"></image>
					</view>
				</view>
				
				<view class="block-line"  @click="goToCompanyPage()">
					<view class="left-part">
						<image src="../../static/icons/company.png" style="width: 16px;height: 16px;align-self: center;"></image>
						<text class="left-part-words">企业主页</text>
					</view>
					
					<view class="right-part">
						<text class="right-part-words">企业形象展示</text>
						<image src="../../static/icons/right-arrow.png" style="width: 12px;height: 12px;align-self: center;"></image>
					</view>
				</view>

				<view class="block-line" style="margin-bottom: 10px;" @click="changeToCandidate()">
					<view class="left-part">
						<image src="../../static/icons/gojob.png" style="width: 16px;height: 16px;align-self: center;"></image>
						<text class="left-part-words">我要求职</text>
					</view>
					
					<view class="right-part">
						<text class="right-part-words" style="color: #31B9B3">主动出击，精准匹配</text>
						<image src="../../static/icons/right-arrow.png" style="width: 12px;height: 12px;align-self: center;"></image>
					</view>
				</view>
			</view>
		</view>
		
		<view class="block-two">
			<view class="block-box" style="height: 230px;">
				<view class="block-line" style="margin-top: 10px;" @click="goToPrivacy()">
					<view class="left-part">
						<image src="../../static/icons/privacy.png" style="width: 18px;height: 18px;align-self: center;"></image>
						<text class="left-part-words">隐私规则</text>
					</view>
					
					<view class="right-part">
						<text class="right-part-words">规则明示</text>
						<image src="../../static/icons/right-arrow.png" style="width: 12px;height: 12px;align-self: center;"></image>
					</view>
				</view>
				
				<view class="block-line" @click="goToAboutUs()">
					<view class="left-part">
						<image src="../../static/icons/aboutus.png" style="width: 18px;height: 18px;align-self: center;"></image>
						<text class="left-part-words">关于我们</text>
					</view>
					
					<view class="right-part">
						<text class="right-part-words"></text>
						<image src="../../static/icons/right-arrow.png" style="width: 12px;height: 12px;align-self: center;"></image>
					</view>
				</view>
				
				<view class="block-line" @click="goToSettings()">
					<view class="left-part">
						<image src="../../static/icons/settings2.png" style="width: 18px;height: 18px;align-self: center;"></image>
						<text class="left-part-words">设置</text>
					</view>
					
					<view class="right-part">
						<text class="right-part-words"></text>
						<image src="../../static/icons/right-arrow.png" style="width: 12px;height: 12px;align-self: center;"></image>
					</view>
				</view>
				
				<view class="block-line" style="margin-bottom: 10px;" @click="goToMyCourses()">
					<view class="left-part">
						<image src="../../static/icons/course.png" style="width: 18px;height: 18px;align-self: center;"></image>
						<text class="left-part-words">更多课程</text>
					</view>
					
					<view class="right-part">
						<text class="right-part-words" style="color: #31B9B3">风间影月精品课程</text>
						<image src="../../static/icons/right-arrow.png" style="width: 12px;height: 12px;align-self: center;"></image>
					</view>
				</view>
			</view>
		</view>
		
		<view class="say-something-block">
			<view class="say-something-box">
				<text class="more-text">京ICP备 12003892号-11</text>
				<image src="../../static/icons/separator2.png" class="separator" style="width: 14px;height: 28px;margin-left: 1px;margin-right: 1px;"></image>
				<text class="more-text">京公网安备11010802030151号</text>
			</view>
			
			<view class="say-something-box">
				<text class="more-text">客服热线 800-900-8888</text>
				<text class="more-text" style="margin-left: 6px;">工作时间 9:30-16:30</text>
			</view>
			
			<view class="say-something-box" style="margin-top: 4px;">
				<text class="more-text">本app为慕聘网演示体验版</text>
			</view>
			
			<view class="say-something-box" style="margin-top: 4px;">
				<text class="more-text">所有权归慕课网以及风间影月</text>
			</view>
			
			<view class="say-something-box" style="margin-top: 3px;">
				<text class="more-text">www.imooc.com</text>
			</view>
			
			<view class="say-something-box" style="margin-top: 3px;">
				<text class="more-text">编织梦想 程就未来</text>
			</view>
		</view>
		
		<view class="smill-box">
			<image src="../../static/icons/smill.png" class="smill" style=""></image>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				background:{backgroundColor:'#fd5365'},
				height:0,
				navbarRight:0,
				opacity: 0,
				scrollY: 0,
				
				reFresh:"",
				
				currentUserInfo: null, 
				companyInfo: null,
				
				hrCollectResumeCounts: 0,
				hrReadResumeRecordCounts: 0,
				hrAllJobCounts: 0,
				hrAllInterviewCounts: 0,
			}
		},
		watch:{
		    //监听reFresh,如果有修改就执行监听器
		    reFresh:function(){
				var me = this;
		        // 目的从修改公司页面跳回来进行判断的
		        var userType = uni.getStorageSync('userType');
		        if (userType == this.userType.candidate) {
					// console.log(987);
		        	app.changeToCandidate();
					setTimeout(function () {
						me.goto();
					}, 10);
		        }
		        // console.log("页面已重新加载");
		    }
		},
		onShow() {
			// 获得用户信息
			var currentUserInfo = getApp().getUserInfoSession();
			this.currentUserInfo = currentUserInfo;
			
			this.getCompanyInfo();
			
			this.getColletResumeCounts();
			this.getReadResumeRecordCounts();
			this.getJobCounts();
			this.getHrInterviewRecordCounts();
		},
		onLoad(e) {
			let res =uni.getSystemInfoSync()
			this.height = res.windowHeight;
			this.navbarRight = res.windowWidth;
		},
		onPageScroll : function(e) {
		    // console.log("滚动距离为：" + e.scrollTop);
			var that = this,
				scrollY = e.scrollTop;
			var opacity = scrollY / 200;
			opacity = opacity > 1 ? 1 : opacity;
			that.$set(that, 'opacity', opacity);
			that.$set(that, 'scrollY', scrollY);
			if (that.lock) {
				that.$set(that, 'lock', false);
				return;
			}
		},
		methods:{
			getHrInterviewRecordCounts() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/hr/getInterviewRecordCounts?hrId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var hrAllInterviewCounts = result.data.data;
							console.log(hrAllInterviewCounts);
							me.hrAllInterviewCounts = hrAllInterviewCounts;
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
			
			getJobCounts() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/job/hr/jobCounts?hrId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var hrAllJobCounts = result.data.data;
							console.log(hrAllJobCounts);
							me.hrAllJobCounts = hrAllJobCounts;
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
			
			getReadResumeRecordCounts() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/getReadResumeRecordCounts?hrId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var hrReadResumeRecordCounts = result.data.data;
							console.log(hrReadResumeRecordCounts);
							me.hrReadResumeRecordCounts = hrReadResumeRecordCounts;
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
			
			getColletResumeCounts() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/getColletResumeCounts?hrId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var hrCollectResumeCounts = result.data.data;
							console.log(hrCollectResumeCounts);
							me.hrCollectResumeCounts = hrCollectResumeCounts;
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
			
			getCompanyInfo() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/information?hrUserId=" + userId,
					success(result) {
						console.log(result);
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
			
			goScan() {
				uni.scanCode({
					success: (e) => {
						var qrToken = e.result;
						console.log("qrToken = " + qrToken);
						
						var serverUrl = app.globalData.serverUrl;
						var userId = app.getUserInfoSession().id;
						// 扫码登录
						uni.request({
							method: "POST",
							url: serverUrl + "/saas/scanCode?qrToken=" + qrToken,
							header: {
								"appUserId": userId,
								"appUserToken": app.getUserSessionToken()
							},
							success(result) {
								var status = result.data.status;
								if (status == 200) {
									var preToken = result.data.data;
									console.log("preToken=" + preToken);
									
									uni.showModal({
										title: "您将登录企业SAAS后台管理，确认登录吗？",
										cancelText: "不了，我再想想",
										confirmText: "确定，我要登录",
										confirmColor: "#31B9B3",
										success(e) {
											if (e.confirm) {
												// 点击确认，请求后端登录
												uni.request({
													method: "POST",
													url: serverUrl + "/saas/goQRLogin?userId=" + userId + "&qrToken=" + qrToken + "&preToken=" + preToken,
													success(result) {
														// do nothing
													}
												});
												
											}
										}
									})
									
								} else if (status != 200) {
									uni.showToast({
										title: result.data.msg,
										icon: "none",
										duration: 3000
									});
								}
							},
							fail(e) {
								console.log(e);
							}
						});
						
						
						
					}
				})
				// uni.navigateTo({
				// 	url: "qrcode",
				// 	animationType: "slide-in-bottom",
				// 	success() {
						
				// 	}
				// })
			},
			
			goto() {
				app.changeToCandidate();
			},
			doUpgrade() {
				uni.showModal({
				    title: '提示',
				    content: '请登录企业后台进行VIP升级',
				    success: function (res) {
				        // if (res.confirm) {
				        //     console.log('用户点击确定');
				        // } else if (res.cancel) {
				        //     console.log('用户点击取消');
				        // }
				    }
				});
			},
			scroll: function(e) {
				var that = this,
					scrollY = e.detail.scrollTop;
				var opacity = scrollY / 200;
				opacity = opacity > 1 ? 1 : opacity;
				that.$set(that, 'opacity', opacity);
				that.$set(that, 'scrollY', scrollY);
				if (that.lock) {
					that.$set(that, 'lock', false);
					return;
				}
			},
			
			goToCompanyPage() {
				var companyInfo = this.companyInfo;
				var companyId = companyInfo.id;
				console.log("companyId = " + companyId);
				uni.navigateTo({
					url: "./companyPage/companyPage?type=" + this.userType.hr + "&companyId=" + companyId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoMyCollectResume() {
				console.log(11)
				uni.navigateTo({
					url: "./statistics/collectResume",
					animationType: "slide-in-bottom",
				});
			},
			gotoMyReadResume() {
				uni.navigateTo({
					url: "./statistics/readResume",
					animationType: "slide-in-bottom",
				});
			},
			gotoMyPositionList() {
				uni.switchTab({
					url: "job"
				});
			},
			gotoMyInterview() {
				uni.navigateTo({
					url: "./interview/pendingList",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			goToHRPage() {
				uni.navigateTo({
					url: "./hrPage?type=" + this.userType.hr,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToHRInfo() {
				uni.navigateTo({
					url: "./hrInfo?type=" + this.userType.hr,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToSettings() {
				uni.navigateTo({
					url: "../others/settings",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToAboutUs() {
				uni.navigateTo({
					url: "../others/aboutUs",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToPrivacy() {
				uni.navigateTo({
					url: "../others/privacyRule",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToMyCourses() {
				uni.navigateTo({
					url: "../others/moreCourse",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			changeToCandidate() {
				uni.switchTab({
					url: "../welcome/changePerson"
				});
				
				// uni.navigateTo({
				// 	url: "../welcome/changePerson",
				// 	animationType: "slide-in-bottom",
				// 	success() {
				// 	}
				// });
				
				
				// var candUserType = this.userType.candidate;
				// uni.setStorageSync('userType', candUserType);
				// app.changeToCandidate();
			},
			
		}
	}
</script>

<style>
	@import url("me.css");
</style>
