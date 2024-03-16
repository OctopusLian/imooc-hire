<!-- 选择职位类型 -->
<template>
	<view>
		
		<view class="all-in-box">
			<scroll-view class="left-main-scroll" scroll-y="true" :style="{height: screenHeight + 'px'}" >
				<block v-for="(mainType, index) in mainTypeArray" :key="index">
					<view :class="selectedMainTypeId == mainType.id ? 'left-box-selected' : 'left-box'" @click="selectMainType(mainType)">
						<text class="left-words">{{mainType.name}}</text>
					</view>
				</block>
				
				<!-- <view class="left-box"><text class="left-words">IT互联网技术</text></view>
				<view class="left-box-selected"><text class="left-words">电子/通信/半导体</text></view> -->
			</scroll-view>
			
			<scroll-view class="right-sub-scroll" scroll-y="true" :style="{height: screenHeight + 'px'}">
				<view class="whole-sub-wrapper" v-for="(subType, index) in subTypeArray" :key="index">
					<view class="sub-title-box"><text class="sub-title-words">{{subType.secondLevelName}}</text></view>
					<view class="third-box">
						<block v-for="(thirdType, index) in subType.jobTypeThirdVOList" :key="index">
							<view :class="selectedThirdTypeId == thirdType.thirdLevelId ? 'third-lable-selected' : 'third-lable'" @click="selectThirdType(thirdType)">
								<text :class="selectedThirdTypeId == thirdType.thirdLevelId ? 'third-words-selected' : 'third-words'">{{thirdType.thirdLevelName}}</text>
							</view>
						</block>
					</view>
				</view>
				
				<!-- <view class="whole-sub-wrapper">
					<view class="sub-title-box"><text class="sub-title-words">后端开发</text></view>
					<view class="third-box">
						<view class="third-lable-selected"><text class="third-words-selected">Java</text></view>
						<view class="third-lable"><text class="third-words">C++</text></view>
					</view>
				</view> -->
			</scroll-view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				screenHeight: uni.getSystemInfoSync().screenHeight - 100,
				
				selectedMainTypeId: "1001",
				selectedMainTypeValue: "",
				
				selectedThirdTypeId: "",
				selectedThirdTypeValue: "",
				
				mainTypeArray: [],
				mainTypeArray2: [
					{ id: "1001", value: "互联网/IT/电子/通信", subTypes: [this.subTypeArray] },
					{ id: "1002", value: "金融行业" },
					{ id: "1003", value: "广告/传媒/文化/体育" },
					{ id: "1004", value: "教育培训" },
					{ id: "1005", value: "医疗/制药" },
					{ id: "1006", value: "交通/物流/贸易" },
					{ id: "1007", value: "服务行业" },
					{ id: "1008", value: "房地产" },
					{ id: "1009", value: "汽车" },
					{ id: "1010", value: "机械/制造" },
					{ id: "1011", value: "运营" },
					{ id: "1012", value: "人力资源" },
					{ id: "1013", value: "市场/公关" },
					{ id: "1014", value: "生产/制作/研发" },
					{ id: "1015", value: "设计" },
					{ id: "1016", value: "公务员/科研/其他" },
				],
				
				subTypeArray: [],
				subTypeArray2: [
					{
						id: "21001",
						value: "后端开发",
						fatherId: "1001",
						thirdTypeArray: [ 
							{ id: "311001", value: "Java" },
							{ id: "311002", value: "C++" },
							{ id: "311003", value: "PHP" },
							{ id: "311004", value: "Python" },
							{ id: "311005", value: "C" },
							{ id: "311006", value: "C#" },
							{ id: "311007", value: ".Net" },
							{ id: "311008", value: "Ruby" },
							{ id: "311009", value: "VB" },
							{ id: "311010", value: "Node.js" },
							{ id: "311011", value: "ERP技术专家" },
							{ id: "311012", value: "全栈开发" },
						]
					},
					{
						id: "21002",
						value: "前端开发",
						fatherId: "1001",
						thirdTypeArray: [
							{ id: "312001", value: "Java" },
							{ id: "312002", value: "C++" },
							{ id: "312003", value: "PHP" },
							{ id: "312004", value: "Python" },
							{ id: "312005", value: "C" },
							{ id: "312006", value: "C#" },
							{ id: "312007", value: ".Net" },
							{ id: "312008", value: "Ruby" },
							{ id: "312009", value: "VB" },
							{ id: "312010", value: "Node.js" },
							{ id: "312011", value: "ERP技术专家" },
							{ id: "312012", value: "全栈开发" },
						]
					},
					{
						id: "21003",
						value: "全栈开发",
						fatherId: "1001",
						thirdTypeArray: [
							{ id: "313001", value: "Java" },
							{ id: "313002", value: "C++" },
							{ id: "313003", value: "PHP" },
							{ id: "313004", value: "Python" },
							{ id: "313005", value: "C" },
							{ id: "313006", value: "C#" },
							{ id: "313007", value: ".Net" },
							{ id: "313008", value: "Ruby" },
							{ id: "313009", value: "VB" },
							{ id: "313010", value: "Node.js" },
							{ id: "313011", value: "ERP技术专家" },
							{ id: "313012", value: "全栈开发" },
						]
					},
				]
			}
		},
		onShow() {
			this.initTopJobTypeList();
		},
		onLoad() {
			
		},
		onNavigationBarButtonTap(e) {
			if (e.index == 0) {
				this.saveJobType();
			} else if (e.index == 1) {
				this.saveReset();
			}
		},
		methods: {
			initTopJobTypeList() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "GET",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/jobType/app/initTopList",
					success(result) {
						
						if (result.data.status == 200) {
							var list = result.data.data;
							console.log(list);
							me.mainTypeArray = list;
							me.selectedMainTypeId = list[0].id;
							me.selectMainType(list[0]);
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
			
			selectMainType(mainType) {
				this.selectedMainTypeId = mainType.id;
				this.selectedMainTypeValue = mainType.name;
				var topId = mainType.id;
				
				// TODO 从当前前端页面的list中去获得子分类list，如果没有则发起后端请求，如果有的话则不需要再发送请求，避免高并发带来的流量压力
				
					var me = this;
					var userId = app.getUserInfoSession().id;
					
					var serverUrl = app.globalData.serverUrl;
					uni.request({
						method: "GET",
						header: {
							headerUserId: userId,
							headerUserToken: app.getUserSessionToken()
						},
						url: serverUrl + "/jobType/app/getSecondAndThirdListByTop/" + topId,
						success(result) {
							
							if (result.data.status == 200) {
								var list = result.data.data;
								console.log(list);
								me.subTypeArray = list;
								
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
			
			selectThirdType(thirdType) {
				this.selectedThirdTypeId = thirdType.thirdLevelId;
				this.selectedThirdTypeValue = thirdType.thirdLevelName;
			},
			
			saveJobType() {
				
				// console.log(this.selectedThirdTypeValue);
				if (this.selectedThirdTypeValue == null || this.selectedThirdTypeValue == "" || this.selectedThirdTypeValue == undefined) {
					uni.showToast({
						title: "请选择一项职类~",
						icon: "none"
					})
					return;
				}
				
				uni.setStorageSync("selectedJobType", this.selectedThirdTypeValue);
				uni.navigateBack({
					delta: 1
				})
			},
			
			saveReset() {
				uni.setStorageSync("selectedJobType", "");
				uni.navigateBack({
					delta: 1
				})
			}
			
		}
	}
</script>

<style>
	@import url("chooseJobType.css");
</style>
