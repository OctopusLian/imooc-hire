<!-- 我的优势/特长/亮点 -->
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
						:value="jobType" 
						:model="jobType" 
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
						:value="workCity" 
						:model="workCity" 
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
						:value="industry" 
						:model="industry" 
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
			
			<view class="btn-next-wrapper" @click="">
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
				expectId: null,
				
				jobType: "",
				workCity: "",
				industry: "",
				
				salary: "请选择",
				monthSalary: "",
				salaryRange: [
					[], 
					[]
				]
			}
		},
		onShow() {
			var selectedJobType = uni.getStorageSync("selectedJobType");
			// console.log(selectedJobType);
			if (selectedJobType != undefined && selectedJobType != "" && selectedJobType != null) {
				this.jobType = selectedJobType;
			} else {
				this.jobType = "";
			}
			
			
			var workCity = uni.getStorageSync("chosenLocationArea");
			if (workCity != undefined && workCity != "") {
				this.workCity = workCity;
			} else {
				this.workCity = ""
			}
			
			var industry = uni.getStorageSync("selectedIndustry");
			if (industry != undefined && industry != "") {
				this.industry = industry;
			} else {
				this.industry = ""
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
		},
		onLoad(options) {
			var expectId = options.expectId;
			if (expectId != null && expectId != "" && expectId != undefined) {
				this.expectId = expectId;
			}
			console.log(expectId);
		},
		methods:{
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
			},
		}
	}
</script>

<style>
	@import url("myAdvantage.css");
</style>
