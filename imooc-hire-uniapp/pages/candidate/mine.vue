<!-- 候选人 我的页面 -->
<template>
	<view>
		<view class="myInfo">
			<view class="title">
				<!-- <text class="title-text">慕聘网</text> -->
			</view>
			
			<view class="navigation-bar" style="z-index: 99999;" :style="{opacity: opacity }">
				<image v-if="currentUserInfo == null" src="../../static/images/me.png" class="small-face"></image>
				<image v-if="currentUserInfo != null" :src="currentUserInfo.face" class="small-face"></image>
				
				<view class="small-nickname">
					<text class="title-text" v-if="currentUserInfo == null">风间影月</text>
					<text class="title-text" v-if="currentUserInfo != null">{{currentUserInfo.nickname}}</text>
				</view>
			</view>
			
			
			<view class="options">
				<image src="../../static/icons/icon-settings.png" @click="goToSettings()" style="width: 22px;height: 22px;"></image>
			</view>
			
			<view class="real-me">
				<image v-if="currentUserInfo == null" src="../../static/images/me.png" class="my-face"></image>
				<image v-if="currentUserInfo != null" :src="currentUserInfo.face" class="my-face"></image>
				
				<view class="my-name-wrapper">
					<view class="my-name-box">
						<text v-if="currentUserInfo == null" class="my-name">风间影月</text>
						<text v-if="currentUserInfo != null" class="my-name">{{currentUserInfo.nickname}}</text>
					</view>
					<view class="edit-wrapper" @click="editResume()">
						<image src="../../static/icons/edit.png" class="icon-edit"></image>
						<view class="edit-my-resume-wrapper"><text class="edit-my-resume">我的在线简历</text></view>
					</view>
				</view>
			</view>
			
			<view class="numbers">
				<view class="num-item" @click="showMyLikedJob()">
					<text class="num-counts">{{candCollectJobCounts}}</text>
					<text class="num-text">收藏</text>
				</view>
				
				<view class="num-item" @click="showMyFollowedHR()">
					<text class="num-counts">{{candFollowHrCounts}}</text>
					<text class="num-text">关注</text>
				</view>
				
				<view class="num-item" @click="gotoMyInterview()">
					<text class="num-counts">{{candInterviewCounts}}</text>
					<text class="num-text">面试</text>
				</view>
				
				<view class="num-item" @click="showWhoLookMe()">
					<text class="num-counts">{{whoLookMeCounts}}</text>
					<text class="num-text">谁看过我</text>
				</view>
			</view>
			
			<view class="about-resume-box">
				<view class="about-resume">
					<view class="refresh-resume" style="margin-left: 10px;" @click="refreshResume()">
						<image src="../../static/icons/refresh.png" style="width: 20px;height: 20px;align-self: center;"></image>
						<text class="about-words">简历刷新</text>
						<text class="about-words-second">优先曝光</text>
					</view>
					
					<image src="../../static/icons/separator.png" class="separator" style="width: 22px;height: 22px;"></image>
					
					<view class="want-status" style="margin-right: 10px;" @click="gotoJobExpect()">
						<image src="../../static/icons/status.png" style="width: 20px;height: 20px;align-self: center;"></image>
						<text class="about-words">求职状态</text>
						<text class="about-words-second">洞悉意向</text>
					</view>
				</view>
			</view>
		</view>
		
		<view class="block-one">
			<view class="block-box">
				<view class="block-line" style="margin-top: 10px;">
					<view class="left-part">
						<image src="../../static/icons/account.png" style="width: 18px;height: 18px;align-self: center;"></image>
						<text class="left-part-words">我的账号</text>
					</view>
					
					<view class="right-part" @click="goToMyInfo()">
						<text class="right-part-words">个人信息修改</text>
						<image src="../../static/icons/right-arrow.png" style="width: 12px;height: 12px;align-self: center;"></image>
					</view>
				</view>
				
				<view class="block-line" style="margin-bottom: 10px;">
					<view class="left-part">
						<image src="../../static/icons/baobao.png" style="width: 16px;height: 16px;align-self: center;"></image>
						<text class="left-part-words">我要招人</text>
						<image v-show="!isHR && verifyStatus == 3" src="../../static/icons/msg-info.png" @click="goToVerifyingPage()" style="width: 16px;height: 16px;align-self: center;margin-left: 6px;"></image>
						<image v-show="!isHR && verifyStatus == 2" src="../../static/icons/msg-failed.png" @click="goToFailedPage()" style="width: 16px;height: 16px;align-self: center;margin-left: 6px;"></image>
						<image v-show="verifyStatus == 1" src="../../static/icons/msg-success.png" @click="goToSuccessPage()" style="width: 16px;height: 16px;align-self: center;margin-left: 6px;"></image>
					</view>
					
					<view class="right-part" @click="changeToHR()" >
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
		
		<!-- <button style="margin-top: 300rpx;" @click="changeToHR">我要招聘</button> -->
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
				
				isHR: true, 		// 当前身份是否是hr，true：是hr，false：不是hr
				/**
				 * 审核状态
				 * 0：未发起认证，
				 * 1：认证通过，直接跳转到hr的页面  
				 * 2：认证失败（页面显示）
				 * 3：等待审核（页面显示）
				 */
				verifyStatus: 0,
				
				currentUserInfo: null,
				companyInfo: null,
				
				resume: {},

				whoLookMeCounts: 0,
				candFollowHrCounts: 0,
				candCollectJobCounts: 0,
				candInterviewCounts: 0
			}
		},
		onShow() {
			// 获得用户信息
			var currentUserInfo = getApp().getUserInfoSession();
			this.currentUserInfo = currentUserInfo;
			
			if (currentUserInfo.role == 1) {
				this.isHR = false;
			} else if (currentUserInfo.role == 2) {
				this.isHR = true;
			}
			
			// 则获得企业信息
			this.getCompanyInfo();
			
			this.getMyResume();
			
			this.getWhoLookMeCounts();
			this.getCandFollowHrCounts();
			this.getCollectJobCounts();
			this.getCandInterviewRecordCounts();
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
			getCandInterviewRecordCounts() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/cand/getInterviewRecordCounts?candUserId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var candInterviewCounts = result.data.data;
							console.log(candInterviewCounts);
							me.candInterviewCounts = candInterviewCounts;
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
			
			getCollectJobCounts() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/getCollectJobCounts?candUserId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var candCollectJobCounts = result.data.data;
							console.log(candCollectJobCounts);
							me.candCollectJobCounts = candCollectJobCounts;
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
			
			getCandFollowHrCounts() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/getCandFollowHrCounts?candUserId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var candFollowHrCounts = result.data.data;
							console.log(candFollowHrCounts);
							me.candFollowHrCounts = candFollowHrCounts;
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
			
			getWhoLookMeCounts() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/getWhoLookMeCounts?candUserId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var whoLookMeCounts = result.data.data;
							console.log(whoLookMeCounts);
							me.whoLookMeCounts = whoLookMeCounts;
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
							console.log(companyInfo);
							if (companyInfo != null ) {
								me.companyInfo = companyInfo;
								me.verifyStatus = companyInfo.reviewStatus;
							}
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
			
			changeToHR() {
				
				var me = this;
				var isHR = me.isHR;
				
				// isHR 是 true，必定代表审核通过
				if (isHR) {
					// 跳转到hr页面
					uni.switchTab({
						url: "../welcome/changePerson"
					});
				} else {
					
					// ，如果正在审核中或者审核失败，则显示对应页面
					/**
					 * 判断当前的审核状态
					 * 如果未发起审核，则前往进入【入驻流程】
					 * 如果正在审核中，则显示 【审核中】页面
					 * 如果审核失败，则显示【审核失败】页面
					 * 如果审核成功，这个业务不会进入，因为审核成功 isHR则为true，这里进不来
					 */
					
					var verifyStatus = me.verifyStatus;
					if (verifyStatus == 0) {
						uni.showModal({
							title: "您当前不是HR，请绑定您的所在公司吧~",
							cancelText: "不了，我再想想",
							confirmText: "确定，我要绑定",
							confirmColor: "#31B9B3",
							success(e) {
								if (e.confirm) {
									
									// 跳转入驻认证流程
									uni.navigateTo({
										url: "../company/createHR",
										animationType: "slide-in-bottom",
										success() {
										}
									});
									
								}
							}
						})
					} else if (verifyStatus == 1) {
						// 跳转到hr页面
						uni.switchTab({
							url: "../welcome/changePerson"
						});
					} else if (verifyStatus == 2) {
						// 跳转到认证失败页面
						// uni.navigateTo({
						// 	url: "../company/verify/failed",
						// 	animationType: "slide-in-bottom",
						// 	success() {
						// 	}
						// });
						
						uni.showModal({
							title: "当前认证失败，确认重新审核认证吗？",
							cancelText: "不了，我再想想",
							confirmText: "确定，我要认证",
							confirmColor: "#31B9B3",
							success(e) {
								if (e.confirm) {
									
									// 跳转入驻认证流程
									uni.navigateTo({
										url: "../company/createHR",
										animationType: "slide-in-bottom",
										success() {
										}
									});
									
								}
							}
						})
						
					} else if (verifyStatus == 3) {
						// 跳转到认证审核中页面
						uni.navigateTo({
							url: "../company/verify/verifying",
							animationType: "slide-in-bottom",
							success() {
							}
						});
					}
					
					
				}
				
				
				// uni.navigateTo({
				// 	url: "../welcome/changePerson",
				// 	// url: "../hr/changeToCand",
				// 	animationType: "slide-in-bottom",
				// 	success() {
				// 	}
				// });
				
				// var hrUserType = this.userType.hr;
				// uni.setStorageSync('userType', hrUserType);
				// app.changeToHR();
			},
			
			editResume() {
				uni.navigateTo({
					url: "resume/editResume",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoJobExpect() {
				var resumeId = this.resume.id;
				var resumeStatus = this.resume.status;
				if (resumeStatus == null || resumeStatus == undefined || resumeStatus == "") {
					resumeStatus = "";
				}
				uni.navigateTo({
					url: "jobExpect/jobExpect?resumeId=" + resumeId + "&resumeStatus=" + resumeStatus,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			showMySendedJob() {
				uni.navigateTo({
					url: "countsPage/mySendedJob",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoMyInterview() {
				uni.navigateTo({
					url: "../hr/interview/pendingList",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			showWhoLookMe() {
				uni.navigateTo({
					url: "countsPage/whoLookMe",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			showMyFollowedHR() {
				uni.navigateTo({
					url: "countsPage/myFollowedHR",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			showMyLikedJob() {
				uni.navigateTo({
					url: "countsPage/myLikedJob",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			getMyResume(){
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/resume/queryMyResume?userId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var resume = result.data.data;
							console.log(resume);
							me.resume = resume;
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
			
			refreshResume() {
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				var resumeId = this.resume.id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/resume/refresh?userId=" + userId + "&resumeId=" + resumeId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							// var resume = result.data.data;
							// console.log(resume);
							
							uni.showToast({
								icon: "none",
								title: "简历刷新成功！",
								duration: 2000
							})
							
						} else {
							uni.showToast({
								title: result.data.msg,
								icon: "none",
								duration: 3000
							});
						}
					}
				});
				
				
				
				
			},
			
			goToMyInfo() {
				uni.navigateTo({
					url: "../hr/hrInfo?type=" + this.userType.candidate,
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
			
			goToFailedPage() {
				var companyInfo = this.companyInfo;
				uni.navigateTo({
					url: "../company/verify/failed?reviewReplay=" + companyInfo.reviewReplay,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToSuccessPage() {
				uni.navigateTo({
					url: "../company/verify/success",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToVerifyingPage() {
				uni.navigateTo({
					url: "../company/verify/verifying",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			
			
		}
	}
</script>

<style>
	@import url("mine.css");
</style>
