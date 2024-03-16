<template>
	<view>
		
		<view class="top">
			<image :src="personImg" class="hr"></image>
			
			<view class="words-wrappe">
				<text class="words">你当前的身份为“{{whoami}}”</text>
			</view>
		</view>
		
		<view class="btn-wrapper">
			 <!-- style="margin-top: 160px;" -->
			<view class="btn-change" @click="changePersonType()">
				<text class="change-words">切换为“{{theOtherPerson}}”身份</text>
			</view>
			
			<view class="btn-back" style="margin-top: 16px;" @click="goBack()">
				<text class="back-words">返回</text>
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		components: {
		},
		data() {
			return {
				whoami: "",
				theOtherPerson: "",
				personType: null,
				personImg: ""
			}
		},
		onShow() {
			var me = this;
			var personType = uni.getStorageSync('userType');
			// console.log("userType=" + personType);
			// console.log("me.userType.hr=" + me.userType.candidate);
			me.personType = personType;
			
			if (personType == me.userType.hr) {
				me.whoami = "招聘者";
				me.theOtherPerson = "求职者";
				me.personImg = "../../static/images/hr2.png";
			} else {
				me.whoami = "求职者";
				me.theOtherPerson = "招聘者";
				me.personImg = "../../static/images/cand.png";
			}
			
			uni.hideTabBar();
		},
		onHide() {
			uni.showTabBar();
		},
		onLoad() {
		},
		methods: {
			changePersonType() {
				var personType = this.personType;
				// console.log(111)
				var me = this;
				if (personType == me.userType.hr) {
					// console.log(222)
					uni.setStorageSync('userType', me.userType.candidate);
					app.changeToCandidate();
				} else {
					// console.log(333)
					uni.setStorageSync('userType', me.userType.hr);
					app.changeToHR();
				}
				uni.showTabBar();
			},
			goBack() {
				var me = this;
				var personType = this.personType;
				if (personType == me.userType.hr) {
					uni.switchTab({
						url: "../hr/me"
					});
				} else {
					uni.switchTab({
						url: "../candidate/mine"
					});
				}
			}
		}
	}
</script>

<style>
	@import url("changePerson.css");
</style>