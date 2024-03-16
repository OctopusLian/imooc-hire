<!-- 公司性质页面 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper">
				<text class="title-one">融资阶段</text>
				<text class="title-two">公司的融资状态是公司发展阶段的重要体验，也使得企业形象更加丰富和全面噢~</text>
			</view>
		
			<radio-group class="radio-group" style="margin-top: 60px;">
				
				<block v-for="(f, index) in financList" :key="index">
					<view class="radio-item" style="display: flex; justify-content: space-between;">
						<view class="chosen-item">
							<text class="radio-words">{{f.itemValue}}</text>
						</view>
						<radio :value="f.itemValue" :checked="choosedValue == f.itemValue" @click="chooseMe(f)"/>
						<!-- <radio :value="f" :checked="checked == index" @click="chooseMe(f)"/> -->
					</view>
					
					<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				</block>
				
			</radio-group>
		
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				checked: 0,
				financList: [],
				financArray: [
					"未融资",
					"天使轮",
					"A轮",
					"B轮",
					"C轮",
					"D轮及以上",
					"已上市",
					"战略融资",
					"不需要融资",
					"其他",
				],
				
				choosedValue: "未融资",
			}
		},
		onNavigationBarButtonTap() {
			this.modifyFinanceStage();
		},
		onShow() {
			this.getCompanyFinanecList();
		},
		onLoad(options) {
			this.companyId = options.companyId;
			this.choosedValue = options.financStage;
		},
		methods: {
			modifyFinanceStage() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var financStage = this.choosedValue;
				
				if (financStage == null || financStage == "" || financStage == undefined) {
					uni.showToast({
						title: "请选择融资阶段",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"financStage": financStage
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
							
							uni.navigateBack({
								delta: 1,
								animationType: "fade-out"
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
			
			getCompanyFinanecList() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/dataDict/app/getDataByCode?typeCode=FinanceStage",
					success(result) {
						
						if (result.data.status == 200) {
							var financList = result.data.data;
							console.log(financList);
							me.financList = financList;
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
				console.log(item);
				this.choosedValue = item.itemValue;
			},
			
			submitChoose() {
				uni.navigateBack({
					delta: 1
				})
			}
			
		}
	}
</script>

<style>
	@import url("companyFinancing.css");
</style>
