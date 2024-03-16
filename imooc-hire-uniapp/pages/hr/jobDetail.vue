<!-- 职位详情 -->
<template>
	<view>
		
		<view class="wraning-wrapper" v-show="jobDetail.status == 3">
			<text class="wraning-words">违规原因：{{jobDetail.violateReason}}</text>
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
			
			
			<view class="title-wrapper" style="margin-top: 50px;">
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
			
			<view class="title-wrapper" style="margin-top: 30px;">
				<view class="title-line-one">
					<text class="job-introduce-text">公司信息</text>
				</view>
				
				<view class="company-info-wrapper">
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
			
			<view class="buttons" v-show="jobDetail.status != 3">
				<view class="btn-edit-wrapper" @click="editJob()">
					<text class="btn-edit-words">编辑</text>
				</view>
				
				<view v-show="jobDetail.status == 1" class="btn-close-wrapper" @click="closeJob()">
					<text class="btn-close-words">关闭职位</text>
				</view>
				
				<view v-show="jobDetail.status == 2" class="btn-close-wrapper" @click="openJob()">
					<text class="btn-close-words">开放职位</text>
				</view>
			</view>
			
				
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				companyName: "",
				wordsLength: 0,
				disabled: true,
				
				companyExist: false,
				companyCheck: false,
				
				jobDescription: "",
				jobDescriptionPlaceholder: "1. 工作内容 \n2. 任务说明 \n3. 特别说明",
				
				jobStatus: 1,		// 招聘中
				// jobStatus: 2,		// 已关闭
				// jobStatus: 3,		// 违规职位
				
				jobId: "",
				jobDetail: {},
				tagsArray: [],
				companyInfo: {}
			}
		},
		onNavigationBarButtonTap() {
			// console.log(this.jobDescription);
			uni.setStorageSync("jobDescription", this.jobDescription);
			
			uni.navigateBack({
				delta: 1
			})
		},
		onShow() {
			this.wordsLength = this.companyName.length;
			var jobId = this.jobId;
			this.getJobDetail(jobId)
		},
		onLoad(options) {
			var jobId = options.jobId;
			if (jobId != undefined && jobId != "" && jobId != null) {
				this.jobId = jobId;
				this.getJobDetail(jobId)
			}
			
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
			
			getJobDetail(jobId) {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = app.getUserInfoSession().hrInWhichCompanyId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/job/hr/jobDetail?hrId=" + userId + "&companyId=" + companyId + "&jobId=" + jobId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var jobDetail = result.data.data;
							console.log(jobDetail);
							if (jobDetail != null ) {
								me.jobDetail = jobDetail;
								
								me.getCompanyInfo(jobDetail.companyId);
								
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
			
			editJob() {
				var jobId = this.jobId;
				uni.navigateTo({
					url: "./publishNewJob/publishNewJob?jobId=" + jobId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			openJob() {
				
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = app.getUserInfoSession().hrInWhichCompanyId;
				var jobId = this.jobId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/job/open?hrId=" + userId + "&companyId=" + companyId + "&jobId=" + jobId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							me.jobDetail.status = 1;
							uni.showToast({
								icon: "success",
								title: "操作成功"
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
			
			closeJob() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = app.getUserInfoSession().hrInWhichCompanyId;
				var jobId = this.jobId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/job/close?hrId=" + userId + "&companyId=" + companyId + "&jobId=" + jobId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							me.jobDetail.status = 2;
							uni.showToast({
								icon: "success",
								title: "操作成功"
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
			}
		}
	}
</script>

<style>
	@import url("jobDetail.css");
</style>
