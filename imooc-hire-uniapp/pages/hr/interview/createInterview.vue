<!-- 面试邀约详情 -->
<template>
	<view>
		<view class="card-box">
			
			<text class="cand-words">候选人</text>

			<view class="cand-wrapper" v-if="resumeUserInfo != null">
				<image :src="resumeUserInfo.face" class="face"></image>
				
				<view class="cand-info">
					<view class="name-info">
						<text class="cand-name">{{resumeUserInfo.nickname}}</text>
					</view>
					<text class="cand-company">{{resumeUserInfo.position}}</text>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 10px 0px;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">面试职位</text>
				
				<view class="field-wrapper" style="">
					<input
						class="company-input"
						type="text" 
						:value="job" 
						:model="job" 
						placeholder="请选择职位"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="24"
						@click="goChooseJob"/>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="goChooseJob"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
			<view class="block-name">
				<text class="field-lable-words">面试时间</text>
				
				<view class="field-datetime-wrapper" style="">
					<picker mode="date" :value="date" :start="startDate" :end="endDate" @change="bindDateChange">
						<view class="uni-input">{{date}}</view>
					</picker>
					<picker style="margin-left: 10px;" mode="time" :value="time" start="07:00" end="21:00" @change="bindTimeChange">
						<view class="uni-input">{{time}}</view>
					</picker>
					<!-- <input
						class="company-input"
						type="text" 
						:value="jobType" 
						:model="jobType" 
						placeholder="请选择时间"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="24"
						@click=""/> -->
						<!-- 2022年5月28日 周六 10:00 -->
					<!-- <image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click=""></image> -->
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
			<view class="block-name">
				<text class="field-lable-words">面试地点（不可更改）</text>
				
				<view class="location-wrapper">
					<image src="../../../static/icons/hr/interview/location.png" class="location-icon"></image>
					<text class="location-input">{{address}}</text>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">备注</text>
				
				<view class="location-wrapper">
					<textarea class="remark" v-model="remark" maxlength="128" placeholder="备注信息" />
				</view>
			</view>
			
		</view>
			
			
		<view class="title-wrapper">
			<view class="btn-wrapper" @click="sendInterview()">
				<text class="btn-words">创建并发送</text>
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			const currentDate = this.getDate({
				format: true
			});
			return {
				job: "",
				jobId: "",
				address: "",
				remark: "",
				
				date: currentDate,
				time: '10:00',
				
				resumeUserId: "",
				resumeUserInfo: null,
			}
		},
		onShow() {
			var choosenInterviewJob = uni.getStorageSync("choosenInterviewJob");
			if (choosenInterviewJob != null && choosenInterviewJob != "" && choosenInterviewJob != undefined) {
				this.job = choosenInterviewJob.jobName;
				this.jobId = choosenInterviewJob.id;
				this.address = choosenInterviewJob.address;
			} else {
				this.job = "";
				this.jobId = "";
				this.address = "";
			}
			
		},
		onLoad(option) {
			var resumeUserId = option.resumeUserId;
			// 如果resumeUserId为空，表示是自己预览（默认），如果不为空，则根据传来的id查询
			if (resumeUserId == null || resumeUserId == undefined || resumeUserId == "") {
				uni.showToast({
					icon: "none",
					title: "业务参数不正确，请联系管理员或客服。"
				})
				return;
			}
			
			this.resumeUserId = resumeUserId;
			
			// 查询用户信息
			this.getResumeUserInfo(resumeUserId);
		},
		computed: {
			startDate() {
				return this.getDate('start');
			},
			endDate() {
				return this.getDate('end');
			}
		},
		methods: {
			
			getResumeUserInfo(resumeUserId) {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/userinfo/get?userId=" + resumeUserId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var resumeUserInfo = result.data.data;
							me.resumeUserInfo = resumeUserInfo;
						}
					}
				})
			},
			
			sendInterview() {
				// 发送请求到后端，创建成果获得面试主键id
				var me = this;
				var userId = app.getUserInfoSession().id;
				var companyId = app.getUserInfoSession().hrInWhichCompanyId;
				
				var bo = {
				    "hrUserId": userId,
				    "companyId": companyId,
				    "candUserId": this.resumeUserId,
				    "jobId": this.jobId,
					"jobName": this.job,
				    "interviewTime": this.date + " " + this.time + ":00",
				    "interviewAddress": this.address,
				    "remark": this.remark,
					"candName": this.resumeUserInfo.nickname,
					"candFace": this.resumeUserInfo.face,
					"candPosition": this.resumeUserInfo.position,
				};
				
				if (this.jobId == null || this.jobId == undefined || this.jobId == "") {
					uni.showToast({
						icon: "none",
						title: "请选择一个职位..."
					})
					return;
				}
				if (this.address == null || this.address == undefined || this.address == "") {
					uni.showToast({
						icon: "none",
						title: "职位地址不正确，或为空..."
					})
					return;
				}
				
				console.log(bo);
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/interview/create",
					data: bo,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var interviewId = result.data.data;
							console.log(interviewId);
							
							uni.setStorageSync("interviewId", interviewId);
							uni.navigateBack({
								delta: 1
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
					
			
				
				// var interviewId = "interviewId_1002";
				// uni.setStorageSync("interviewId", interviewId);
				// uni.navigateBack({
				// 	delta: 1
				// })
			},
			
			goChooseJob() {
				uni.navigateTo({
					url: "chooseJobList",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			bindTimeChange: function(e) {
				this.time = e.detail.value
			},
			
			bindDateChange: function(e) {
				this.date = e.detail.value
			},
			
			getDate(type) {
				const date = new Date();
				let year = date.getFullYear();
				let month = date.getMonth() + 1;
				let day = date.getDate();
	
				if (type === 'start') {
					year = year - 60;
				} else if (type === 'end') {
					year = year + 2;
				}
				month = month > 9 ? month : '0' + month;
				day = day > 9 ? day : '0' + day;
				return `${year}-${month}-${day}`;
			}
		}
	}
</script>

<style>
	@import url("createInterview.css");
</style>
