<!-- HR 推荐页面 -->
<!-- 
 重要！！！
 本页面在H5不兼容，需要在ios或者安卓端进行测试
 -->
<template>
	<view>
		
		<view class="top-box" style="">
			
			<view class="search-bar" style="z-index: 99999;">
				<view class="search-wrapper" style="">
					<view class="part-1" @click="chooseJobType()">
						<view class="industry-words-wrapper" >
							<text class="industry-words">{{jobType != "" && jobType != null ? jobType : '不限职类'}}</text>
						</view>
						<view class="choose-down-wrapper">
							<image src="../../static/icons/hr/choose-down.png" class="choose-down-icon"></image>
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
							<input 
								type="text" 
								:value="basicTitle" 
								placeholder="候选人 | 优势 | 资格证书 | 技能" 
								placeholder-class="placeholder" 
								class="search-content"
								@input="typingContent"/>
						</view>
					</view>
				</view>
				
				<view class="search-btn" @click="doSearch">
					<text>搜索</text>
				</view>
			</view>
			
			<!-- <view class="cand-tabs" style="">
				<view class="whole-line" style="margin-left: 0px;">
					<scroll-view scroll-x="true" class="tag-scroll">
						<block v-for="(job, index) in jobList" :key="index" class="">
							<view class="tag-item" @click="selectJob(job.id)">
								<text :class="{'tag-txt-selected': selectedJobId == job.id, 'tag-txt': selectedJobId != job.id}">{{job.title}}</text>
							</view>
						</block>
					</scroll-view>
				</view>
			</view> -->
			
			<view class="search-options" style="z-index: 777;">
				<view class="options-left" style="">
					<text class="default-words">推荐</text>
				</view>
				<view class="options-right" @click="goConditions()">
					<text class="choose-words">筛选</text>
					<image src="../../static/icons/hr/option-down-icon.png" class="option-down-icon"></image>
				</view>
			</view>
		</view>
			
		<!-- 根据职位的关键字去匹配简历的关键字与title（es）查询最新简历 -->

		<scroll-view class="jobs" :style="{'height': scrollHeight + 'px'}"
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
			
			<view class="job-box" v-for="(r, index) in allResumeList" :key="index">
				
				<!-- gotoDetail(userId, resumeId, nickname, face) -->
				<view class="every-cand" @click="gotoDetail(r.userId, r.resumeId, r.nickname, r.face, r.workYears, r.education, r.age, r.resumeExpectId)">
					<view class="name-info">
						<view class="info-words-wrapper">
							<text class="cand-name">{{r.jobType}} · {{r.nickname}}</text>
							<text class="info" style="margin-top: 2px;">{{r.age}}岁 | {{r.education}} | {{r.workYears}}年 | {{r.beginSalary}}-{{r.endSalary}}K</text>
						</view>
						<image :src="r.face" class="small-face"></image>
					</view>
					
					<view class="cand-exp-wrapper">
						<view class="cand-line-info">
							<image src="../../static/icons/company2.png" class="small-gray-icon"></image>
							<text class="line-info-words">{{r.companyName}}·{{r.position}}</text>
						</view>
						<view class="cand-line-info">
							<image src="../../static/icons/college.png" class="small-gray-icon"></image>
							<text class="line-info-words">{{r.school}}·{{r.major}}</text>
						</view>
					</view>
					
					<view class="cand-tags-wrapper">
						<text class="cand-tag" v-for="(t, index) in getTagsArray(r.skills)" :key="index">{{t}}</text>
						<!-- <text class="cand-tag" getTagsArray>大数据</text>
						<text class="cand-tag">Java</text>
						<text class="cand-tag">微服务</text>
						<text class="cand-tag">AI</text> -->
					</view>
					
					<view class="desc-content">
						{{r.advantage}}
					</view>
				</view>
				
			</view>
			
		</scroll-view>
				
			
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				selectedJobId: "1001",
				jobList: [
					{id: "1001", title: "Java高级工程师"}, 
					{id: "1002", title: "大数据高级工程师"}, 
					{id: "1003", title: "运维高级工程师"},
					{id: "1004", title: "架构师"},
					{id: "1005", title: "技术经理"},
				],
				
				jobType: "",
				
				
				scrollHeight: 500,
				tabIndex: 0,
				
				triggered: false,
				isOpenRefresh: true,	// 是否开启下拉
				
				basicTitle: "",
				resumesConditions: {
					ageRange: [0, 65],
					sex: -1,				// -1：不限 	1：男  0：女
					activeTime: "", 		// '': 不限， just: 刚刚， today: 今日， threeDays: 三天内， thisweek: 本周， thismonth: 本月
					workYears: "", 			// '': 不限， less1: 1年以下， between13: 1-3年， between35: 3-5年， between510: 5-10年，more10: 10年以上，
					education: "", 			// '': 不限， junior: 初中及以下， technical: 中专/技校， high: 高中， juniorCollege: 大专，underGraduate: 本科，master: 硕士，MBA: MBA，doctor: 博士
					salary: "",				// '': 不限， less5k: 5k以下， between5k10k: 5-10k，between10k15k: 10-15k，between15k20k: 15-20k，between20k30k: 20-30k，between30k50k: 30-50k，more50k: 50k以上，
					jobStatus: "",
				},
				page: 1,	// 默认第1页
				limit: 10,	// 每页显示10条
				total: 0,	// 总共多少页
				allResumeList: [],
				
				allJobList:[
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
			}
		},
		onShow() {
			var selectedJobType = uni.getStorageSync("selectedJobType");
			if (selectedJobType != undefined && selectedJobType != "" && selectedJobType != null) {
				this.jobType = selectedJobType;
			} else {
				this.jobType = "";
			}
			
			var searchResumesConditions = uni.getStorageSync("searchResumesConditions");
			// console.log(searchResumesConditions);
			if (searchResumesConditions != undefined && searchResumesConditions != "" && searchResumesConditions != null) {
				this.resumesConditions = JSON.parse(searchResumesConditions);
				// console.log(this.resumesConditions);
			} else {
				this.resumesConditions = {
					ageRange: [0, 65],
					sex: -1,				// -1：不限 	1：男  0：女
					activeTime: "", 		// '': 不限， just: 刚刚， today: 今日， threeDays: 三天内， thisweek: 本周， thismonth: 本月
					workYears: "", 			// '': 不限， less1: 1年以下， between13: 1-3年， between35: 3-5年， between510: 5-10年，more10: 10年以上，
					education: "", 			// '': 不限， junior: 初中及以下， technical: 中专/技校， high: 高中， juniorCollege: 大专，underGraduate: 本科，master: 硕士，MBA: MBA，doctor: 博士
					salary: "",				// '': 不限， less5k: 5k以下， between5k10k: 5-10k，between10k15k: 10-15k，between15k20k: 15-20k，between20k30k: 20-30k，between30k50k: 30-50k，more50k: 50k以上，
					jobStatus: "",
				};
			}
			
			
			// 如果从条件筛选页面跳回，则需要重新查询，否则不需要
			var needRefresh = uni.getStorageSync("searchResumeNeedRefresh");
			if (needRefresh != undefined && needRefresh != "" && needRefresh != null && needRefresh == "yes") {
				console.log("searchResumeNeedRefresh");
				this.getPagedList(1);
				uni.removeStorageSync("searchResumeNeedRefresh");
			} 
			
		},
		onLoad() {
			const res = uni.getSystemInfoSync();
			// console.log(res.windowWidth);
			// console.log(res.windowHeight);
			this.scrollHeight = res.windowHeight - 50;
			
			// #ifdef H5
			// this.scrollHeight = res.windowHeight - 100 - 60;
			this.scrollHeight = res.windowHeight - 100 - 20;
			// #endif
			// #ifndef H5
			// this.scrollHeight = res.windowHeight - 110 - 80;
			this.scrollHeight = res.windowHeight - 110 - 40;
			// #endif
			
			// 第一次载入页面的时候，清除所有条件进行搜索
			uni.removeStorageSync("searchResumesConditions");
			console.log("onLoad - 111");
			this.getPagedList(1);
		},
		mounted() {
			
		},
		methods: {
			getTagsArray(tags) {
				
				var tagsArray = [];
				
				if (tags != null && tags != "" && tags != undefined) {
					var tempArr = tags.split(",");
					for (var i = 0 ; i < tempArr.length ; i ++) {
						if (tempArr[i] != null && tempArr[i] != "" && tempArr[i] != undefined) {
							tagsArray.push(tempArr[i]);
						}
					}
				}	
				
				return tagsArray;
			},
			
			doSearch() {
				console.log("doSearch - 222");
				this.getPagedList(1);
			},
			
			getPagedList(page) {
				
				
				var condition = this.resumesConditions;
				
				var searchBO = {
					"basicTitle": this.basicTitle,
					"jobType": this.jobType,
					"beginAge": condition.ageRange[0],
					"endAge": condition.ageRange[1],
					"sex": condition.sex,
					"activeTime": condition.activeTime,
					"workExpYears": condition.workYears,
					"beginWorkExpYears": 0,
					"endWorkExpYears": 0,
					"edu": condition.education,
					"beginSalary": 0,
					"endSalary": 0,
					"jobStatus": condition.jobStatus,
				};
				
				
				var workYears = condition.workYears;
				if (workYears == "less1") {
					searchBO.beginWorkExpYears = 0;
					searchBO.endWorkExpYears = 1;
				} else if (workYears == "between13") {
					searchBO.beginWorkExpYears = 1;
					searchBO.endWorkExpYears = 3;
				} else if (workYears == "between35") {
					searchBO.beginWorkExpYears = 3;
					searchBO.endWorkExpYears = 5;
				} else if (workYears == "between510") {
					searchBO.beginWorkExpYears = 5;
					searchBO.endWorkExpYears = 10;
				} else if (workYears == "more10") {
					searchBO.beginWorkExpYears = 10;
					searchBO.endWorkExpYears = 100;
				}

				var salary = condition.salary;
				if (salary == "less5k") {
					searchBO.beginSalary = 0;
					searchBO.endSalary = 5;
				} else if (salary == "between5k10k") {
					searchBO.beginSalary = 5;
					searchBO.endSalary = 10;
				} else if (salary == "between10k15k") {
					searchBO.beginSalary = 10;
					searchBO.endSalary = 15;
				} else if (salary == "between15k20k") {
					searchBO.beginSalary = 15;
					searchBO.endSalary = 20;
				} else if (salary == "between20k30k") {
					searchBO.beginSalary = 20;
					searchBO.endSalary = 30;
				} else if (salary == "between30k50k") {
					searchBO.beginSalary = 30;
					searchBO.endSalary = 50;
				} else if (salary == "more50k") {
					searchBO.beginSalary = 50;
					searchBO.endSalary = 1000;
				}
			
				console.log(searchBO);
				// return;
				var me = this;
				var userId = app.getUserInfoSession().id;
				var companyId = app.getUserInfoSession().hrInWhichCompanyId;
				searchBO.companyId = companyId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					data: searchBO,
					url: serverUrl + "/resume/searchResumes?page=" + page + "&limit=10",
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var list = result.data.data.rows;
							me.total = result.data.data.total;
							// console.log(me.total);
							me.page = result.data.data.page;
							console.log(list);
							
							
							if (page == 1) {
								me.allResumeList = [];
							}
							me.allResumeList = me.allResumeList.concat(list);
							
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
			
			goConditions() {
				uni.navigateTo({
					url: "recommendConditions",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			chooseJobType() {
				uni.navigateTo({
					url: "publishNewJob/chooseJobType",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			// gotoDetail(r.userId, r.resumeId, r.nickname, r.face, r.workYears, r.education, r.age, r.resumeExpectId)
			gotoDetail(userId, resumeId, nickname, face, workYears, education, age, resumeExpectId) {
				uni.navigateTo({
					url: "./recommendDetail?userId=" + userId + 
											"&resumeId=" + resumeId + 
											"&nickname=" + nickname + 
											"&face=" + face +
											"&workYears=" + workYears + 
											"&education=" + education + 
											"&age=" + age + 
											"&resumeExpectId=" + resumeExpectId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			selectJob(jobId) {
				this.selectedJobId = jobId;
			},
			
			loadMoreJobs() {
				var page = this.page + 1;
				var total = this.total;
				console.log("page=" + page)
				console.log("total=" + total)
				if (page > total) {
					return;
				}
				console.log("loadMoreJobs - 333");
				this.getPagedList(page);
			},
			scroll: function(e) {
				// console.log(e)
			},
			refreshJobList() {
				console.log("refreshJobList");
				if (this._freshing) return;
					this._freshing = true;
					setTimeout(() => {
						
						console.log("refreshJobList - 333");
						this.getPagedList(1);
						
						this.triggered = false;
						this._freshing = false;
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
			
			typingContent(e) {
				var event = e;
				this.basicTitle = e.detail.value;
			},
		}
	}
</script>

<style>
	@import url("recommend.css");
</style>

