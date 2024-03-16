<!-- 职位详情 -->
<template>
	<view>
		
		<view class="navigation-bar" style="background-color: #ffffff; z-index: 99999;">
			<view class="nav-left-part">
				<image src="../../static/icons/hr/icon-goback.png" class="back-icon" @click="goback()"></image>
				
				<text class="nav-name-words" :style="{opacity: opacity }">{{jobDetail.jobName}}</text>
				<text class="salray-words" :style="{opacity: opacity }">({{jobDetail.beginSalary}}-{{jobDetail.endSalary}}K·{{jobDetail.monthlySalary}}薪)</text>
			</view>
			
			<view class="icons">
				<image src="../../static/icons/report-police.png" class="like-icon" @click="report()"></image>
				
				<image v-show="!isLike" src="../../static/icons/hr/icon-unlike.png" class="like-icon" @click="addCollectJob()"></image>
				<image v-show="isLike" src="../../static/icons/hr/icon-like.png" class="like-icon" @click="removeCollectJob()"></image>
			</view>
		</view>
		
		<view class="card-box">
			
			<view class="title-wrapper">
				<view class="title-line-one">
					<text class="title-one">{{jobDetail.jobName}}</text>
					<text class="money-two">{{jobDetail.beginSalary}}-{{jobDetail.endSalary}}K·{{jobDetail.monthlySalary}}薪</text>
				</view>
				<view class="title-line-two">
					<view class="small-wrapper">
						<image src="../../static/icons/company/job-location.png" class="small-icon"></image>
						<text class="small-text">{{jobDetail.city}}</text>
					</view>
					<view class="small-wrapper">
						<image src="../../static/icons/company/job-college.png" class="small-icon"></image>
						<text class="small-text">{{jobDetail.edu}}</text>
					</view>
					<view class="small-wrapper">
						<image src="../../static/icons/company/job-years.png" class="small-icon"></image>
						<text class="small-text">{{jobDetail.expYears}}</text>
					</view>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="title-wrapper" style="" @click="gotoLookHR()">
				<view class="company-info-wrapper" style="margin-top: 6px; margin-bottom: 6px;">
					<image :src="currentHRInfo.face" class="company-logo"></image>
					
					<view class="company-box">
						<text class="company-name">{{currentHRInfo.nickname}}</text>
						
						<view class="company-small-box">
							<text class="company-small-text">{{companyInfo.shortName}}</text>
							<text class="company-small-text">·</text>
							<text class="company-small-text">{{currentHRInfo.position}}</text>
						</view>
						
					</view>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="title-wrapper" style="margin-top: 0px;">
				<view class="title-line-one">
					<text class="job-introduce-text">职位介绍</text>
				</view>
				
				<view class="tags-wrapper">
					<text class="job-tags" v-for="(t, index) in tagsArray" :key="index">{{t}}</text>
					<!-- <text class="job-tags">架构师</text> -->
				</view>
				
				<view class="job-introduce-content">
					<text class="job-introduce-words">{{jobDetail.jobDesc}}</text>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="title-wrapper" style="">
				<view class="title-line-one">
					<text class="job-introduce-text">公司信息</text>
				</view>
				
				<view class="company-info-wrapper" @click="gotoLookCompany(companyInfo.id)">
					<image :src="companyInfo.logo" class="company-logo"></image>
					
					<view class="company-box">
						<text class="company-name">{{companyInfo.companyName}}</text>
						
						<view class="company-small-box">
							<text class="company-small-text">{{companyInfo.peopleSize}}</text>
							<text class="company-small-split">|</text>
							<text class="company-small-text">{{companyInfo.nature}}</text>
							<text class="company-small-split">|</text>
							<text class="company-small-text">{{companyInfo.industry}}</text>
						</view>
						
						<view class="company-small-box">
							<text class="company-small-text">地址：{{companyInfo.address}}</text>
						</view>
					</view>
				</view>
			</view>
			
		</view>
		
		<!-- <view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view> -->
		
		
		<view class="chat-wrapper">
			<view class="btn-chat-wrapper" @click="chatWithHR()">
				<text class="btn-chat-words">立即沟通</text>
			</view>
		</view>
		
		<!-- 输入框示例 -->
		<uni-popup ref="inputDialog" type="dialog">
			<uni-popup-dialog ref="inputClose"  mode="input" title="举报职位" value=""
				placeholder="请输入举报原因" @confirm="dialogInputConfirm"></uni-popup-dialog>
		</uni-popup>
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				isLike: false,
				jobId: "",
				jobDetail: {},
				tagsArray: [],
				companyInfo: {},
				currentHRInfo: {},
				
				background:{backgroundColor:'#fd5365'},
				height:0,
				navbarRight:0,
				opacity: 0,
				scrollY: 0,
				
				hrId: "",
			}
		},
		onLoad(options) {
			let res =uni.getSystemInfoSync()
			this.height = res.windowHeight;
			this.navbarRight = res.windowWidth;
			
			
			var jobId = options.jobId;
			if (jobId != undefined && jobId != "" && jobId != null) {
				this.jobId = jobId;
			}
		
			var hrId = options.hrId;
			if (hrId != undefined && hrId != "" && hrId != null) {
				this.hrId = hrId;
			}
			
			var companyId = options.companyId;
			if (companyId != undefined && companyId != "" && companyId != null) {
				this.companyId = companyId;
			}
			
			this.getJobDetail(jobId, hrId, companyId)
			this.isCandCollectJob(jobId);
		},
		onShow() {
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
		methods: {
			
			isCandCollectJob(jobId) {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/isCandCollectJob?candUserId=" + userId + "&jobId=" + jobId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var isLike = result.data.data;
							console.log(isLike);
							me.isLike = isLike;
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
			
			// inputDialogToggle() {
			// 	this.$refs.inputDialog.open()
			// },
			
			report() {
				this.$refs.inputDialog.open()
			},
			
			dialogClose() {
				console.log('点击关闭')
			},
			dialogInputConfirm(val) {
				var reportReason = val
				
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var userNickname = getApp().getUserInfoSession().nickname;
				var jobId = this.jobId;
				
				var bo = {
					"jobId": jobId,
					"jobName": this.jobDetail.jobName,
					"companyName": this.companyInfo.companyName,
					"reportUserId": userId,
					"reportUserName": userNickname,
					"reportReason": reportReason
				}
				console.log(bo);
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					data: bo,
					url: serverUrl + "/report/create",
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							// 关闭窗口后，恢复默认内容
							me.$refs.inputDialog.close()
							
							uni.showToast({
								title: "感谢举报！我们一定核查到底~",
								icon: "none"
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
				
			},
			
			addCollectJob() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var jobId = this.jobId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/addCollectJob?candUserId=" + userId + "&jobId=" + jobId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							me.isLike = !me.isLike;
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
			
			removeCollectJob() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var jobId = this.jobId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/removeCollectJob?candUserId=" + userId + "&jobId=" + jobId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							me.isLike = !me.isLike;
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
			

			
			getJobDetail(jobId, hrId, companyId) {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/job/hr/jobDetail?hrId=" + hrId + "&companyId=" + companyId + "&jobId=" + jobId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var jobDetail = result.data.data;
							console.log(jobDetail);
							if (jobDetail != null ) {
								me.jobDetail = jobDetail;
								
								me.getCompanyInfo(jobDetail.companyId);
								me.getHRInfo(hrId);
								
								var tags = jobDetail.tags;
								if (tags != null && tags != "" && tags != undefined) {
									var tempArr = tags.split(",");
									me.tagsArray = [];
									for (var i = 0 ; i < tempArr.length ; i ++) {
										if (tempArr[i] != null && tempArr[i] != "" && tempArr[i] != undefined) {
											me.tagsArray.push(tempArr[i]);
										}
									}
								}	
							}
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
			
			getHRInfo(hrUserId) {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/userinfo/get?userId=" + hrUserId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var currentHRInfo = result.data.data;
							me.currentHRInfo = currentHRInfo;
							console.log(currentHRInfo);
							
							// me.signature = currentHRInfo.hrSignature;
							
							// var hrTags = currentHRInfo.hrTags;
							// var tagsArr = hrTags.split(",");
							// var myTags = [];
							// for (var i = 0 ; i < tagsArr.length ; i ++) {
							// 	var temp = tagsArr[i];
							// 	if (temp != null && temp != "" && temp != undefined) {
							// 		myTags.push(temp);
							// 	}
							// }
							// me.myTags = myTags;
							
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
					url: serverUrl + "/company/getInfo?companyId=" + companyId + "&withHRCounts=false",
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var companyInfo = result.data.data;
							me.companyInfo = companyInfo;
							
							console.log(companyInfo);
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
			
			// 候选人投递并且聊天
			goChatWithHR() {
				var hrUserId = this.hrId;
				
				uni.navigateTo({
					url: "messageList?hrUserId=" + hrUserId,
					animationType: "slide-in-right",
					success() {
					}
				});
			},
			
			chatWithHR(){
				var me = this;
				uni.showModal({
					title: "您将投递简历给对方，确认沟通吗？",
					cancelText: "不了，我再想想",
					confirmText: "确定，投递并沟通",
					confirmColor: "#31B9B3",
					success(e) {
						
						console.log(e.confirm)
						if (e.confirm) {
							me.goChatWithHR();
						}
						
					}
				})
			},
			
			gotoLookHR() {
				// http://localhost:8080/#/pages/hr/hrPage?type=2&hrUserId=1541299724478681090
				var hrUserId = this.hrId;
				uni.navigateTo({
					url: "../hr/hrPage?type=" + this.userType.candidate + "&hrUserId=" + hrUserId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoLookCompany(companyId) {
				uni.navigateTo({
					url: "../hr/companyPage/companyPage?companyId=" + companyId + "&type=" + this.userType.candidate,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			goback() {
				uni.navigateBack({
					delta: 1
				})
			},
			
			// like() {
			// 	this.isLike = 1;
			// },
			
			// unlike() {
			// 	this.isLike = 0;
			// },
			
		}
	}
</script>

<style>
	@import url("positionDetail.css");
</style>
