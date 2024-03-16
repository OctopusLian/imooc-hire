<!-- 候选人 职位主页面 -->
<template>
	<view>
				
		<view class="top-box" style="">
			
			<view class="search-bar" style="z-index: 99999;">
				<view class="search-wrapper" style="">
					<view class="part-1">
						<!-- <view class="industry-words-wrapper" @click="chooseJobType()">
							<text class="industry-words">{{jobType != "" && jobType != null ? jobType : '不限职类'}}</text>
						</view> -->
						<view class="choose-down-wrapper">
							<image src="../../static/icons/candidate/icon-search.png" class="icon-search"></image>
						</view>
					</view>
					<!-- <view class="part-2">
						<view class="split-words-wrapper">
							<text class="split-words">|</text>
						</view>
					</view> -->
					<view class="part-3">
						<view class="split-words-wrapper" style="margin-right: 6px">
							<text class="split-words">|</text>
						</view>
						<view class="search-content-wrapper">
							<input type="text" :value="jobName" placeholder="架构师" placeholder-class="placeholder" class="search-content" @input="typingContent"/>
						</view>
					</view>
				</view>
				
				<view class="search-btn" style="" @click="doSearch">
					<text>搜索</text>
				</view>
			</view>
			
			<view class="cand-tabs" style="">
				<view class="whole-line" style="margin-left: 0px;">
					<scroll-view scroll-x="true" class="tag-scroll">
						
						<block v-for="(expect, index) in resumeExpectList" :key="index" class="">
							<view class="tag-item" @click="selectJob(expect.id)">
								<text :class="{'tag-txt-selected': selectedJobId == expect.id, 'tag-txt': selectedJobId != expect.id}">{{expect.jobName}}</text>
							</view>
						</block>
						<!-- <block v-for="(job, index) in hopeList" :key="index" class="">
							<view class="tag-item" @click="selectJob(job.id)">
								<text :class="{'tag-txt-selected': selectedJobId == job.id, 'tag-txt': selectedJobId != job.id}">{{job.title}}</text>
							</view>
						</block> -->
					</scroll-view>
				</view>
			</view>
			
			<view class="search-options" style="z-index: 777;">
				<view class="options-left" style="">
					<text class="default-words">综合</text>
				</view>
				<view class="options-right" @click="goArea()">
					<text class="choose-words">{{ (chosenLocationArea != null && chosenLocationArea != "") ? chosenLocationArea : '区域'}}</text>
					<image src="../../static/icons/hr/option-down-icon.png" class="option-down-icon"></image>
				</view>
			</view>
		</view>
			
		<!-- 根据职位的关键字去匹配简历的关键字与title（es）查询最新简历 -->

		<scroll-view v-if="allJobList.length > 0" class="jobs" :style="{'height': scrollHeight + 'px'}"
			scroll-y="true" 
			:refresher-enabled="isOpenRefresh"
			@scroll="scroll"
			:refresher-triggered="triggered" 
			@refresherpulling="onPulling"
			@refresherrefresh="refreshJobList"
			lower-threshold="50" 
			@scrolltolower="loadMoreJobs()"
			style=""
			>
			
			<view class="job-box" v-for="(j, index) in allJobList" :key="index">
				
				<view class="every-cand" @click="gotoDetail(j.id, j.hrId, j.companyId)">
					<view class="name-info">
						<view class="info-words-wrapper">
							<text class="cand-name">{{j.jobName}}</text>
						</view>
						
						<text class="salray-words">{{j.beginSalary}}-{{j.endSalary}}K</text>
					</view>
					
					<view class="cand-tags-wrapper">
						<text class="cand-tag" v-for="(t, index) in j.tagsArray" :key="index">{{t}}</text>
						<!-- <text class="cand-tag">Java</text> -->
					</view>
					
					<view class="cand-exp-wrapper">
						<view class="cand-line-info">
							<text class="line-info-words" v-if="j.companyInfoVO != null">{{j.companyInfoVO.companyName}}·{{j.companyInfoVO.peopleSize}}{{j.companyInfoVO.financStage != null ? '·'+j.companyInfoVO.financStage : ""}}</text>
						</view>
					</view>
					
					<view class="hr-wrapper">
						<view class="hr-info">
							<image :src="j.usersVO.face" class="small-face"></image>
							<text class="hr-text" style="margin-left: 6px;">{{j.usersVO == null ? "" : j.usersVO.nickname}}</text>
							<text class="hr-text" style="margin-left: 4px;">·</text>
							<text class="hr-text" style="margin-left: 4px;">{{j.usersVO == null ? "" : j.usersVO.position}}</text>
						</view>
						
						<view class="area-box">
							<text>{{j.city}}</text>
							<!-- <text style="margin-left: 4px;">滨湖区</text> -->
						</view>
					</view>
				</view>
				
			</view>
			
		</scroll-view>
				
		<view class="temp-content" v-if="allJobList.length == 0" :style="{'height': scrollHeight + 'px'}">
			
			<view class="no-result-wrapper">
				<image src="../../static/images/no-result.png" class="no-result"></image>
				<text class="no-result-text">暂时没有合适的职位噢~</text>
			</view>
			
		</view>
			
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				selectedJobId: "",
				hopeList: [
					{id: "", title: "全部"}, 
					{id: "1001", title: "Java开发"}, 
					{id: "1002", title: "大数据"}, 
					{id: "1003", title: "运维"},
					{id: "1004", title: "架构师"},
					{id: "1005", title: "技术经理"},
				],
				resumeExpectList: [],
				
				jobName: "",
				jobType: "",
				
				
				scrollHeight: 500,
				tabIndex: 0,
				
				triggered: false,
				isOpenRefresh: true,	// 是否开启下拉
				
				chosenLocationArea: "",
				
				page: 1,	// 默认第1页
				limit: 10,	// 每页显示10条
				total: 0,	// 总共多少页
				allJobList: [],
				allJobList2:[
					{
						"title": "Java高级开发",
						"status": 1,
						"city": "北京",
						"education": "本科",
						"workExperience": "3-5年",
						"salary": "30-40",
						"salaryMonth": 13,
					},
				],
			}
		},
		onShow() {
			// var selectedJobTypeForSearch = uni.getStorageSync("selectedJobTypeForSearch");
			// if (selectedJobTypeForSearch != undefined && selectedJobTypeForSearch != "") {
			// 	this.jobType = selectedJobTypeForSearch;
			// }
			
			var chosenLocationArea = uni.getStorageSync("chosenLocationArea");
			if (chosenLocationArea != undefined && chosenLocationArea != "" && chosenLocationArea != null) {
				this.chosenLocationArea = chosenLocationArea;
			} else {
				this.chosenLocationArea = ""
			}
			
			// 如果从城市选择页面调回，则需要重新查询，否则不需要
			var needRefresh = uni.getStorageSync("needRefresh");
			if (needRefresh != undefined && needRefresh != "" && needRefresh != null && needRefresh == "yes") {
				this.allJobList = [];
				this.getPagedList(1, this.jobName, this.selectedJobId);
				uni.removeStorageSync("needRefresh");
			} 
			
			this.initMyJobExpectList();
		},
		onLoad() {
			const res = uni.getSystemInfoSync();
			// console.log(res.windowWidth);
			// console.log(res.windowHeight);
			this.scrollHeight = res.windowHeight - 50;
			
			// #ifdef H5
			this.scrollHeight = res.windowHeight - 100 - 60;
			// #endif
			// #ifndef H5
			this.scrollHeight = res.windowHeight - 110 - 80;
			// #endif
			
			this.getPagedList(1, "", this.selectedJobId);
		},
		methods: {
			doSearch() {
				console.log(this.jobName);
				this.selectedJobId = "";
				this.allJobList = [];
				this.getPagedList(1, this.jobName, this.selectedJobId);
			},
			
			selectJob(jobId) {
				this.selectedJobId = jobId;
				this.allJobList = [];
				this.jobName = "";
				console.log("jobId=" + jobId);
				this.getPagedList(1, "", jobId);
			},
			
			getPagedList(page, jobName, expectId) {
				
				var searchBO = {
					"jobName": "",
					"jobType": "",
					"city": this.chosenLocationArea,
					"industry": "",
					"beginSalary": 0,
					"endSalary": 0,
				};

				if (jobName != null && jobName != "" && jobName != undefined) {
					// 如果用户输入的查询条件不为空，则不使用求职期望中的条件
					this.selectedJobId = "";
					expectId = "";
					searchBO.jobName = jobName;
				}
				
				if (expectId == null || expectId == "" || expectId == undefined) {
					// 默认查询全部，不携带 求职期望的条件
				} else {
					// 不为空，则把条件带出来
					var expectArr = this.resumeExpectList;
					for (var i = 0 ; i < expectArr.length ; i ++) {
						console.log("expectId=" + expectId);
						console.log("expectArr[i]=" + expectArr[i]);
						if (expectArr[i].id == expectId) {
							searchBO.jobType = expectArr[i].jobName;
							searchBO.industry = expectArr[i].industry;
							searchBO.beginSalary = expectArr[i].beginSalary;
							searchBO.endSalary = expectArr[i].endSalary;
							break;
						}
					}
				}
				console.log(searchBO);
				
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
					data: searchBO,
					url: serverUrl + "/job/searchJobs?page=" + page + "&limit=10",
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var list = result.data.data.rows;
							me.total = result.data.data.total;
							// console.log(me.total);
							me.page = result.data.data.page;
							// console.log(list);
							
							for (var i = 0 ; i < list.length ; i ++) {
								var tempTags = list[i].tags;
								if (tempTags != null && tempTags != "" && tempTags != undefined) {
									var tempArr = tempTags.split(",");
									var tagsArray = [];
									for (var j = 0 ; j < tempArr.length ; j ++) {
										if (tempArr[j] != null && tempArr[j] != "" && tempArr[j] != undefined) {
											tagsArray.push(tempArr[j]);
										}
									}
									list[i].tagsArray = tagsArray;
								}	
							}
							
							console.log(list);
							
							
							// console.log(me.jobList);
							me.allJobList = me.allJobList.concat(list);
							
							
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
			
			initMyJobExpectList() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var resumeId = this.resumeId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/resume/getMyResumeExpectList?resumeId=" + resumeId + "&userId=" + userId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var resumeExpectList = result.data.data;
							console.log(resumeExpectList);
							me.resumeExpectList = resumeExpectList;
							me.resumeExpectList.splice(0, 0, {id: "", jobName: "全部"});
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
			
			typingContent(e) {
				var event = e;
				this.jobName = e.detail.value;
			},
			
			goArea() {
				uni.navigateTo({
					url: "chooseProvince",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoDetail(jobId, hrId, companyId) {
				uni.navigateTo({
					url: "positionDetail?jobId=" + jobId + "&hrId=" + hrId + "&companyId=" + companyId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			
			
			loadMoreJobs() {
				// this.allJobList = this.allJobList.concat(this.allJobList);
				
				var page = this.page + 1;
				var total = this.total;
				console.log("total=" + total)
				if (page > total) {
					return;
				}
				this.getPagedList(page, this.jobName, this.selectedJobId);
			},
			scroll: function(e) {
				// console.log(e)
			},
			refreshJobList() {
				// console.log("refreshJobList");
				// if (this._freshing) return;
				// 	this._freshing = true;
				// 	setTimeout(() => {
				// 		this.triggered = false;
				// 		this._freshing = false;
				// }, 1000)
				
				console.log("refreshJobList");
				if (this._freshing) return;
					this._freshing = true;
					setTimeout(() => {
						
						
						this.allJobList = [];
						this.getPagedList(1, this.jobName, this.selectedJobId);
						
						this.triggered = false;
						this._freshing = false;
				}, 800)
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
			  // this.page++;
			  setTimeout(() => {
				this.triggered = false;
				this._freshing = false;
				
				// this.jobList = [];
				// this.getPagedList(1, this.jobName, this.selectedJobId);
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
		}
	}
</script>

<style>
	@import url("position.css");
</style>
