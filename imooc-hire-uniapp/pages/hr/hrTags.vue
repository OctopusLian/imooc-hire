<!-- HR 个人签名页 -->
<template>
	<view>
		<view class="outer-box">
			<view class="title-box-num">
				<text class="title-words" style="font-weight: bold;">添加标签</text>
				<!-- <text class="num-words">（{{myTags.length}}/10）</text> -->
				<text :class="{'num-words': myTags.length <= 10, 'num-words-red': myTags.length > 10}">（{{myTags.length}}/10）</text>
			</view>
			<view class="title-box">
				<text class="title-second">添加标签彰显你的独特个性，吸引更多优秀人才~</text>
			</view>
		</view>
		
		
		<view class="outer-box" style="margin-top: 12px;">
			<view class="all-tags">
				<view class="tag-box-selected" v-for="(t, index) in myTags" :key="t.value" style="margin-top: 10px;">
					<text class="tag-item-selected">{{t.value}}</text>
					<image src="../../static/icons/x.png" class="x" @click="deleteOneTag(t.value)"></image>
				</view>
			</view>
		</view>	
		
		<view class="outer-box" style="margin-top: 30px;">
			<view class="title-box-num">
				<text class="tag-title" style="font-weight: bold;">个人身份</text>
			</view>
			
			<view class="all-tags">
				<!-- :class="{'tag-box-unselected': !p.isSelected, 'tag-box-selected': p.isSelected}" -->
				<!-- class="tag-box-unselected" -->
				<view 
					:class="{'tag-box-unselected': !p.isSelected, 'tag-box-selected': p.isSelected}" 
					style="margin-top: 10px;" 
					v-for="(p, index) in personalStyle" 
					:key="p.value"
					@click="choosePersonalStyle(index)">
					<text class="tag-item-selected" >{{p.value}}</text>
				</view>
			</view>
		</view>
		
		<!-- <view class="outer-box" style="margin-top: 30px;">
			<view class="title-box-num">
				<text class="tag-title" style="font-weight: bold;">个人身份</text>
			</view>
			
			<view class="all-tags">
				<block v-for="(p, index) in personalStyle" :key="p">
					<text class="tag-item" >{{p}}</text>
				</block>
			</view>
		</view> -->
		
		<view class="outer-box" style="margin-top: 30px;">
			<view class="title-box-num">
				<text class="tag-title" style="font-weight: bold;">管理风格</text>
			</view>
			
			<view class="all-tags">
				<view
					:class="{'tag-box-unselected': !m.isSelected, 'tag-box-selected': m.isSelected}" 
					style="margin-top: 10px;" 
					v-for="(m, index) in managementStyle" 
					:key="m.value"
					@click="chooseManagementStyle(index)">
					<text class="tag-item-selected" >{{m.value}}</text>
				</view>
				<!-- <view class="tag-box-unselected" style="margin-top: 10px;" v-for="(m, index) in managementStyle" :key="m">
					<text class="tag-item-selected" >{{m}}</text>
				</view> -->
			</view>
		</view>
		
		<view class="outer-box" style="margin-top: 30px;">
			<view class="title-box-num">
				<text class="tag-title" style="font-weight: bold;">性格特点</text>
			</view>
			
			<view class="all-tags">
				<view
					:class="{'tag-box-unselected': !c.isSelected, 'tag-box-selected': c.isSelected}" 
					style="margin-top: 10px;" 
					v-for="(c, index) in characterStyle" 
					:key="c.value"
					@click="chooseCharacterStyle(index)">
					<text class="tag-item-selected" >{{c.value}}</text>
				</view>
				<!-- <view class="tag-box-unselected" style="margin-top: 10px;" v-for="(c, index) in characterStyle" :key="c">
					<text class="tag-item-selected" >{{c}}</text>
				</view> -->
			</view>
		</view>
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				personalStyle: [
					{ "value": "行业大牛", "isSelected": false},
					{ "value": "职场老司机", "isSelected": false},
					{ "value": "资深架构师", "isSelected": false},
					{ "value": "资深HR", "isSelected": false},
					{ "value": "创业达人", "isSelected": false},
					{ "value": "老板本人", "isSelected": false},
					{ "value": "团队负责人", "isSelected": false}
				],		// 个人身份
				managementStyle: [
					{ "value": "激励管理", "isSelected": false},
					{ "value": "目标管理", "isSelected": false},
					{ "value": "绩效管理", "isSelected": false},
					{ "value": "团队建设", "isSelected": false},
					{ "value": "KPI考核", "isSelected": false},
					{ "value": "OKR管理", "isSelected": false},
					{ "value": "扁平化管理", "isSelected": false}
				],		// 管理风格
				characterStyle: [
					{ "value": "完美主义者", "isSelected": false},
					{ "value": "亲和力", "isSelected": false},
					{ "value": "稳健", "isSelected": false},
					{ "value": "有激情", "isSelected": false},
					{ "value": "乐观主义", "isSelected": false},
					{ "value": "二次元", "isSelected": false},
					{ "value": "游戏宅", "isSelected": false},
					{ "value": "批判性思维", "isSelected": false}
				],		// 性格特点
				myTags: [
					
				],
				tagsStr: "",
				
				currentUserInfo: null,
			}
		},
		onShow() {
			// 获得用户信息
			var currentUserInfo = getApp().getUserInfoSession();
			this.currentUserInfo = currentUserInfo;
			
			
			var hrTags = currentUserInfo.hrTags;
			var tagsArr = hrTags.split(",");
			var dbTags = [];
			for (var i = 0 ; i < tagsArr.length ; i ++) {
				var temp = tagsArr[i];
				if (temp != null && temp != "" && temp != undefined) {
					dbTags.push(temp);
				}
			}
			this.initRenderTags(dbTags);
			
			
		},
		onLoad(e) {
		},
		onNavigationBarButtonTap() {
			// console.log("123");
			var me = this;
			if (me.myTags.length > 10) {
				uni.showToast({
					title: "个人标签请少于10个~",
					icon: "none",
					duration: 3000
				})
				return;
			}
			
			if (me.myTags.length < 1) {
				uni.showToast({
					title: "请选择至少1个标签",
					icon: "none",
					duration: 3000
				})
				return;
			}
			
			var tagsStr = ",";
			for (var i = 0 ; i < me.myTags.length ; i ++) {
				tagsStr += me.myTags[i].value;
				tagsStr += ",";
			}
			
			console.log(tagsStr);
			this.updateTags(tagsStr);
		},
		methods:{
			initRenderTags(dbTags) {
				var me = this;
				
				var personalStyle = me.personalStyle;
				for (var i = 0 ; i < personalStyle.length ; i ++) {
					for (var j = 0 ; j < dbTags.length ; j ++) {
						if (personalStyle[i].value == dbTags[j]) {
							personalStyle[i].isSelected = true;
							me.myTags.push(personalStyle[i]);
							continue;
						}
					}
				} 
				this.personalStyle = personalStyle;
				
				
				var managementStyle = me.managementStyle;
				for (var i = 0 ; i < managementStyle.length ; i ++) {
					for (var j = 0 ; j < dbTags.length ; j ++) {
						if (managementStyle[i].value == dbTags[j]) {
							managementStyle[i].isSelected = true;
							me.myTags.push(managementStyle[i]);
							continue;
						}
					}
				}
				this.managementStyle = managementStyle;
				
				
				var characterStyle = me.characterStyle;
				for (var i = 0 ; i < characterStyle.length ; i ++) {
					for (var j = 0 ; j < dbTags.length ; j ++) {
						if (characterStyle[i].value == dbTags[j]) {
							characterStyle[i].isSelected = true;
							me.myTags.push(characterStyle[i]);
							continue;
						}
					}
				}
				this.characterStyle = characterStyle;
			},
			
			updateTags(tagsStr) {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var hrTags = tagsStr;
				
				var pendingUserInfo = {
					"userId": userId,
					"hrTags": hrTags
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
								success() {
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
			
			deleteOneTag(value) {
				var me = this;
				
				var personalStyle = me.personalStyle;
				for (var i = 0 ; i < personalStyle.length ; i ++) {
					if (personalStyle[i].value == value) {
						personalStyle[i].isSelected = false;
						me.personalStyle = personalStyle;
						me.removeTagByValue(value);
						break;
					}
				}
				
				var managementStyle = me.managementStyle;
				for (var i = 0 ; i < managementStyle.length ; i ++) {
					if (managementStyle[i].value == value) {
						managementStyle[i].isSelected = false;
						me.managementStyle = managementStyle;
						me.removeTagByValue(value);
						break;
					}
				}
				
				var characterStyle = me.characterStyle;
				for (var i = 0 ; i < characterStyle.length ; i ++) {
					if (characterStyle[i].value == value) {
						characterStyle[i].isSelected = false;
						me.characterStyle = characterStyle;
						me.removeTagByValue(value);
						break;
					}
				}
			},
			removeTagByValue(value) {
				var myTags = this.myTags;
				var pendingIndex = -1;
				for (var i = 0 ; i < myTags.length ; i ++) {
					if (myTags[i].value == value) {
						pendingIndex = i;
						break;
					}
				}
				
				if (pendingIndex > -1) {
					myTags.splice(pendingIndex, 1);
				}
				this.myTags = myTags;
			},
			choosePersonalStyle(index) {
				var personalStyleArr = this.personalStyle;
				var targetStatus = !personalStyleArr[index].isSelected
				personalStyleArr[index].isSelected = targetStatus;
				this.personalStyle = personalStyleArr;
				
				if (targetStatus) {
					this.myTags.push(personalStyleArr[index]);
				} else {
					this.removeTagByValue(personalStyleArr[index].value);
				}
			},
			chooseManagementStyle(index) {
				var managementStyleArr = this.managementStyle;
				var targetStatus = !managementStyleArr[index].isSelected
				managementStyleArr[index].isSelected = targetStatus;
				this.managementStyle = managementStyleArr;
				
				if (targetStatus) {
					this.myTags.push(managementStyleArr[index]);
				} else {
					this.removeTagByValue(managementStyleArr[index].value);
				}
			},
			chooseCharacterStyle(index) {
				var characterStyleArr = this.characterStyle;
				var targetStatus = !characterStyleArr[index].isSelected
				characterStyleArr[index].isSelected = targetStatus;
				this.characterStyle = characterStyleArr;
				
				if (targetStatus) {
					this.myTags.push(characterStyleArr[index]);
				} else {
					this.removeTagByValue(characterStyleArr[index].value);
				}
			},
		}
	}
</script>

<style>
	@import url("hrTags.css");
</style>
