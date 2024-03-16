<!-- HR 个人信息页面 -->
<template>
	<view>
		<view class="block-box">
			<view class="block-line">
				<view class="left-part">
					<text class="field-lable">头像</text>
				</view>
				
				<view class="right-part" @click="goToEditMyFace()">
					<image v-if="currentUserInfo == null" src="../../static/images/me.png" class="small-face"></image>
					<image v-if="currentUserInfo != null" :src="currentUserInfo.face" class="small-face"></image>
					
					<image src="../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
				</view>
			</view>
			
			<view class="line-wrapper" v-show="currentUserType == 1"><view class="line"></view></view>
			
			<view class="block-line" v-show="currentUserType == 1">
				<view class="left-part">
					<text class="field-lable">姓名</text>
				</view>
				
				<view class="right-part" @click="goToEditMyName()">
					<text v-if="currentUserInfo == null" class="field-words">孙悟空</text>
					<!-- <text v-if="currentUserInfo != null" class="field-words">{{currentUserInfo.showWhichName == 1 ? currentUserInfo.realName : currentUserInfo.nickname}}</text> -->
					<text v-if="currentUserInfo != null" class="field-words">{{currentUserInfo.realName}}</text>
					
					<image src="../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
				</view>
			</view>
			
			<view class="line-wrapper"><view class="line"></view></view>
			
			<view class="block-line">
				<view class="left-part">
					<text class="field-lable">称谓</text>
				</view>
				
				<view class="right-part" @click="goToEditMySex()">
					<text v-if="currentUserInfo == null" class="field-words">保密</text>
					<text v-if="currentUserInfo != null && currentUserInfo.sex == 1" class="field-words">先生</text>
					<text v-if="currentUserInfo != null && currentUserInfo.sex == 0" class="field-words">女士</text>
					<text v-if="currentUserInfo != null && currentUserInfo.sex == 2" class="field-words">保密</text>
					
					<image src="../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
				</view>
			</view>
			
			<view class="line-wrapper"><view class="line"></view></view>
			
			<view class="block-line">
				<view class="left-part">
					<text class="field-lable">昵称</text>
				</view>
				
				<view class="right-part" @click="goToEditMyNickname()">
					<text v-if="currentUserInfo == null" class="field-words">风间影月</text>
					<text v-if="currentUserInfo != null" class="field-words">{{currentUserInfo.nickname}}</text>
					
					<image src="../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
				</view>
			</view>
			
			<view class="line-wrapper" v-show="currentUserType == 2"><view class="line"></view></view>
			
			<view class="block-line" v-show="currentUserType == 2">
				<view class="left-part">
					<text class="field-lable">生日</text>
				</view>
				
				<view class="right-part" @click="">
					<!-- <text class="field-words">1999-09</text> -->
					<picker mode="multiSelector" :range="dateRange" :value="currentUserInfo.birthday" @change="bindBirthdayChange"
						:class="currentUserInfo == null ? 'picker' : 'picker-words'">
						<view class="field-words">{{currentUserInfo.birthday}}</view>
					</picker>
					<image src="../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
				</view>
			</view>
			
			<view class="line-wrapper"><view class="line"></view></view>
			
			<view class="block-line">
				<view class="left-part">
					<text class="field-lable">手机号</text>
				</view>
				
				<view class="right-part">
					<text class="field-words">139******88</text>
					<!-- <image src="../../static/icons/right-arrow-gray.png" class="right-arrow"></image> -->
				</view>
			</view>
			
			<view class="line-wrapper"><view class="line"></view></view>
			
			<view class="block-line">
				<view class="left-part">
					<text class="field-lable">邮箱</text>
				</view>
				
				<view class="right-part" @click="goToEditMyEmail()">
					<text v-if="currentUserInfo == null" class="field-words undo">未填写</text>
					<text v-if="currentUserInfo != null" class="field-words">{{(currentUserInfo.email == null || currentUserInfo.email == '') ? "未填写" : currentUserInfo.email}}</text>
					<!-- <text class="field-words">abc@imooc.com</text> -->
					<image src="../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
				</view>
			</view>
			
			<view class="line-wrapper" v-show="currentUserType == 2"><view class="line"></view></view>
			
			<view class="block-line" v-show="currentUserType == 2">
				<view class="left-part">
					<text class="field-lable">参加工作时间</text>
				</view>
				
				<view class="right-part" @click="">
					<!-- <text class="field-words">2005-09</text> -->
					<picker mode="multiSelector" :range="workYearRange" :value="currentUserInfo.startWorkDate" @change="bindWorkYearChange"
						:class="(currentUserInfo == null || currentUserInfo.startWorkDate == null || currentUserInfo.startWorkDate == '') ? 'picker' : 'picker-words'">
						<view class="field-words">{{(currentUserInfo.startWorkDate == null || currentUserInfo.startWorkDate == '') ? "请选择" : currentUserInfo.startWorkDate}}</view>
					</picker>
					<image src="../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
				</view>
			</view>
			
			<view class="line-wrapper"><view class="line"></view></view>
			
			<view class="block-line">
				<view class="left-part">
					<text class="field-lable">我的职务</text>
				</view>
				
				<view class="right-part" @click="goToEditMyPosition()">
					<text v-if="currentUserInfo == null" class="field-words">技术经理</text>
					<text v-if="currentUserInfo != null" class="field-words">{{currentUserInfo.position}}</text>
					
					<image src="../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
				</view>
			</view>
			
			<view class="line-wrapper"><view class="line"></view></view>
			
			<view class="block-line" v-show="currentUserType == 1">
				<view class="left-part">
					<text class="field-lable">我认证的公司</text>
				</view>
				
				<view class="right-part" @click="goToEditMyCompany()">
					<text class="field-words">{{companyInfo == null ? '慕课网' : companyInfo.shortName }}</text>
					<image src="../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
				</view>
			</view>
			
			<view class="line-wrapper" v-show="currentUserType == 1"><view class="line"></view></view>
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
			const months = []
			const month = date.getMonth() + 1
			const days = []
			const day = date.getDate()
			for (let i = 1990; i <= date.getFullYear(); i++) {
				years.push(i)
			}
			for (let i = 1; i <= 12; i++) {
				months.push(i)
			}
			for (let i = 1; i <= 31; i++) {
				days.push(i)
			}
			return {
				currentUserType: null,
				
				birthday: "请选择",
				workYear: "请选择",
				startWorkYear: "",
				
				years,
				year,
				months,
				month,
				days,
				day,
				dateRange: [
					years, 
					months,
					days
				],
				workYearRange: [
					years, 
					months
				],
				
				currentUserInfo: null, 
				companyInfo: null,
			}
		},
		onShow() {
			// 获得用户信息
			var currentUserInfo = getApp().getUserInfoSession();
			this.currentUserInfo = currentUserInfo;
			
			this.getCompanyInfo();
		},
		onLoad(options) {
			// console.log(options);
			this.currentUserType = options.type;
		},
		methods: {
			getCompanyInfo() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/information?hrUserId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var companyInfo = result.data.data;
							me.companyInfo = companyInfo;
							// console.log(companyInfo);
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
			
			bindWorkYearChange(e) {
				var selectedArray = e.detail.value;
				var yearIndex = selectedArray[0];
				var monthIndex = selectedArray[1];
				
				var year = this.workYearRange[0][yearIndex];
				var month = this.workYearRange[1][monthIndex];
				
				this.workYear = year + "-" + (month < 10 ? '0' + month : month);
				this.startWorkYear = year + "-" + (month < 10 ? '0' + month : month) + "-01";
				
				this.currentUserInfo.startWorkDate = this.startWorkYear;
				
				this.updateStartWorkDate(this.startWorkYear);
			},
			
			updateStartWorkDate(startWorkDate) {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				console.log("startWorkDate=" + startWorkDate);
				var pendingUserInfo = {
					"userId": userId,
					"startWorkDate": startWorkDate
				};
				
				// 修改昵称
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/userinfo/modify",
					data: pendingUserInfo,
					success(result) {
						
						if (result.data.status == 200) {
							var userInfo = result.data.data;
							// 重置本地用户信息
							app.setUserInfoSession(userInfo);
							app.setUserSessionToken(userInfo.userToken);
							
							uni.showToast({
								title: "修改成功~",
								duration: 1500,
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
			
			bindBirthdayChange(e) {
				var selectedArray = e.detail.value;
				var yearIndex = selectedArray[0];
				var monthIndex = selectedArray[1];
				var dayIndex = selectedArray[2];
				
				var year = this.dateRange[0][yearIndex];
				var month = this.dateRange[1][monthIndex];
				var day = this.dateRange[2][dayIndex];
				
				this.birthday = year + "-" + (month < 10 ? '0' + month : month) + "-" + (day < 10 ? '0' + day : day);
				this.currentUserInfo.birthday = this.birthday;
				
				this.updateBirthday(this.birthday);
			},
			
			updateBirthday(birthday) {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var pendingUserInfo = {
					"userId": userId,
					"birthday": birthday
				};
				
				// 修改昵称
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/userinfo/modify",
					data: pendingUserInfo,
					success(result) {
						
						if (result.data.status == 200) {
							var userInfo = result.data.data;
							// 重置本地用户信息
							app.setUserInfoSession(userInfo);
							app.setUserSessionToken(userInfo.userToken);
							
							uni.showToast({
								title: "修改成功~",
								duration: 1500,
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
			
			goToEditMyFace() {
				uni.navigateTo({
					url: "../userInfo/myFace",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToEditMyName() {
				uni.navigateTo({
					url: "../userInfo/myName",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToEditMySex() {
				uni.navigateTo({
					url: "../userInfo/mySex",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToEditMyNickname() {
				uni.navigateTo({
					url: "../userInfo/myNickname",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToEditMyEmail() {
				uni.navigateTo({
					url: "../userInfo/myEmail",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToEditMyPosition() {
				uni.navigateTo({
					url: "../userInfo/myPosition",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToEditMyCompany() {
				uni.navigateTo({
					url: "../userInfo/myCompany",
					animationType: "slide-in-bottom",
					success() {
					}
				});
				
				// uni.setStorageSync('editMyCompany', 1);
				// uni.switchTab({
				// 	url: "../welcome/changePerson"
				// });
			},
		}
	}
</script>

<style>
	@import url("hrInfo.css");
</style>
