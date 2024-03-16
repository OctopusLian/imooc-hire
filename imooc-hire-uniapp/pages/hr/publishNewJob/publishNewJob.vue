<!-- 发布新职位 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper">
				<text class="title-one">发布职位</text>
			</view>
			
			<view class="block-name" style="margin-top: 30px;">
				<text class="field-lable-words">职位名称</text>
				
				<input
					class="nickname-input"
					type="text" 
					:value="job.jobName" 
					:model="job.jobName" 
					placeholder="请填入职位名称"
					placeholder-class="placeholder"
					maxlength="32"
					@input="typingJobName"/>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">职位类别</text>
				
				<view class="field-wrapper" style="">
					<input
						class="company-input"
						type="text" 
						:value="job.jobType" 
						:model="job.jobType" 
						placeholder="请选择职位类别"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="12"
						@click="gotoJobType()"/>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoJobType()"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			
			<view class="three-blocks">
				<view class="small-part">
					<text class="field-item-title">经验要求</text>
					<!-- <text class="field-item-words">经验不限</text> -->
					<picker mode="selector" :range="experienceRange" :value="selectedExperienceIndex" @change="bindExperienceChange"
						class="picker-words">
						<!-- <view class="field-item-words">{{experienceRange[selectedExperienceIndex]}}</view> -->
						<view class="field-item-words">{{experience}}</view>
					</picker>
				</view>
				
				<view class="split placeholder">|</view>
				
				<view class="small-part">
					<text class="field-item-title">最低学历</text>
					<!-- <text class="field-item-words">学历不限</text> -->
					<picker mode="selector" :range="educationRange" :value="selectedEducationIndex" @change="bindEducationChange"
						class="picker-words">
						<!-- <view class="field-item-words">{{educationRange[selectedEducationIndex]}}</view> -->
						<view class="field-item-words">{{education}}</view>
					</picker>
				</view>
				
				<view class="split placeholder">|</view>
				
				<view class="small-part">
					<text class="field-item-title">薪资{{monthSalary == "" ? "范围" : monthSalary}}</text>
					<!-- <text class="field-item-words placeholder">请选择</text> -->
					<!-- <text :class="{'field-item-words': true , 'placeholder': true}">请选择</text> -->
					<picker mode="multiSelector" :range="salaryRange" :value="salary" @change="bindSalaryChange"
						:class="salary == '请选择' ? 'picker' : 'picker-words'">
						<view class="field-item-words">{{salary}}</view>
					</picker>
					
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name" style="">
				<text class="field-lable-words">职位描述</text>
				
				<view class="field-wrapper" style="">
					<input 
						class="company-input"
						type="text" 
						:value="job.jobDesc" 
						:model="job.jobDesc" 
						placeholder="请填写职位描述"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="12"
						@click="gotoJobDesc()"/>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoJobDesc()"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name" style="">
				<text class="field-lable-words">职位标签</text>
				
				<view class="field-wrapper" style="">
					<input 
						class="company-input"
						type="text" 
						:value="job.tags" 
						:model="job.tags" 
						placeholder="请选择合适的标签"
						placeholder-class="placeholder"
						disabled="true"
						@click="gotoJobTags()"/>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoJobTags()"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">工作城市</text>
				
				<view class="field-wrapper" style="">
					<input
						class="company-input"
						type="text" 
						:value="job.city" 
						:model="job.city" 
						placeholder="请选择工作城市"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="12"
						@click="goArea()"/>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="goArea()"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">工作地点</text>
				
				<input
					class="position-input"
					type="text" 
					:value="job.address" 
					:model="job.address" 
					placeholder="请填写真实工作地点(具体到园区门牌号)"
					placeholder-class="placeholder"
					maxlength="64"
					@input="typingAddress"/>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="btn-next-wrapper" @click="submitJob">
				<text class="btn-next-words">发布职位</text>
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				job: {
					jobName: "",
					jobType: "",
					city: "",
					expYears: "",
					edu: "",
					beginSalary: 0,
					endSalary: 0,
					monthlySalary: 0,
					jobDesc: "",
					address: "",
					tags: "",
				},
				
				jobTitle: "",
				company: "",
				position: "",
				industry: "",
				jobType: "",
				jobDescription: "",
				jobTags: "",
				workPlace: "",
				
				experience: "不限",
				selectedExperienceIndex: 0,
				experienceRange2: [
					"不限", "1年以下", "1-3年", "3-5年", "5-10年", "10年以上"
				],
				experienceRange: [],
				jobExperienceNeedList: [],
				
				education: "不限",
				selectedEducationIndex: 0,
				educationRange2: [
					"不限", "中专/技校", "大专", "本科", "硕士", "MBA/EMBA", "博士"
				],
				educationRange: [],
				jobEducationNeedList: [],
				
				salary: "请选择",
				monthSalary: "",
				salaryRange: [
					[], 
					[],
					[]
				]
			}
		},
		onNavigationBarButtonTap() {
			
		},
		onShow() {
			var selectedJobType = uni.getStorageSync("selectedJobType");
			console.log(selectedJobType);
			if (selectedJobType != undefined && selectedJobType != "") {
				this.job.jobType = selectedJobType;
				uni.removeStorageSync("selectedJobType");
			}
			
			var jobDescription = uni.getStorageSync("jobDescription");
			console.log(jobDescription);
			if (jobDescription != undefined && jobDescription != "") {
				this.job.jobDesc = jobDescription;
				uni.removeStorageSync("jobDescription");
			}
			
			var tagsArray = uni.getStorageSync("tagsArray");
			console.log(tagsArray);
			if (tagsArray != undefined && tagsArray != "") {
				// this.tagsArray = tagsArray;
				var tempTags = ""
				for (var i = 0 ; i < tagsArray.length ; i ++) {
					tempTags += tagsArray[i];
					if ((i+1) != tagsArray.length) {
						tempTags += ","
					}
				}
				this.job.tags = tempTags;
				uni.removeStorageSync("tagsArray");
			}
			
			
			var workCity = uni.getStorageSync("chosenLocationArea");
			console.log(workCity);
			if (workCity != undefined && workCity != "") {
				console.log(this.job.city);
				this.job.city = workCity;	
			} 
			
			
			var startSalaryArr = [];
			for (var i = 0 ; i < 200 ; i ++) {
				var tempSalary = i + 1;
				if (tempSalary <= 30) {
					startSalaryArr.push(tempSalary + "K");
					continue;
				} else if (tempSalary > 30 && tempSalary <= 100) {
					if (tempSalary % 5 == 0) {
						startSalaryArr.push(tempSalary + "K");
						continue;
					}
				} else if (tempSalary > 200) { 
					if (tempSalary % 10 == 0) {
						startSalaryArr.push(tempSalary + "K");
						continue;
					}
				}
			}
			this.salaryRange[0] = startSalaryArr;
			
			var endSalaryArr = [];
			for (var i = 1 ; i < 200 ; i ++) {
				var tempSalary = i + 1;
				if (tempSalary <= 30) {
					endSalaryArr.push(tempSalary + "K");
					continue;
				} else if (tempSalary > 30 && tempSalary <= 200) {
					if (tempSalary % 5 == 0) {
						endSalaryArr.push(tempSalary + "K");
						continue;
					}
				} else if (tempSalary > 200) { 
					if (tempSalary % 10 == 0) {
						endSalaryArr.push(tempSalary + "K");
						continue;
					}
				}
			}
			this.salaryRange[1] = endSalaryArr;
			
			var monthSalaryArr = [];
			for (var i = 11 ; i < 30 ; i ++) {
				var tempSalary = i + 1;
				monthSalaryArr.push(tempSalary + "个月");
			}
			this.salaryRange[2] = monthSalaryArr;
		},
		onLoad(options) {
			this.getJobExperienceNeedList();
			this.getJobEducationNeedList();
			
			var jobId = options.jobId;
			if (jobId != undefined && jobId != "" && jobId != null) {
				this.jobId = jobId;
				this.getJobDetail(jobId)
			}
		},
		methods: {
			getJobDetail(jobId) {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = app.getUserInfoSession().hrInWhichCompanyId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/job/hr/jobDetail?hrId=" + userId + "&companyId=" + companyId + "&jobId=" + jobId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var jobDetail = result.data.data;
							console.log(jobDetail);
							if (jobDetail != null ) {
								me.job = jobDetail;
								
								me.monthSalary = jobDetail.monthlySalary + "月";
								me.salary = jobDetail.beginSalary + "-" + jobDetail.endSalary + "K";
								
								me.experience = jobDetail.expYears;
								me.education = jobDetail.edu;
								
								// var tags = jobDetail.tags;
								// if (tags != null && tags != "" && tags != undefined) {
								// 	var tempArr = tags.split(",");
								// 	for (var i = 0 ; i < tempArr.length ; i ++) {
								// 		if (tempArr[i] != null && tempArr[i] != "" && tempArr[i] != undefined) {
								// 			me.tagsArray.push(tempArr[i]);
								// 		}
								// 	}
								// }	
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
			
			typingJobName(e) {
				var event = e;
				this.job.jobName = e.detail.value;
			},
			
			typingAddress(e) {
				var event = e;
				this.job.address = e.detail.value;
			},
			
			submitJob() {
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				var companyId = app.getUserInfoSession().hrInWhichCompanyId
				
				var job = this.job;
				job.hrId = userId;
				job.companyId = companyId;
				console.log(job);
				
				if (job.jobName == null || job.jobName == "" || job.jobName == undefined) {
					uni.showToast({
						icon: "none",
						title: "职位名称不能为空~"
					})
					return;
				}
				
				if (job.jobType == null || job.jobType == "" || job.jobType == undefined) {
					uni.showToast({
						icon: "none",
						title: "职位类型不能为空~"
					})
					return;
				}
				
				if (job.expYears == null || job.expYears == "" || job.expYears == undefined) {
					uni.showToast({
						icon: "none",
						title: "经验要求不能为空~"
					})
					return;
				}
				
				if (job.edu == null || job.edu == "" || job.edu == undefined) {
					uni.showToast({
						icon: "none",
						title: "学历要求不能为空~"
					})
					return;
				}
				
				if (job.jobDesc == null || job.jobDesc == "" || job.jobDesc == undefined) {
					uni.showToast({
						icon: "none",
						title: "职位介绍不能为空~"
					})
					return;
				}
				
				if (job.tags == null || job.tags == "" || job.tags == undefined) {
					uni.showToast({
						icon: "none",
						title: "标签不能为空~"
					})
					return;
				}
				
				if (job.city == null || job.city == "" || job.city == undefined) {
					uni.showToast({
						icon: "none",
						title: "工作城市不能为空~"
					})
					return;
				}
				
				if (job.address == null || job.address == "" || job.address == undefined) {
					uni.showToast({
						icon: "none",
						title: "工作地址不能为空~"
					})
					return;
				}
				
				if (job.beginSalary == 0 || job.endSalary == 0 || job.monthlySalary == 0) {
					uni.showToast({
						icon: "none",
						title: "请选择薪资范围~"
					})
					return;
				}
				
				if (job.beginSalary >= job.endSalary) {
					uni.showToast({
						icon: "none",
						title: "请选择合适的薪资范围~"
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
					url: serverUrl + "/job/modify",
					data: job,
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
			
			getJobExperienceNeedList() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/dataDict/app/getDataByCode?typeCode=JobExperienceNeed",
					success(result) {
						
						if (result.data.status == 200) {
							var jobExperienceNeedList = result.data.data;
							console.log(jobExperienceNeedList);
							me.jobExperienceNeedList = jobExperienceNeedList;
							
							for (var i = 0 ; i < jobExperienceNeedList.length ; i ++) {
								me.experienceRange.push(jobExperienceNeedList[i].itemValue);
							}
							me.job.expYears = me.experienceRange[0];
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
			
			getJobEducationNeedList() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/dataDict/app/getDataByCode?typeCode=JobEducationNeed",
					success(result) {
						
						if (result.data.status == 200) {
							var jobEducationNeedList = result.data.data;
							console.log(jobEducationNeedList);
							me.jobEducationNeedList = jobEducationNeedList;
							
							for (var i = 0 ; i < jobEducationNeedList.length ; i ++) {
								me.educationRange.push(jobEducationNeedList[i].itemValue);
							}
							me.job.edu = me.educationRange[0];
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
			
			gotoJobTags() {
				var tags = this.job.tags;
				uni.navigateTo({
					url: "jobTags?tags=" + tags,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoJobDesc() {
				var jobDesc = this.job.jobDesc;
				uni.navigateTo({
					url: "jobDesc?jobDesc=" + jobDesc,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoJobType() {
				uni.navigateTo({
					url: "chooseJobType",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			bindSalaryChange(e) {
				var selectedArray = e.detail.value;
				var startSalaryIndex = selectedArray[0];
				var endSalaryIndex = selectedArray[1];
				var monthSalaryIndex = selectedArray[2];
				
				var startSalary = this.salaryRange[0][startSalaryIndex];
				var endSalary = this.salaryRange[1][endSalaryIndex];
				var monthSalary = this.salaryRange[2][monthSalaryIndex];
				console.log(startSalary + "-" + endSalary + "x" + monthSalary);
				
				this.salary = startSalary.split("K")[0] + "-" + endSalary;
				this.monthSalary = monthSalary.split("个")[0] + monthSalary.split("个")[1];
				
				this.job.beginSalary = startSalary.split("K")[0];
				this.job.endSalary = endSalary.split("K")[0];
				this.job.monthlySalary = monthSalary.split("个")[0];
			},
			
			bindExperienceChange(e) {
				var selectedExperienceIndex = e.detail.value
				// console.log(selectedExperienceIndex);
				this.selectedExperienceIndex = selectedExperienceIndex;
				
				this.job.expYears = this.experienceRange[selectedExperienceIndex];
				this.experience = this.experienceRange[selectedExperienceIndex];
			},
			
			bindEducationChange(e) {
				var selectedEducationIndex = e.detail.value
				// console.log(selectedEducationIndex);
				this.selectedEducationIndex = selectedEducationIndex;
				
				this.job.edu = this.educationRange[selectedEducationIndex];
				this.education = this.educationRange[selectedEducationIndex];
			},
			
			goArea() {
				uni.navigateTo({
					url: "../../candidate/chooseProvince",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
		}
	}
</script>

<style>
	@import url("publishNewJob.css");
	
	/* .mpvue-picker-view {
		width: 100%;
		height: 50%;
		background-color: rgba(255, 255, 255, 1);
	} */
	/* .item {
	  text-align: center;
	  width: 100%;
	  height: 88upx;
	  line-height: 88upx;
	  text-overflow: ellipsis;
	  white-space: nowrap;
	  font-size: 40upx;
	} */
</style>
