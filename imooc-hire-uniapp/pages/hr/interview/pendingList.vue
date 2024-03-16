<!-- 待处理的面试 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper">
				<view class="title-line-one">
					<text class="title-one">待处理的面试</text>
				</view>
			</view>
			
			<!-- 查询今天往后的的所有[待处理]面试，按照时间由近及远排序 -->
			<view class="list-wrapper" v-for="(i, index) in interviewList" :key="index">
				<view class="left">
					<!-- <text>{{i.interviewTime}}</text> -->
					<text>{{DateUtil.formatWeekDatetime(new Date(Date.parse(i.interviewTime)))}}</text>
					<!-- <text>今天</text> -->
					<!-- <text>16:00</text> -->
				</view>
				<view :class="{'right': true, 
							'right-orange': i.status == 1, 
							'right-green': i.status == 2, 
							'right-gray': i.status == 3, 
							'right-red': i.status == 4}" @click="gotoDetail(i.id, i.hrUserId)">
					<view class="line-1">
						<text class="cand-name">{{i.candName}}</text>
						
						<view class="status-box">
							<image src="../../../static/icons/company/wait-accept.png" class="small-icon" v-show="i.status == 1"></image>
							<image src="../../../static/icons/company/interview-accept.png" class="small-icon" style="width: 18px;height: 18px;" v-show="i.status == 2"></image>
							<image src="../../../static/icons/company/interview-refuse.png" class="small-icon" style="width: 21px;height: 21px;" v-show="i.status == 3"></image>
							<image src="../../../static/icons/company/interview-cancel.png" class="small-icon" v-show="i.status == 4"></image>
							<text class="status-words">{{i.status == 1 ? "待接受" : ""}}</text>
							<text class="status-words">{{i.status == 2 ? "已接收" : ""}}</text>
							<text class="status-words">{{i.status == 3 ? "已拒绝" : ""}}</text>
							<text class="status-words">{{i.status == 4 ? "已取消" : ""}}</text>
						</view>
					</view>
					
					<view class="line-2">
						<text class="line-2-words">{{i.candPosition}}</text>
					</view>
					
					<view class="line-3">
						<text class="line-3-words">面试职位：</text>
						<text class="line-3-words" style="margin-left: 10px;">{{i.jobName}}</text>
					</view>
				</view>
			</view>
			
			<!-- <view class="list-wrapper">
				<view class="left">
					<text>今天</text>
					<text>16:00</text>
				</view>
				<view :class="{'right': true, 'right-orange': interviewStatus == 1, 'right-green': interviewStatus == 2}" @click="gotoDetail">
					<view class="line-1">
						<text class="cand-name">风间影月</text>
						
						<view class="status-box">
							<image src="../../../static/icons/company/wait-accept.png" class="small-icon" v-show="interviewStatus == 1"></image>
							<image src="../../../static/icons/company/wait-interview.png" class="small-icon" v-show="interviewStatus == 2"></image>
							<text class="status-words">待面试</text>
						</view>
					</view>
					
					<view class="line-2">
						<text class="line-2-words">北京慕课网软件开发有限公司</text>
						<text class="line-2-words">·</text>
						<text class="line-2-words">架构师</text>
					</view>
					
					<view class="line-3">
						<text class="line-3-words">面试</text>
						<text class="line-3-words" style="margin-left: 10px;">技术经理</text>
						<text class="line-3-words" style="margin-left: 6px;">20-50K</text>
					</view>
				</view>
			</view> -->
				
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				userIdentityType: 2		,// 默认为2
				
				interviewStatus: 1,		// 待接受
				// interviewStatus: 2,		// 待面试
				// interviewStatus: 3,		// 拒绝面试（）
				// interviewStatus: 4,		// 取消面试（）
				
				
				page: 1,	// 默认第1页
				limit: 10,	// 每页显示10条
				total: 0,	// 总共多少页
				interviewList: []
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
		onShow() {
			var me = this;
			var userType = uni.getStorageSync('userType');
			// 如果没有，默认设置为候选人
			if (userType == undefined || userType == "" || userType == null) {
				me.userIdentityType = me.userType.candidate;
			} else {
				if (userType == me.userType.hr) {
					me.userIdentityType = me.userType.hr;
				} else {
					me.userIdentityType = me.userType.candidate;
				}
			}
			
			this.getInterviewList(1);
		},
		onLoad() {
			
		},
		onReachBottom() {
			this.loadMore();
		},
		methods: {
			getInterviewList(page) {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var userIdentityType = this.userIdentityType;
				var routeUrl = "";
				
				if (userIdentityType == me.userType.hr) {
					var companyId = getApp().getUserInfoSession().hrInWhichCompanyId;
					routeUrl = "/interview/listOfHr?hrId=" + userId + "&companyId=" + companyId + "&page=" + page + "&limit=10";
				} else {
					routeUrl = "/interview/listOfCand?candUserId=" + userId + "&page=" + page + "&limit=10";
				}
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + routeUrl,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var list = result.data.data.rows;
							me.total = result.data.data.total;
							me.page = result.data.data.page;
							console.log(list);
							// console.log(me.jobList);
							if (page == 1) {
								me.interviewList = [];
							}
							me.interviewList = me.interviewList.concat(list);
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
			
			loadMore() {
				var page = this.page + 1;
				var total = this.total;
				if (page > total) {
					return;
				}
				this.getInterviewList(page);
			},
			
			gotoDetail(interviewId, hrUserId) {
				uni.navigateTo({
					url: "interviewDetail?interviewId=" + interviewId + "&hrUserId=" + hrUserId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
		}
	}
</script>

<style>
	@import url("pendingList.css");
</style>
