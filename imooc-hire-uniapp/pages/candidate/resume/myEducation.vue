<!-- 项目经验 -->
<template>
	<view>
		<view class="card-box">
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">学校名称</text>
				
				<view class="field-wrapper">
					<input
						class="company-input"
						type="text" 
						:value="myEducation.school" 
						:model="myEducation.school" 
						placeholder="请填写学校名称"
						placeholder-class="placeholder"
						maxlength="24"
						@input="typingContentSchool"/>
					<!-- <image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image> -->
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">学历</text>
				
				<view class="field-wrapper">
					<!-- <input
						class="company-input"
						type="text" 
						:value="education" 
						:model="education" 
						placeholder="请填写学历"
						placeholder-class="placeholder"
						maxlength="12"
						disabled="true"/> -->
					<picker mode="multiSelector" :range="educationRange" :value="myEducation.education" @change="bindEducationChange"
						:class="myEducation.education == '' ? 'picker' : 'picker-words'">
						<view class="field-words">{{myEducation.education == "" ? "请选择" : myEducation.education}}</view>
					</picker>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">专业名称</text>
				
				<view class="field-wrapper">
					<input
						class="company-input"
						type="text" 
						:value="myEducation.major" 
						:model="myEducation.major" 
						placeholder="请填写专业"
						placeholder-class="placeholder"
						maxlength="24"
						@input="typingContentMajor"/>
					<!-- <image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image> -->
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">时间</text>
				
				<view class="job-day-wrapper">
					<picker mode="multiSelector" :range="firstDayRange" :value="myEducation.beginDate" @change="bindStudyFirstDayChange"
						:class="myEducation.beginDate == '' ? 'picker' : 'picker-words'">
						<view class="field-words">{{myEducation.beginDate == "" ? "请选择" : myEducation.beginDate}}</view>
					</picker>
					
					<text class="day-split">—</text>
				
					<picker mode="multiSelector" :range="lastDayRange" :value="myEducation.endDate" @change="bindStudyLastDayChange" 
						:class="myEducation.endDate == '' ? 'picker' : 'picker-words'">
						<view class="field-words">{{myEducation.endDate == "" ? "请选择" : myEducation.endDate}}</view>
					</picker>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="btn-next-wrapper" v-if="myEducation.id != null && myEducation.id != '' && myEducation.id != undefined" @click="deleteEducation()">
				<text class="btn-next-words">删除教育经历</text>
			</view>
			
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			const date = new Date()
			const years = []
			const year = date.getFullYear()
			const lastDayYears = []
			const months = []
			const month = date.getMonth() + 1
			const days = []
			const day = date.getDate()
			for (let i = 1990; i <= date.getFullYear(); i++) {
				years.unshift(i)
			}
			for (let i = 1990; i <= date.getFullYear()+3; i++) {
				lastDayYears.unshift(i)
			}
			for (let i = 1; i <= 12; i++) {
				months.push(i)
			}
			for (let i = 1; i <= 31; i++) {
				days.push(i)
			}
			return {
				myEducation: {
				    "id": "",
				    "userId": "",
				    "resumeId": "",
				    "school": "",
				    "education": "",
				    "major": "",
				    "beginDate": "",
				    "endDate": ""
				},
				schoolName: "",
				education: "请选择",
				major: "",
				studyFirstDay: "开始时间",
				studyLastDay: "结束时间",
				
				years,
				lastDayYears,
				year,
				months,
				month,
				days,
				day,
				firstDayRange: [
					years, 
					months
				],
				lastDayRange: [
					lastDayYears, 
					months
				],
				
				
				selectedEducationIndex: 0,
				educationRange: [
					["初中", "高中", "中专/技校", "大专", "本科", "硕士", "MBA/EMBA", "博士"]
				],
			}
		},
		onShow() {
	
		},
		onLoad(options) {
			var resumeId = options.resumeId;
			if (resumeId != null && resumeId != "" && resumeId != undefined) {
				this.myEducation.resumeId = resumeId;
			} else {
				this.myEducation.resumeId = "";
			}
			console.log(resumeId);
			
			var eduId = options.eduId;
			if (eduId != null && eduId != "" && eduId != undefined) {
				this.myEducation.id = eduId;
			} else {
				this.myEducation.id = "";
			}
			
			this.getMyEducation();
		},
		onNavigationBarButtonTap() {
			this.saveMyEducation();
		},
		methods:{
			deleteEducation() {
				var me = this;
				var eduId = this.myEducation.id;
				
				uni.showModal({
					title: "确认删除该教育经历？",
					cancelText: "取消",
					confirmText: "确定",
					confirmColor: "#31B9B3",
					success(e) {
						if (e.confirm) {
							
								
								var userId = app.getUserInfoSession().id;
								
								var serverUrl = app.globalData.serverUrl;
								uni.request({
									method: "POST",
									header: {
										headerUserId: userId,
										headerUserToken: app.getUserSessionToken()
									},
									url: serverUrl + "/resume/deleteEducation?eduId=" + eduId + "&userId=" + userId,
									success(result) {
										// console.log(result);
										if (result.data.status == 200) {
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
							
						}
					}
				});
				
			},
			
			getMyEducation() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				var eduId = this.myEducation.id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/resume/getEducation?eduId=" + eduId + "&userId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var myEducation = result.data.data;
							console.log(myEducation);
							if (myEducation != null) {
								me.myEducation = myEducation;
							}
							// me.initInfo();
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
			
			typingContentSchool(e) {
				var event = e;
				this.myEducation.school= e.detail.value;
			},
			
			typingContentMajor(e) {
				var event = e;
				this.myEducation.major= e.detail.value;
			},
			
			bindEducationChange(e) {
				var selectedArray = e.detail.value
				// console.log(selectedEducationIndex);
				var selectedIndex = selectedArray[0];
				var edu = this.educationRange[0][selectedIndex];
				this.myEducation.education = edu;
			},
			
			saveMyEducation() {
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var myEducation = this.myEducation;
				myEducation.userId = userId;
				// console.log(myEducation);
				
				if (myEducation.school == null || myEducation.school == "" || myEducation.school == undefined) {
					uni.showToast({
						icon: "none",
						title: "学校名称不能为空~"
					})
					return;
				}
				
				if (myEducation.education == null || myEducation.education == "" || myEducation.education == undefined) {
					uni.showToast({
						icon: "none",
						title: "学历不能为空~"
					})
					return;
				}
				
				if (myEducation.major == null || myEducation.major == "" || myEducation.major == undefined) {
					uni.showToast({
						icon: "none",
						title: "专业不能为空~"
					})
					return;
				}
				
				if (myEducation.beginDate == null || myEducation.beginDate == "" || myEducation.beginDate == undefined
					|| myEducation.endDate == null || myEducation.endDate == "" || myEducation.endDate == undefined) {
					uni.showToast({
						icon: "none",
						title: "时间不能为空~"
					})
					return;
				}
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/resume/editEducation",
					data: myEducation,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							// var resume = result.data.data;
							// console.log(resume);
							// this.resume = resume;
							
							uni.showToast({
								title: "保存成功~",
								duration: 2000,
								success() {
									uni.navigateBack({
										delta: 1,
										animationType: "fade-out"
									})
								}
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
					
			},
			
			bindStudyLastDayChange(e) {
				var selectedArray = e.detail.value;
				var yearIndex = selectedArray[0];
				var monthIndex = selectedArray[1];
				
				var year = this.lastDayRange[0][yearIndex];
				var month = this.lastDayRange[1][monthIndex];
				
				this.myEducation.endDate = year + "-" + (month < 10 ? '0' + month : month);
			},
			
			bindStudyFirstDayChange(e) {
				var selectedArray = e.detail.value;
				var yearIndex = selectedArray[0];
				var monthIndex = selectedArray[1];
				
				var year = this.firstDayRange[0][yearIndex];
				var month = this.firstDayRange[1][monthIndex];
				
				this.myEducation.beginDate = year + "-" + (month < 10 ? '0' + month : month);
			},
			
		}
	}
</script>

<style>
	@import url("myEducation.css");
</style>
