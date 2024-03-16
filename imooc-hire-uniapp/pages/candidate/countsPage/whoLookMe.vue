<!-- 谁看过我页面 -->
<template>
	<view>
		
		<!-- v-for="(j, index) in allHRList" :key="index" -->
		<view class="job-box" v-for="(hr, index) in allHRList" :key="index">
			
			<view class="every-cand" @click="gotoHRDetail(hr.hrId)">
				<view class="hr-wrapper">
					<view class="hr-info">
						<image :src="hr.hrFace" class="small-face"></image>
						
						<view class="hr-info-right">
							<view class="hr-info-right-top">
								<text class="hr-text" style="margin-left: 6px;">{{hr.hrNickname}}</text>
							</view>
							<view class="hr-info-right-bottom">
								<text class="hr-company-text" style="margin-left: 6px;">{{hr.hrCompanyName}}</text>
								<text class="hr-company-text" style="margin-left: 2px;">·</text>
								<text class="hr-company-text" style="margin-left: 2px;">{{hr.hrPosition}}</text>
							</view>
						</view>
					</view>
					
					<view class="area-box">
						<image src="../../../static/icons/right-arrow-gray.png" class="left-arrow"></image>
					</view>
				</view>
				
				<view class="line-wrapper" style="margin: 10px 0 6px 0;"><view class="line" style="width: 100%;height: 1px"></view></view>
				
				<view class="time-wrapper">
					<!-- {{DateUtil.toShowTimeFormat(lookTime)}} -->
					<text class="look-time">浏览时间：{{hr.createTime}}</text>
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
				lookTime: '2021-01-22 06:10:11',
				
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
				
				page: 0,	// 默认第1页
				limit: 10,	// 每页显示10条
				allHRList:[
					{
						"title": "Java高级开发",
					},
					{
						"title": "Java高级开发",
					},
				],
			}
		},
		onShow() {
			
		},
		onLoad() {
			this.getPagedList(0);
		},
		mounted() {
			
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
					url: serverUrl + "/counts/pagedWhoLookMe?candUserId=" + userId + "&page=" + page + "&pageSize=10",
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var list = result.data.data;
							// console.log(me.total);
							// me.page = me.page + 1;
							console.log(list);
							
							if (page == 0) {
								me.allHRList = [];
							}
							me.allHRList = me.allHRList.concat(list);
							
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
			
			gotoHRDetail(hrUserId) {
				uni.navigateTo({
					url: "../../hr/hrPage?type=" + this.userType.candidate + "&hrUserId=" + hrUserId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
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
	@import url("whoLookMe.css");
</style>
