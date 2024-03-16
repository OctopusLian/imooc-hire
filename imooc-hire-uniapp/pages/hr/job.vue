<!-- HR 职位页面 -->
<template>
	<view>
			
		<view class="navigation-bar" style="z-index: 99999;">
			<text class="page-title">职位管理</text>
			
			<view class="publish-btn" @click="gotoPublishNewJob()">
				<image src="../../static/icons/hr/publish.png" class="publish-icon" @click="gotoPublishNewJob()"></image>
				<!-- <text class="new-job">发职位</text> -->
			</view>
		</view>
			
		<view class="tabs-box" style="z-index: 888;">
			<view class="tab-words-wrapper" @click="selectTab(0)"><text :class="tabIndex == 0 ? 'tab-words-selected' : 'tab-words'">全部</text></view>
			<view class="tab-words-wrapper" @click="selectTab(1)"><text :class="tabIndex == 1 ? 'tab-words-selected' : 'tab-words'">招聘中</text></view>
			<view class="tab-words-wrapper" @click="selectTab(2)"><text :class="tabIndex == 2 ? 'tab-words-selected' : 'tab-words'">已关闭</text></view>
			<view class="tab-words-wrapper" @click="selectTab(3)"><text :class="tabIndex == 3 ? 'tab-words-selected' : 'tab-words'">违规删除</text></view>
		</view>
		
			<scroll-view class="jobs" :style="{'height': scrollHeight + 'px'}"
				scroll-y="true" 
				:refresher-enabled="isOpenRefresh"
				@scroll="scroll"
				:refresher-triggered="triggered" 
				@refresherpulling="onPulling"
				@refresherrefresh="refreshJobList"
				lower-threshold="50" 
				@scrolltolower="loadMoreJobs()"
				style="padding-top: 12px;"
				>
				
				<view class="job-box" v-for="(j, index) in jobList" :key="index" @click="gotoJobDetail(j.id)">
					<view class="title-line">
						<text class="title">{{j.jobName}}</text>
						<text v-show="j.status==1" class="job-status open">招聘中</text>
						<text v-show="j.status==2" class="job-status close">已关闭</text>
						<text v-show="j.status==3" class="job-status violate">违规不可发布</text>
					</view>
					<view class="info-line">
						<text class="info">{{j.city}} | {{j.edu}} | {{j.expYears}} | {{j.beginSalary}}-{{j.endSalary}}K·{{j.monthlySalary}}薪</text>
					</view>
					
					<view class="line-wrapper" style="margin: 12px 0;"><view class="line" style="width: 100%;"></view></view>
				</view>
				
			</scroll-view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				scrollHeight: 500,
				tabIndex: 0,
				
				triggered: false,
				isOpenRefresh: true,	// 是否开启下拉
				
				page: 1,	// 默认第1页
				limit: 10,	// 每页显示10条
				total: 0,	// 总共多少页
				
				jobList:[],
				// 状态  1：招聘中，2：已关闭，3：违规
				allJobList:[
					{
						"title": "Java高级开发",
						"status": 1,
						"city": "北京",
						"education": "本科",
						"workExperience": "3-5年",
						"salary": "30-40",
						"salaryMonth": 13,
					},
					{
						"title": "Java高级开发",
						"status": 2,
						"city": "深圳",
						"education": "本科",
						"workExperience": "3-5年",
						"salary": "30-50",
						"salaryMonth": 12,
					}
				],
				openJobList:[
					{
						"title": "Java高级开发",
						"status": 1,
						"city": "北京",
						"education": "本科",
						"workExperience": "3-5年",
						"salary": "30-40",
						"salaryMonth": 13,
					}
				],
				closeJobList:[
					{
						"title": "Java高级开发",
						"status": 2,
						"city": "北京",
						"education": "本科",
						"workExperience": "3-5年",
						"salary": "30-40",
						"salaryMonth": 13,
					},
					{
						"title": "Java高级开发",
						"status": 2,
						"city": "北京",
						"education": "本科",
						"workExperience": "3-5年",
						"salary": "30-40",
						"salaryMonth": 13,
					}
				],
				violateJobList:[
					{
						"title": "Java高级开发",
						"status": 3,
						"city": "北京",
						"education": "本科",
						"workExperience": "3-5年",
						"salary": "30-40",
						"salaryMonth": 13,
					},
					{
						"title": "Java高级开发",
						"status": 3,
						"city": "北京",
						"education": "本科",
						"workExperience": "3-5年",
						"salary": "30-40",
						"salaryMonth": 13,
					}
				],
			}
		},
		onLoad() {
			this.selectTab(0);
			
			const res = uni.getSystemInfoSync();
			// console.log(res.windowWidth);
			// console.log(res.windowHeight);
			this.scrollHeight = res.windowHeight - 50;
			
			// #ifdef H5
			this.scrollHeight = res.windowHeight - 110;
			// #endif
			// #ifndef H5
			this.scrollHeight = res.windowHeight - 150;
			// #endif
			
			// this.getPagedList(1);
		},
		onShow() {
			
		},
		methods: {
			getPagedList(page, status) {
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				var companyId = app.getUserInfoSession().hrInWhichCompanyId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/job/hr/jobList?hrId=" + userId + "&companyId=" + companyId + "&page=" + page + "&limit=10&status=" + status,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var list = result.data.data.rows;
							me.total = result.data.data.total;
							me.page = result.data.data.page;
							console.log(list);
							// console.log(me.jobList);
							me.jobList = me.jobList.concat(list);
							
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
			
			selectTab(tabIndex) {
				this.tabIndex = tabIndex;
				this.jobList = [];
				this.getPagedList(1, tabIndex);
				return;
				if (tabIndex == 0) {
					// 全部
					this.jobList = this.allJobList;
				} else if (tabIndex == 1) {
					// 招聘中、已开放
					this.jobList = this.openJobList;
				} else if (tabIndex == 2) {
					// 已关闭
					this.jobList = this.closeJobList;
				} else if (tabIndex == 3) {
					// 违规删除
					this.jobList = this.violateJobList;
				}
			},
			loadMoreJobs() {
				console.log(123)
				
				var page = this.page + 1;
				var total = this.total;
				console.log("total=" + total)
				if (page > total) {
					return;
				}
				this.getPagedList(page, this.tabIndex);
				
				// this.jobList = this.jobList.concat(this.allJobList);
			},
			scroll: function(e) {
				// console.log(e)
			},
			refreshJobList() {
				console.log("refreshJobList");
				if (this._freshing) return;
					this._freshing = true;
					
					setTimeout(() => {
						this.triggered = false;
						this._freshing = false;
						
						this.jobList = [];
						this.getPagedList(1, this.tabIndex);
				}, 1000)
			},
			
			// 自定义下拉刷新控件被下拉
			onPulling(e) {
			  console.log("onpulling", e);
			  if (e.detail.deltaY < 0) return  // 防止上滑页面也触发下拉
			  this.triggered = true;
			},
			// 自定义下拉刷新被触发
			onRefresh() {
			  if (this._freshing) return;
			  this._freshing = true;
			  this.page++;
			  setTimeout(() => {
				this.triggered = false;
				this._freshing = false;
				// this.getData();
			  }, 1000);
			},
			// 自定义下拉刷新被复位
			onRestore() {
			  this.triggered = 'restore'; // 需要重置
			  // console.error("onRestore");
			},
			// 自定义下拉刷新被中止
			onAbort() {
			  console.error("onAbort");
			},
			
			gotoPublishNewJob() {
				uni.navigateTo({
					url: "publishNewJob/publishNewJob",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoJobDetail(jobId) {
				uni.navigateTo({
					url: "jobDetail?jobId=" + jobId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			}
			
			
		}
	}
</script>

<style>
	@import url("job.css");
</style>
