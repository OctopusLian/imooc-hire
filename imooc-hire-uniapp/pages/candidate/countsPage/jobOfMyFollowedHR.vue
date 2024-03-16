<!-- 我关注的HR所发布的职位 -->
<template>
	<view>
				
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
			
			<view class="job-box" v-for="(j, index) in allJobList" :key="index">
				
				<view class="every-cand" @click="gotoDetail()">
					<view class="name-info">
						<view class="info-words-wrapper">
							<text class="cand-name">Java技术经理</text>
							<!-- <text class="info" style="margin-top: 2px;">30岁 | 本科 | 8年 | 25-30K·14薪</text> -->
						</view>
						
						<text class="salray-words">30-50K</text>
					</view>
					
					<view class="cand-tags-wrapper">
						<text class="cand-tag">大数据</text>
						<text class="cand-tag">Java</text>
						<text class="cand-tag">微服务</text>
						<text class="cand-tag">AI</text>
					</view>
					
					<view class="cand-exp-wrapper">
						<view class="cand-line-info">
							<text class="line-info-words">北京某某某软件开发有限公司·300-500人·A轮</text>
						</view>
					</view>
					
					<view class="hr-wrapper">
						<view class="hr-info">
							<image src="../../../static/images/me.png" class="small-face"></image>
							<text class="hr-text" style="margin-left: 6px;">王大锤</text>
							<text class="hr-text" style="margin-left: 4px;">·</text>
							<text class="hr-text" style="margin-left: 4px;">人力资源总监</text>
						</view>
						
						<view class="area-box">
							<text>无锡</text>
							<text style="margin-left: 4px;">滨湖区</text>
						</view>
					</view>
				</view>
				
			</view>
			
		</scroll-view>
				
			
	</view>
</template>

<script>
	export default {
		data() {
			return {
				selectedJobId: "1001",
				hopeList: [
					{id: "1001", title: "Java开发"}, 
					{id: "1002", title: "大数据"}, 
					{id: "1003", title: "运维"},
					{id: "1004", title: "架构师"},
					{id: "1005", title: "技术经理"},
				],
				
				jobType: "",
				
				
				scrollHeight: uni.getSystemInfoSync().windowHeight,
				tabIndex: 0,
				
				triggered: false,
				isOpenRefresh: true,	// 是否开启下拉
				
				chosenLocationArea: "",
				
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
					},
					{
						"title": "Java初级",
						"status": 3,
						"city": "南京",
						"education": "大专",
						"workExperience": "3-5年",
						"salary": "15-20",
						"salaryMonth": 14,
					},
					{
						"title": "Java高级开发",
						"status": 2,
						"city": "深圳",
						"education": "本科",
						"workExperience": "3-5年",
						"salary": "30-50",
						"salaryMonth": 12,
					},
					{
						"title": "Java初级",
						"status": 3,
						"city": "南京",
						"education": "大专",
						"workExperience": "3-5年",
						"salary": "15-20",
						"salaryMonth": 14,
					},
					{
						"title": "Java高级开发",
						"status": 2,
						"city": "深圳",
						"education": "本科",
						"workExperience": "3-5年",
						"salary": "30-50",
						"salaryMonth": 12,
					},
					{
						"title": "Java初级",
						"status": 3,
						"city": "南京",
						"education": "大专",
						"workExperience": "3-5年",
						"salary": "15-20",
						"salaryMonth": 14,
					},
					{
						"title": "Java高级开发",
						"status": 2,
						"city": "深圳",
						"education": "本科",
						"workExperience": "3-5年",
						"salary": "30-50",
						"salaryMonth": 12,
					},
					{
						"title": "Java初级",
						"status": 3,
						"city": "南京",
						"education": "大专",
						"workExperience": "3-5年",
						"salary": "15-20",
						"salaryMonth": 14,
					},
					{
						"title": "Java高级开发",
						"status": 2,
						"city": "深圳",
						"education": "本科",
						"workExperience": "3-5年",
						"salary": "30-50",
						"salaryMonth": 12,
					},
					{
						"title": "Java初级",
						"status": 3,
						"city": "南京",
						"education": "大专",
						"workExperience": "3-5年",
						"salary": "15-20",
						"salaryMonth": 14,
					}
				],
			}
		},
		onShow() {
			// var selectedJobTypeForSearch = uni.getStorageSync("selectedJobTypeForSearch");
			// if (selectedJobTypeForSearch != undefined && selectedJobTypeForSearch != "") {
			// 	this.jobType = selectedJobTypeForSearch;
			// }
			
			var chosenLocationArea = uni.getStorageSync("chosenLocationArea");
			if (chosenLocationArea != undefined && chosenLocationArea != "") {
				this.chosenLocationArea = chosenLocationArea;
			} else {
				this.chosenLocationArea = ""
			}
			
		},
		onLoad() {
			const res = uni.getSystemInfoSync();
			// console.log(res.windowWidth);
			// console.log(res.windowHeight);
		},
		mounted() {
			
		},
		methods: {
			goArea() {
				uni.navigateTo({
					url: "chooseProvince",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoDetail() {
				uni.navigateTo({
					url: "../positionDetail",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			selectJob(jobId) {
				this.selectedJobId = jobId;
			},
			
			loadMoreJobs() {
				console.log(123)
				this.allJobList = this.allJobList.concat(this.allJobList);
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
		}
	}
</script>

<style>
	@import url("jobOfMyFollowedHR.css");
</style>
