<!-- 待处理的面试 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 20px;">
				<text class="title-one">选择面试职位</text>
				<text class="title-two">请选择与候选人匹配的职位发起面试邀约</text>
			</view>
			
			
			<radio-group class="radio-group" style="margin-top: 30px;">
				
				<block v-for="(j, index) in jobList" :key="index">
					<view class="radio-item" style="display: flex; justify-content: space-between;">
						<view class="job-box">
							<view class="title-line">
								<text class="title">{{j.jobName}}</text>
							</view>
							<view class="info-line">
								<text class="info">{{j.city}} | {{j.edu}} | {{j.expYears}} | {{j.beginSalary}}k-{{j.endSalary}}·{{j.monthlySalary}}薪</text>
							</view>
						</view>
						
						<radio :checked="checked == index" @click="chooseMe(index)" style="align-self: center;"/>
					</view>
					
					<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				</block>
				
			</radio-group>
			
			<view class="btn-wrapper" @click="confirmChoose">
				<text class="btn-words">确认选择</text>
			</view>
		</view>
		
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				checked: 0,
				choosenIndex: 0,
				
				page: 1,	// 默认第1页
				limit: 10,	// 每页显示10条
				total: 0,	// 总共多少页
				
				jobList:[
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
		onNavigationBarButtonTap() {
			uni.navigateTo({
				url: "interviewRecord",
				animationType: "slide-in-bottom",
				success() {
				}
			});
		},
		onReachBottom() {
			this.loadMoreJobs();
		},
		onShow() {
		},
		onLoad() {
			this.getPagedList(1);
		},
		methods: {
			getPagedList(page) {
				
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
					url: serverUrl + "/job/hr/jobList?hrId=" + userId + "&companyId=" + companyId + "&page=" + page + "&limit=10&status=1",
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var list = result.data.data.rows;
							me.total = result.data.data.total;
							me.page = result.data.data.page;
							console.log(list);
							// console.log(me.jobList);
							if (page == 1) {
								me.jobList = [];
							}
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
			
			loadMoreJobs() {
				var page = this.page + 1;
				var total = this.total;
				console.log("total=" + total)
				if (page > total) {
					return;
				}
				this.getPagedList(page);
			},
			
			confirmChoose() {
				var choosenIndex = this.choosenIndex;
				uni.setStorageSync("choosenInterviewJob", this.jobList[choosenIndex]);
				console.log(this.jobList[choosenIndex]);
				uni.navigateBack({
					delta: 1
				})
			},
			
			chooseMe(index) {
				this.choosenIndex = index;
				// console.log(this.jobList[index]);
			},
			
			gotoDetail() {
				uni.navigateTo({
					url: "interviewDetail",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
		}
	}
</script>

<style>
	@import url("chooseJobList.css");
</style>
