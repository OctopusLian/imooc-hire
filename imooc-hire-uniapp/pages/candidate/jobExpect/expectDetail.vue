<!-- 求职期望 添加/编辑 -->
<template>
	<view>
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 20px;">
				<text class="title-one">{{expectId != null ? '编辑' : '添加'}}求职期望</text>
				<text class="title-two">完善求职期望获得更多求职机会，也让用人单位更好发现你</text>
			</view>
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">期望职位</text>
				
				<view class="field-wrapper">
					<input
						class="company-input"
						type="text" 
						:value="resumeExpect.jobName" 
						:model="resumeExpect.jobName" 
						placeholder="请选择期望职位"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="12"
						@click="gotoJobType()"/>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoJobType()"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">工作城市</text>
				
				<view class="field-wrapper" style="">
					<input
						class="company-input"
						type="text" 
						:value="resumeExpect.city" 
						:model="resumeExpect.city" 
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
				<text class="field-lable-words">期望行业</text>
				
				<view class="field-wrapper" style="">
					<input
						class="company-input"
						type="text" 
						:value="resumeExpect.industry" 
						:model="resumeExpect.industry" 
						placeholder="请选择期望行业"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="12"
						@click="gotoIndustry()"/>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoIndustry()"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">薪资要求</text>
				
				<view class="field-wrapper" style="">
					<!-- <input
						class="company-input"
						type="text" 
						:value="industry" 
						:model="industry" 
						placeholder="请选择薪资要求"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="12"
						@click="gotoJobType()"/> -->
					<picker mode="multiSelector" :range="salaryRange" :value="salary" @change="bindSalaryChange"
						:class="salary == '请选择' ? 'picker' : 'picker-words'">
						<view class="field-item-words">{{salary}}</view>
					</picker>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="btn-next-wrapper" @click="publish">
				<text class="btn-next-words">{{expectId != null ? '编辑' : '新增'}}求职期望</text>
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				expectId: null,
				
				jobType: "",
				workCity: "",
				industry: "",
				
				beginSalary: 0,
				endSalary: 0,
				
				salary: "请选择",
				monthSalary: "",
				salaryRange: [
					[], 
					[]
				],
				
				resumeExpect: {
					"id": "",
					"userId": "",
					"resumeId": "",
					"jobName": "",
					"city": "",
					"industry": "",
					"beginSalary": 0,
					"endSalary": 0
				},
			}
		},
		onShow() {
			var selectedJobType = uni.getStorageSync("selectedJobType");
			// console.log(selectedJobType);
			if (selectedJobType != undefined && selectedJobType != "" && selectedJobType != null) {
				// if (this.resumeExpect.jobName == "") {
					this.resumeExpect.jobName = selectedJobType;	
				// }
			}
			//  else {
			// 	this.jobType = "";
			// }
			
			
			var workCity = uni.getStorageSync("chosenLocationArea");
			if (workCity != undefined && workCity != "") {
				// if (this.resumeExpect.city == "") {
					this.resumeExpect.city = workCity;	
				// }
			} 
			// else {
			// 	this.workCity = ""
			// }
			
			var industry = uni.getStorageSync("selectedIndustry");
			if (industry != undefined && industry != "") {
				// if (this.resumeExpect.industry == "") {
					this.resumeExpect.industry = industry;	
				// }
			} 
			// else {
			// 	this.industry = ""
			// }
			
			
			
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
		},
		onNavigationBarButtonTap() {
			this.deleteResumeExpect();
		},
		onLoad(options) {
			uni.removeStorageSync("selectedJobType");
			uni.removeStorageSync("chosenLocationArea");
			uni.removeStorageSync("selectedIndustry");
			
			var expectId = options.expectId;
			if (expectId != null && expectId != "" && expectId != undefined) {
				this.expectId = expectId;
			}
			// console.log(expectId);
			
			var resumeId = options.resumeId;
			if (resumeId != null && resumeId != "" && resumeId != undefined) {
				this.resumeId = resumeId;
			}
			// console.log(resumeId);
			
			
			var resumeExpectStr = options.resumeExpectStr;
			if (resumeExpectStr != null && resumeExpectStr != "" && resumeExpectStr != undefined) {
				var resumeExpect = JSON.parse(resumeExpectStr);
				this.resumeExpect = resumeExpect;
				
				this.salary = resumeExpect.beginSalary + "-" + resumeExpect.endSalary + "K";
			} else {
			}
			console.log(this.resumeExpect);
		},
		methods:{
			deleteResumeExpect() {
				var me = this;
				var resumeExpectId = this.resumeExpect.id;
				console.log(resumeExpectId);
				
				uni.showModal({
					title: "确认删除该求职期望？",
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
									url: serverUrl + "/resume/deleteMyResumeExpect?resumeExpectId=" + resumeExpectId + "&userId=" + userId,
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
			
			publish() {
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				var jobName = this.resumeExpect.jobName;
				var city = this.resumeExpect.city;
				var industry = this.resumeExpect.industry;
				var beginSalary = this.resumeExpect.beginSalary;
				var endSalary = this.resumeExpect.endSalary;
				
				console.log(beginSalary)
				console.log(endSalary)
				
				if (jobName == null || jobName == "" || jobName == undefined) {
					uni.showToast({
						icon: "none",
						title: "期望职位不能为空~"
					})
					return;
				}
				
				if (city == null || city == "" || city == undefined) {
					uni.showToast({
						icon: "none",
						title: "工作城市不能为空~"
					})
					return;
				}
				
				if (industry == null || industry == "" || industry == undefined) {
					uni.showToast({
						icon: "none",
						title: "工作城市不能为空~"
					})
					return;
				}
				
				if (beginSalary == 0 || endSalary == 0) {
					uni.showToast({
						icon: "none",
						title: "请选择合理的薪资要求~"
					})
					return;
				}
				
				if (beginSalary > endSalary) {
					uni.showToast({
						icon: "none",
						title: "请选择合理的薪资要求~"
					})
					return;
				}
				
				var expectId = this.expectId;
				if (expectId == null || expectId == "" || expectId == undefined) {
					expectId = "";
				}
				
				var pendingInfo = {
					"id": expectId,
					"userId": userId,
					"resumeId": this.resumeId,
					"jobName": jobName,
					"city": city,
					"industry": industry,
					"beginSalary": beginSalary,
					"endSalary": endSalary,
				};
				
				// console.log(pendingInfo);
				// return;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/resume/editJobExpect",
					data: pendingInfo,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							
							uni.removeStorageSync("selectedJobType");
							uni.removeStorageSync("chosenLocationArea");
							uni.removeStorageSync("selectedIndustry");
							
							uni.showToast({
								title: "发布成功~",
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
			
			gotoJobType() {
				uni.navigateTo({
					url: "../../hr/publishNewJob/chooseJobType",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			goArea() {
				uni.navigateTo({
					url: "../chooseProvince",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoIndustry() {
				uni.navigateTo({
					url: "../../company/chooseIndustry",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			bindSalaryChange(e) {
				var selectedArray = e.detail.value;
				var startSalaryIndex = selectedArray[0];
				var endSalaryIndex = selectedArray[1];
				
				var startSalary = this.salaryRange[0][startSalaryIndex];
				var endSalary = this.salaryRange[1][endSalaryIndex];
				
				this.salary = startSalary.split("K")[0] + "-" + endSalary;
				this.resumeExpect.beginSalary = parseInt(startSalary);
				this.resumeExpect.endSalary = parseInt(endSalary);
			},
		}
	}
</script>

<style>
	@import url("expectDetail.css");
</style>
