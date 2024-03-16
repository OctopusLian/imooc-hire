<!-- 面试邀约详情 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="status-wrapper">
				<image src="../../../static/icons/company/wait-accept.png" class="status-icon" v-show="interviewStatus == 1"></image>
				<image src="../../../static/icons/company/wait-interview.png" class="status-icon" v-show="interviewStatus == 2"></image>
				<image src="../../../static/icons/company/refuse-interview.png" class="status-icon" v-show="interviewStatus == 3"></image>
				<image src="../../../static/icons/company/cancel-interview.png" class="status-icon" v-show="interviewStatus == 4"></image>
				<image src="../../../static/icons/company/interview-pass.png" class="status-icon" v-show="interviewStatus == 5"></image>
				
				<text class="status-words" v-show="interviewStatus == 1">等待候选人接受面试</text>
				<text class="status-words" v-show="interviewStatus == 2">候选人已接受面试</text>
				<text class="status-words" v-show="interviewStatus == 3">候选人已拒绝面试</text>
				<text class="status-words" v-show="interviewStatus == 4">HR已取消面试</text>
				<text class="status-words" v-show="interviewStatus == 5">面试通过</text>
			</view>
			
			<view class="title-wrapper" v-if="interviewInfo != null">
				<view class="cand-wrapper">
					<image :src="interviewInfo.candFace" class="face"></image>
					
					<view class="cand-info">
						<view class="name-info">
							<text class="cand-name">{{interviewInfo.candName}}</text>
						</view>
						<text class="cand-company">{{interviewInfo.candPosition}}</text>
					</view>
				</view>
				
				<view class="line-wrapper" style="margin: 10px 0px;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="interview-job-wrapper">
					<image src="../../../static/icons/hr/interview/bao.png" class="small-icon"></image>
					<text class="interview-job-words">{{interviewInfo.jobName}}</text>
				</view>
				
				<view class="interview-job-box">
					<view class="interview-info-item">
						<image src="../../../static/icons/hr/interview/rili.png" class="small-icon"></image>
						<text class="interview-date-words">{{interviewInfo.interviewTime}}</text>
					</view>
					<view class="interview-info-item">
						<image src="../../../static/icons/hr/interview/location.png" class="small-icon"></image>
						<text class="interview-date-words">{{interviewInfo.interviewAddress}}</text>
					</view>
					<view class="interview-info-item">
						<image src="../../../static/icons/hr/interview/beiwang.png" class="small-icon"></image>
						<text class="interview-date-words">{{(interviewInfo.remark == null || interviewInfo.remark == "") ? "暂无备注" : interviewInfo.remark}}</text>
					</view>
				</view>
			</view>
			
			
			<view class="btn-wrapper" v-show="userIdentityType == 1 && interviewStatus == 1" @click="cancelInterview()">
				<text class="btn-words">取消面试</text>
			</view>
			
			<view class="btn-wrapper-cand" v-show="userIdentityType == 2 && interviewStatus == 1">
				<view class="btn-wrapper-accept" @click="acceptInterview()">
					<text class="btn-words-accept">接受面试</text>
				</view>
				
				<view class="btn-wrapper-refuse" @click="refuseInterview()">
					<text class="btn-words-refuse">拒绝面试</text>
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
				interviewId: "",
				interviewInfo: null,
				hrUserId: "",
				hrUserInfo: null,
				
				userIdentityType: 2		,// 默认为2
				
				// interviewStatus: 1,		// 待接受
				interviewStatus: 2,		// 已接受，待面试
				// interviewStatus: 3,		// 拒绝面试（）
				// interviewStatus: 4,		// 取消面试（）
				// interviewStatus: 5,		// 通过面试（）
			}
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
			
		},
		onLoad(option) {
			
			var interviewId = option.interviewId;
			// 如果resumeUserId为空，表示是自己预览（默认），如果不为空，则根据传来的id查询
			if (interviewId == null || interviewId == undefined || interviewId == "") {
				uni.showToast({
					icon: "none",
					title: "业务参数不正确，请联系管理员或客服。"
				})
				return;
			}
			this.interviewId = interviewId;
			
			
			var hrUserId = option.hrUserId;
			// 如果resumeUserId为空，表示是自己预览（默认），如果不为空，则根据传来的id查询
			if (hrUserId == null || hrUserId == undefined || hrUserId == "") {
				uni.showToast({
					icon: "none",
					title: "业务参数不正确，请联系管理员或客服。"
				})
				return;
			}
			this.hrUserId = hrUserId;
			this.getHrUserInfo(hrUserId);
			
			// 根据id查询当前面试邀约的状态并且显示
			// this.getInterviewInfo(interviewId);
		},
		methods: {
			getHrUserInfo(hrUserId) {
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
							var hrUserInfo = result.data.data;
							me.hrUserInfo = hrUserInfo;
							
							me.getInterviewInfo(me.interviewId, hrUserId, hrUserInfo.hrInWhichCompanyId);
						}
					}
				})
			},
			
			getInterviewInfo(interviewId, hrUserId, companyId) {
				console.log(interviewId)
				console.log(hrUserId)
				console.log(companyId)
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/interview/detail?interviewId=" + interviewId + "&hrUserId=" + hrUserId + "&companyId=" + companyId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var interviewInfo = result.data.data;
							me.interviewInfo = interviewInfo;
							console.log(interviewInfo);
							me.interviewStatus = interviewInfo.status;
						}
					}
				})
			},
			
			// 候选人接受面试
			acceptInterview() {
				// 候选人接受面试
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var interviewId = this.interviewId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/interview/accept?interviewId=" + interviewId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							
							var accept_interviewId = interviewId;
							uni.setStorageSync("accept_interviewId", accept_interviewId);
							uni.navigateBack({
								delta: 1
							})
							
						}
					}
				})
			},
			
			// 
			refuseInterview() {
				// 候选人拒绝面试
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var interviewId = this.interviewId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/interview/refuse?interviewId=" + interviewId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							
							var refuse_interviewId = interviewId;
							uni.setStorageSync("refuse_interviewId", refuse_interviewId);
							uni.navigateBack({
								delta: 1
							})
							
						}
					}
				})
			
			},
			
			// HR取消面试
			cancelInterview() {
				// 发送请求到后端，修改面试状态为取消
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var interviewId = this.interviewId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/interview/cancel?interviewId=" + interviewId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							
							var cancel_interviewId = interviewId;
							uni.setStorageSync("cancel_interviewId", cancel_interviewId);
							uni.navigateBack({
								delta: 1
							})
							
						}
					}
				})
			},
		}
	}
</script>

<style>
	@import url("interviewDetail.css");
</style>
