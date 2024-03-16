<!-- 候选人 收藏职位主页面 -->
<template>
	<view>
			
		<view class="job-box" v-for="(j, index) in allJobList" :key="index">
			
			<view class="every-cand" @click="gotoDetail()">
				<view class="name-info">
					<view class="info-words-wrapper">
						<text class="cand-name">{{j.jobName}}</text>
					</view>
					
					<text class="salray-words">{{j.beginSalary}}-{{j.endSalary}}K</text>
				</view>
				
				<view class="cand-tags-wrapper">
					<text class="cand-tag" v-for="(t, index) in j.tagsArray" :key="index">{{t}}</text>
				</view>
				
				<view class="cand-exp-wrapper">
					<view class="cand-line-info">
						<text class="line-info-words" v-if="j.companyInfoVO != null">{{j.companyInfoVO.companyName}}·{{j.companyInfoVO.peopleSize}}{{j.companyInfoVO.financStage != null ? '·'+j.companyInfoVO.financStage : ""}}</text>
					</view>
				</view>
				
				<view class="hr-wrapper">
					<view class="hr-info" v-if="j.usersVO != null">
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
			
			
	</view>
</template>

<script>
	var app = getApp();
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
				
				page: 0,
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
				],
			}
		},
		onShow() {
			
		},
		onLoad() {
			const res = uni.getSystemInfoSync();
			// console.log(res.windowWidth);
			// console.log(res.windowHeight);
			
			this.getPagedList(0);
		},
		onReachBottom() {
			this.loadMoreJobs();
		},
		methods: {
			
			getPagedList(page) {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/pagedCollectJobList?candUserId=" + userId + "&page=" + page + "&pageSize=5",
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var list = result.data.data;
							// console.log(me.total);
							// me.page = me.page + 1;
							console.log(list);
							
							if (page == 0) {
								me.allJobList = [];
							}
							me.allJobList = me.allJobList.concat(list);
							
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
				var page = this.page + 1;
				this.page = page;
				this.getPagedList(page);
			},
			
			
		}
	}
</script>

<style>
	@import url("myLikedJob.css");
</style>
