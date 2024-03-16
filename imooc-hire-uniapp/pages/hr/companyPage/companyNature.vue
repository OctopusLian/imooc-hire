<!-- 公司性质页面 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper">
				<text class="title-one">公司性质</text>
				<text class="title-two">选择合适的公司性质</text>
			</view>
		
			<radio-group class="radio-group" style="margin-top: 60px;">
				
				<block v-for="(n, index) in companyNatureList" :key="index">
					<view class="radio-item" style="display: flex; justify-content: space-between;">
						<view class="chosen-item">
							<text class="radio-words">{{n.itemValue}}</text>
						</view>
						<radio :value="n.itemValue" :checked="choosedValue == n.itemValue" @click="chooseMe(n)"/>
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
				companyNatureList: [],
				natureArray: [
					"外商独资·外企办事处",
					"中外合资",
					"私营·民营企业",
					"国有企业",
					"国内上市公司",
					"政府机关/非盈利机构",
					"事业单位",
					"其他"
				],
				
				choosedValue: "1-49人",
			}
		},
		onNavigationBarButtonTap() {
			this.modifyPeopleSize();
		},
		onShow() {
			this.getCompanyNatureList();
		},
		onLoad(options) {
			this.companyId = options.companyId;
			this.choosedValue = options.nature;
		},
		methods: {
			modifyPeopleSize() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var nature = this.choosedValue;
				
				if (nature == null || nature == "" || nature == undefined) {
					uni.showToast({
						title: "请选择企业性质",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"nature": nature
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
			
			getCompanyNatureList() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/dataDict/app/getDataByCode?typeCode=CompanyNature",
					success(result) {
						
						if (result.data.status == 200) {
							var companyNatureList = result.data.data;
							console.log(companyNatureList);
							me.companyNatureList = companyNatureList;
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
	@import url("companyNature.css");
</style>
