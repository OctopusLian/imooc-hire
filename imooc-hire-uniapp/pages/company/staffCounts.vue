<!-- 人员规模页面 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper">
				<text class="title-one">人员规模</text>
				<text class="title-two">完善公司资料可以获得更多候选人关注</text>
			</view>
		
			<radio-group class="radio-group" style="margin-top: 60px;">
				
				<block v-for="(s, index) in staffCountsList" :key="index">
					<view class="radio-item" style="display: flex; justify-content: space-between;">
						<view class="chosen-item">
							<text class="radio-words">{{s.itemValue}}</text>
						</view>
						<!-- <radio :value="s" :checked="checked == index" @click="chooseMe(s)"/> -->
						<radio :value="s.itemValue" :checked="choosedValue == s.itemValue" @click="chooseMe(s)"/>
					</view>
					
					<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				</block>
				
			</radio-group>
			
			<view class="btn-next-wrapper" @click="submitChoose()">
				<text class="btn-next-words">确认选择</text>
			</view>
		
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				checked: 0,
				staffCountsList: [
					"1-49人",
					"50-99人",
					"100-499人",
					"500-999人",
					"1000-2000人",
					"2000-5000人",
					"5000-10000人",
					"10000人以上"
				],
				
				choosedValue: "",
			}
		},
		onNavigationBarButtonTap() {
			
		},
		onShow() {
			// uni.setStorageSync("choosedStaffCounts", this.choosedValue);
			
			var choosedStaffCounts = uni.getStorageSync("choosedStaffCounts");
			if (choosedStaffCounts != undefined && choosedStaffCounts != "" && choosedStaffCounts != null) {
				this.choosedValue = choosedStaffCounts;
			}
			
			this.getStaffCountsList();
		},
		onLoad() {
			
		},
		methods: {
			getStaffCountsList() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/dataDict/app/getDataByCode?typeCode=StaffCounts",
					success(result) {
						
						if (result.data.status == 200) {
							var staffCountsList = result.data.data;
							console.log(staffCountsList);
							me.staffCountsList = staffCountsList;
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
			
			chooseMe(item) {
				// console.log(item);
				this.choosedValue = item.itemValue;
				uni.setStorageSync("choosedStaffCounts", this.choosedValue);
			},
			
			submitChoose() {
				// console.log(this.choosedValue);
				if (this.choosedValue == null || this.choosedValue == undefined || this.choosedValue == "") {
					uni.showToast({
						title: "请选择人员规模",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				uni.navigateBack({
					delta: 1
				})
			}
			
		}
	}
</script>

<style>
	@import url("staffCounts.css");
</style>
