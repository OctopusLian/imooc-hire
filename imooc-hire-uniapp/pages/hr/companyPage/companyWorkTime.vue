<!-- 工作时间页面 -->
<template>
	<view>
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 20px;">
				<text class="title-one">公司标准工作时间</text>
				<text class="title-two">添加工作时间，可供求职者参考，不代表公司下所有职位的工作时间~</text>
			</view>
			
			
			<view class="block-name" style="margin-top: 20px;">
				<text class="field-lable-words">工作时间</text>
				
				<view class="field-wrapper" style="">
					<picker mode="multiSelector" :range="timeRange" :value="time" start="09:01" end="21:01" @change="bindTimeChange" 
						:class="time == '请选择时间' ? 'picker' : 'picker-words'">
						<view class="uni-input">{{time}}</view>
					</picker>
										
					<!-- <input
						class="field-input"
						type="text" 
						value="" 
						model="" 
						placeholder="请选择工作时间段"
						placeholder-class="placeholder"
						disabled="true"/>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click=""></image> -->
				</view>
			</view>
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
		
		
		
			<view class="block-name" style="margin-top: 50px;">
				<text class="field-lable-words">休息时间（可选）</text>
				
				<view class="sub-item-wrapper">
					<view :class="selectedRestTime.value == r.value ? 'sub-item-box-selected' : 'sub-item-box'" v-for="(r, index) in restTimeList" :key="r.key" @click="selectRestTime(r)">
						<text :class="selectedRestTime.value == r.value ? 'sub-item-words-selected' : 'sub-item-words'">{{r.value}}</text>
					</view>
				</view>
			</view>
			
			
			<view class="block-name" style="margin-top: 60px;">
				<text class="field-lable-words">加班情况（可选）</text>
				
				<view class="sub-item-wrapper">
					<view :class="selectedOverWork.value == o.value ? 'sub-item-box-selected' : 'sub-item-box'" v-for="(o, index) in overWorkList" :key="o.key" @click="selectOverWork(o)">
						<text :class="selectedOverWork.value == o.value ? 'sub-item-words-selected' : 'sub-item-words'">{{o.value}}</text>
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
				workTimeStart: "",
				workTimeEnd: "",
				
				selectedRestTime: {},
				selectedOverWork: {},
				
				restTimeList: [
					{ key: 1001, value: "周末双休" }, { key: 1002, value: "周末单休" }, { key: 1003, value: "大小周" },
				],
				overWorkList: [
					{ key: 2001, value: "不加班" }, { key: 2002, value: "偶尔加班" }, { key: 2003, value: "弹性工作" },
				],
				
				time: "请选择时间",
				workTime: "",
				
				timeRange: [
					["7:00", "7:30", "8:00", "8:30", "9:00", "9:30", "10:00"], ["16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00"]
				]
			}
		},
		onShow() {
		},
		onLoad(options) {
			this.companyId = options.companyId;
			var workTime = options.workTime;
			// this.workTime = workTime;
			
			// console.log(this.workTime);
			var workTimeArr = workTime.split(" ");
			this.workTime = workTimeArr[0];
			this.time = workTimeArr[0];
			this.selectedRestTime.value = workTimeArr[1];
			this.selectedOverWork.value = workTimeArr[2];
			
		},
		onNavigationBarButtonTap() {
			// console.log(123);
			this.modifyWorkTime();
		},
		methods:{
			modifyWorkTime() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var workTime = this.workTime;
				var restTime = this.selectedRestTime.value;
				var overWork = this.selectedOverWork.value;
				
				restTime = (restTime == undefined || restTime == null || restTime == "") ? "" : restTime;
				overWork = (overWork == undefined || overWork == null || overWork == "") ? "" : overWork;
				
				// console.log(workTime);
				// console.log(restTime);
				// console.log(overWork);
				// return;
				
				if (workTime == null || workTime == "" || workTime == undefined) {
					uni.showToast({
						title: "请输入工作时间",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"workTime": workTime + " " + restTime + " " + overWork
				};
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/modify",
					data: pendingInfo,
					success(result) {
						
						if (result.data.status == 200) {
							
							uni.showToast({
								title: "修改成功~",
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
			
			bindTimeChange: function(e) {
				var selectedArray = e.detail.value
				var startIndex = selectedArray[0];
				var endIndex = selectedArray[1];
				
				this.time = this.timeRange[0][startIndex] + "-" + this.timeRange[1][endIndex];
				this.workTime = this.time;
			},
					
			selectRestTime(restTime) {
				var currentRestTime = this.selectedRestTime;
				if (restTime.value == currentRestTime.value) {
					this.selectedRestTime = {}
				} else {
					this.selectedRestTime = restTime;
				}
				
			},
			
			selectOverWork(overWork) {
				var currentOverWork = this.selectedOverWork;
				if (overWork.value == currentOverWork.value) {
					this.selectedOverWork = {}
				} else {
					this.selectedOverWork = overWork;
				}
			}
		}
	}
</script>

<style>
	@import url("companyWorkTime.css");
</style>
