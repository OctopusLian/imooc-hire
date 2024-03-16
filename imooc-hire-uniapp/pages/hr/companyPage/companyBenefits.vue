<!-- 公司福利待遇、公司亮点 -->
<template>
	<view>
		<view class="outer-box">
			<view class="title-box-num">
				<text class="title-words" style="font-weight: bold;">公司亮点</text>
				<text :class="{'num-words': myTags.length <= 10, 'num-words-red': myTags.length > 10}">（{{myTags.length}}/10）</text>
			</view>
			<view class="title-box">
				<text class="title-second">突出公司亮点，吸引更多优秀人才~</text>
			</view>
		</view>
		
		
		<view class="outer-box" style="margin-top: 12px;">
			<view class="all-tags">
				<view class="tag-box-selected" v-for="(t, index) in myTags" :key="t.value" style="margin-top: 10px;">
					<text class="tag-item-selected">{{t.itemValue}}</text>
					<image src="../../../static/icons/x.png" class="x" @click="deleteOneTag(t.itemValue)"></image>
				</view>
			</view>
		</view>	
		
		<view class="outer-box" style="margin-top: 40px;">
			<view class="title-box-num">
				<text class="tag-title" style="font-weight: bold;">公司优势</text>
			</view>
			
			<view class="all-tags">
				<!-- :class="{'tag-box-unselected': !p.isSelected, 'tag-box-selected': p.isSelected}" -->
				<!-- class="tag-box-unselected" -->
				<view 
					:class="{'tag-box-unselected': !c.isSelected, 'tag-box-selected': c.isSelected}" 
					style="margin-top: 10px;" 
					v-for="(c, index) in advantageList" 
					:key="c.itemValue"
					@click="chooseCompanyAdvantage(index)">
					<text class="tag-item-selected" >{{c.itemValue}}</text>
				</view>
			</view>
		</view>
		
		<view class="outer-box" style="margin-top: 50px;">
			<view class="title-box-num">
				<text class="tag-title" style="font-weight: bold;">公司福利</text>
			</view>
			
			<view class="all-tags">
				<view
					:class="{'tag-box-unselected': !b.isSelected, 'tag-box-selected': b.isSelected}" 
					style="margin-top: 10px;" 
					v-for="(b, index) in benefitList" 
					:key="b.itemValue"
					@click="chooseBenefit(index)">
					<text class="tag-item-selected" >{{b.itemValue}}</text>
				</view>
				<!-- <view class="tag-box-unselected" style="margin-top: 10px;" v-for="(m, index) in managementStyle" :key="m">
					<text class="tag-item-selected" >{{m}}</text>
				</view> -->
			</view>
		</view>
		
		<view class="outer-box" style="margin-top: 50px;">
			<view class="title-box-num">
				<text class="tag-title" style="font-weight: bold;">薪资福利</text>
			</view>
			
			<view class="all-tags">
				<view
					:class="{'tag-box-unselected': !s.isSelected, 'tag-box-selected': s.isSelected}" 
					style="margin-top: 10px;" 
					v-for="(s, index) in salaryList" 
					:key="s.itemValue"
					@click="chooseSalary(index)">
					<text class="tag-item-selected" >{{s.itemValue}}</text>
				</view>
			</view>
		</view>
		
		<view class="outer-box" style="margin-top: 50px;">
			<view class="title-box-num">
				<text class="tag-title" style="font-weight: bold;">补助津贴</text>
			</view>
			
			<view class="all-tags">
				<view
					:class="{'tag-box-unselected': !s.isSelected, 'tag-box-selected': s.isSelected}" 
					style="margin-top: 10px;" 
					v-for="(s, index) in subsidyList" 
					:key="s.itemValue"
					@click="chooseSubsidy(index)">
					<text class="tag-item-selected" >{{s.itemValue}}</text>
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
				// 公司优势
				advantageList: [],
				companyAdvantageList: [
					{ "icon": "icon-boss-good", "value": "领导好", "isSelected": false},
					{ "icon": "icon-position-up", "value": "岗位晋升", "isSelected": false},
					{ "icon": "icon-management", "value": "扁平化管理", "isSelected": false},
					{ "icon": "icon-standard", "value": "管理规范", "isSelected": false},
					{ "icon": "icon-training", "value": "技能培训", "isSelected": false},
				],		
				// 公司福利
				benefitList: [],
				benefitList2: [
					{ "icon": "icon-umbrella", "value": "五险一金", "isSelected": false},
					{ "icon": "icon-physical-examination", "value": "定期体检", "isSelected": false},
					{ "icon": "icon-briefcase", "value": "弹性工作", "isSelected": false},
					{ "icon": "icon-cake", "value": "节日礼物", "isSelected": false},
					{ "icon": "icon-daba", "value": "免费班车", "isSelected": false},
					{ "icon": "icon-trip", "value": "年度旅游", "isSelected": false},
					{ "icon": "icon-team-building", "value": "团队聚餐", "isSelected": false},
					{ "icon": "icon-doctor", "value": "子女福利", "isSelected": false},
					{ "icon": "icon-car", "value": "公司提供专车", "isSelected": false},
				],		
				// 薪资福利
				salaryList: [
					{ "icon": "icon-money", "value": "年底双薪", "isSelected": false},
					{ "icon": "icon-bonus", "value": "绩效奖金", "isSelected": false},
					{ "icon": "icon-stock", "value": "股票期权", "isSelected": false},
					{ "icon": "icon-vacation", "value": "带薪年假", "isSelected": false},
				],		
				// 补助津贴
				subsidyList: [
					{ "icon": "icon-car2", "value": "交通补助", "isSelected": false},
					{ "icon": "icon-phone", "value": "通讯津贴", "isSelected": false},
					{ "icon": "icon-launch", "value": "午餐补助", "isSelected": false},
					{ "icon": "icon-house", "value": "购房津贴", "isSelected": false},
					{ "icon": "icon-car2", "value": "车辆津贴", "isSelected": false},
					{ "icon": "icon-allowance", "value": "外派津贴", "isSelected": false},
					{ "icon": "icon-feeding-bottle", "value": "生育津贴", "isSelected": false},
				],		
				myTags: [
					
				]
			}
		},
		onShow() {
			this.getCompanyAdvantageList();
			this.getCompanyBenefitList();
			this.getCompanySalaryList();
			this.getCompanySubsidyList();
		},
		onLoad(options) {
			this.companyId = options.companyId;
			this.advantage = options.advantage;
			this.benefits = options.benefits;
			this.bonus = options.bonus;
			this.subsidy = options.subsidy;
			
			var advantageStr = this.advantage;
			var advantageArr = advantageStr.split(",");
			this.advantageArr = advantageArr;
			// console.log(advantageArr);
			
			var benefitsStr = this.benefits;
			var benefitsArr = benefitsStr.split(",");
			this.benefitsArr = benefitsArr;
			
			var bonusStr = this.bonus;
			var bonusArr = bonusStr.split(",");
			this.bonusArr = bonusArr;
			
			var subsidyStr = this.subsidy;
			var subsidyArr = subsidyStr.split(",");
			this.subsidyArr = subsidyArr;
			
			console.log(this.advantage);
			console.log(this.benefits);
			console.log(this.bonus);
			console.log(this.subsidy);
		},
		onNavigationBarButtonTap() {
			// console.log("123");
			var me = this;
			if (me.myTags.length > 10) {
				uni.showToast({
					title: "标签请少于10个~",
					icon: "none",
					duration: 2000
				})
				return;
			}
			
			if (me.myTags.length <= 0) {
				uni.showToast({
					title: "请选择至少1个标签~",
					icon: "none",
					duration: 2000
				})
				return;
			}
			
			this.modifyInfo();
			
			// uni.navigateBack({
			// 	delta: 1
			// })
		},
		methods:{
			modifyInfo() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var myTags = this.myTags;
				// console.log(myTags);
				
				// 公司优势 CompanyAdvantage
				// 公司福利 CompanyBenefit
				// 薪资福利 CompanySalary
				// 补助津贴 CompanySubsidy
				var advantage = ",";
				var benefits = ",";
				var bonus = ",";
				var subsidy = ",";
				for (var i = 0 ; i < myTags.length ; i ++) {
					if (myTags[i].typeCode == "CompanyAdvantage") {
						advantage += myTags[i].itemKey;
						advantage += ",";
					} else if (myTags[i].typeCode == "CompanyBenefit") {
						benefits += myTags[i].itemKey;
						benefits += ",";
					} else if (myTags[i].typeCode == "CompanySalary") {
						bonus += myTags[i].itemKey;
						bonus += ",";
					} else if (myTags[i].typeCode == "CompanySubsidy") {
						subsidy += myTags[i].itemKey;
						subsidy += ",";
					}
				}
				console.log(advantage);
				console.log(benefits);
				console.log(bonus);
				console.log(subsidy);
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"advantage": advantage,
					"benefits": benefits,
					"bonus": bonus,
					"subsidy": subsidy,
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
									// uni.navigateBack({
									// 	delta: 1,
									// 	animationType: "fade-out"
									// })
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
			
			getCompanySubsidyList() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/dataDict/app/getDataByCode?typeCode=CompanySubsidy",
					success(result) {
						
						if (result.data.status == 200) {
							var subsidyList = result.data.data;
							// for (var i = 0 ; i < subsidyList.length ; i ++) {
							// 	subsidyList[i].isSelected = false;
							// }
							
							var subsidyArr = me.subsidyArr;
							for (var i = 0 ; i < subsidyList.length ; i ++) {
								subsidyList[i].isSelected = false;
								for (var j = 0 ; j < subsidyArr.length ; j ++) {
									if (subsidyArr[j] == subsidyList[i].itemKey) {
										subsidyList[i].isSelected = true;
										me.myTags.push(subsidyList[i]);
										break;
									}
								}
							}
							me.subsidyList = subsidyList;
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
			
			getCompanySalaryList() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/dataDict/app/getDataByCode?typeCode=CompanySalary",
					success(result) {
						
						if (result.data.status == 200) {
							var salaryList = result.data.data;
							// for (var i = 0 ; i < salaryList.length ; i ++) {
							// 	salaryList[i].isSelected = false;
							// }
							
							var bonusArr = me.bonusArr;
							for (var i = 0 ; i < salaryList.length ; i ++) {
								salaryList[i].isSelected = false;
								for (var j = 0 ; j < bonusArr.length ; j ++) {
									if (bonusArr[j] == salaryList[i].itemKey) {
										salaryList[i].isSelected = true;
										me.myTags.push(salaryList[i]);
										break;
									}
								}
							}
							me.salaryList = salaryList;
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
			
			getCompanyBenefitList() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/dataDict/app/getDataByCode?typeCode=CompanyBenefit",
					success(result) {
						
						if (result.data.status == 200) {
							var benefitList = result.data.data;
							// for (var i = 0 ; i < benefitList.length ; i ++) {
							// 	benefitList[i].isSelected = false;
							// }
							
							var benefitsArr = me.benefitsArr;
							for (var i = 0 ; i < benefitList.length ; i ++) {
								benefitList[i].isSelected = false;
								for (var j = 0 ; j < benefitsArr.length ; j ++) {
									if (benefitsArr[j] == benefitList[i].itemKey) {
										benefitList[i].isSelected = true;
										me.myTags.push(benefitList[i]);
										break;
									}
								}
							}
							me.benefitList = benefitList;
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
			
			getCompanyAdvantageList() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/dataDict/app/getDataByCode?typeCode=CompanyAdvantage",
					success(result) {
						
						if (result.data.status == 200) {
							var advantageList = result.data.data;
							// console.log(advantageList);
							var advantageArr = me.advantageArr;
							for (var i = 0 ; i < advantageList.length ; i ++) {
								advantageList[i].isSelected = false;
								for (var j = 0 ; j < advantageArr.length ; j ++) {
									if (advantageArr[j] == advantageList[i].itemKey) {
										advantageList[i].isSelected = true;
										me.myTags.push(advantageList[i]);
										break;
									}
								}
							}
							me.advantageList = advantageList;
							// console.log(me.advantageList);
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
			
			
			deleteOneTag(value) {
				var me = this;
				
				var companyAdvantageList = me.advantageList;
				for (var i = 0 ; i < companyAdvantageList.length ; i ++) {
					if (companyAdvantageList[i].itemValue == value) {
						companyAdvantageList[i].isSelected = false;
						me.companyAdvantageList = companyAdvantageList;
						me.removeTagByValue(value);
						break;
					}
				}
				
				var benefitList = me.benefitList;
				for (var i = 0 ; i < benefitList.length ; i ++) {
					if (benefitList[i].itemValue == value) {
						benefitList[i].isSelected = false;
						me.benefitList = benefitList;
						me.removeTagByValue(value);
						break;
					}
				}
				
				var salaryList = me.salaryList;
				for (var i = 0 ; i < salaryList.length ; i ++) {
					if (salaryList[i].itemValue == value) {
						salaryList[i].isSelected = false;
						me.salaryList = salaryList;
						me.removeTagByValue(value);
						break;
					}
				}
				
				var subsidyList = me.subsidyList;
				for (var i = 0 ; i < subsidyList.length ; i ++) {
					if (subsidyList[i].itemValue == value) {
						subsidyList[i].isSelected = false;
						me.subsidyList = subsidyList;
						me.removeTagByValue(value);
						break;
					}
				}
			},
			removeTagByValue(value) {
				var myTags = this.myTags;
				var pendingIndex = -1;
				for (var i = 0 ; i < myTags.length ; i ++) {
					if (myTags[i].itemValue == value) {
						pendingIndex = i;
						break;
					}
				}
				
				if (pendingIndex > -1) {
					myTags.splice(pendingIndex, 1);
				}
				this.myTags = myTags;
			},
			chooseCompanyAdvantage(index) {
				// var companyAdvantageList = this.companyAdvantageList;
				var companyAdvantageList = this.advantageList;
				var targetStatus = !companyAdvantageList[index].isSelected
				companyAdvantageList[index].isSelected = targetStatus;
				this.personalStyle = companyAdvantageList;
				
				if (targetStatus) {
					this.myTags.push(companyAdvantageList[index]);
				} else {
					this.removeTagByValue(companyAdvantageList[index].itemValue);
				}
			},
			chooseBenefit(index) {
				var benefitList = this.benefitList;
				var targetStatus = !benefitList[index].isSelected
				benefitList[index].isSelected = targetStatus;
				this.personalStyle = benefitList;
				
				if (targetStatus) {
					this.myTags.push(benefitList[index]);
				} else {
					this.removeTagByValue(benefitList[index].itemValue);
				}
			},
			chooseSalary(index) {
				var salaryList = this.salaryList;
				var targetStatus = !salaryList[index].isSelected
				salaryList[index].isSelected = targetStatus;
				this.salaryList = salaryList;
				
				if (targetStatus) {
					this.myTags.push(salaryList[index]);
				} else {
					this.removeTagByValue(salaryList[index].itemValue);
				}
			},
			chooseSubsidy(index) {
				var subsidyList = this.subsidyList;
				var targetStatus = !subsidyList[index].isSelected
				subsidyList[index].isSelected = targetStatus;
				this.subsidyList = subsidyList;
				
				if (targetStatus) {
					this.myTags.push(subsidyList[index]);
				} else {
					this.removeTagByValue(subsidyList[index].itemValue);
				}
			},
		}
	}
</script>

<style>
	@import url("companyBenefits.css");
</style>
