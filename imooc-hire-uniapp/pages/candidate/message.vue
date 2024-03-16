<!-- 候选人 互动消息页面 -->
<template>
	<view>
		
		<view class="navigation-bar" style="z-index: 99999;">
			<text class="page-title">互动消息</text>
			
			<!-- <view class="publish-btn" @click="gotoPublishNewJob()">
				<image src="../../static/icons/hr/publish.png" class="publish-icon" @click="gotoPublishNewJob()"></image>
			</view> -->
		</view>
		
		<view class="msg-box">
			
			<view class="item-box" @click="showWhoLookMe" style="">
				
				<view class="left-part">
					<image src="../../static/icons/candidate/who-look-me.png" class="face-icon"></image>
					
					<view class="info-box">
						<text class="title-text">谁看过我</text>
						<text class="title-sub-text">看过你的HR都会出现在此</text>
					</view>
				</view>
				
				<view class="right-part">
					<!-- 我关注的，看过我的，都是当前时间 -->
					<!-- <text class="time-text">13:00</text> -->
					<!-- <view class="number-sign-wrapper"><text class="number-sign">9</text></view> -->
				</view>
			</view>
			
			<view class="item-box" @click="showMyFollowedHR">
				
				<view class="left-part">
					<image src="../../static/icons/candidate/my-follow-hr.png" class="face-icon"></image>
					
					<view class="info-box">
						<text class="title-text">我关注的</text>
						<text class="title-sub-text">我关注的HR都在此</text>
					</view>
				</view>
				
				<view class="right-part">
					<!-- 我关注的，看过我的，都是当前时间 -->
					<!-- <text class="time-text">15:15</text> -->
					<!-- <view class="number-sign-wrapper"><text class="number-sign">9</text></view> -->
				</view>
			</view>
			
			<view class="item-box" v-for="(msg, index) in lastestHrUserChatList" :key="index" @click="goChatWithHR(msg.sourceUserId)">
				
				<view class="left-part">
					<image :src="msg.face" class="face-icon"></image>
					
					<view class="info-box">
						<text class="title-text">{{msg.name}}</text>
						<text class="title-sub-text">{{msg.msgContent}}</text>
					</view>
				</view>
				
				<view class="right-part">
					<text class="time-text">{{DateUtil.formatWeekDatetime(new Date(Date.parse(msg.chatTime)))}}</text>
					<!-- <view class="number-sign-wrapper"><text :class="{'number-sign': unReadCounts!=1, 'number-sign-2': unReadCounts==1}">{{unReadCounts > 99 ? '99+' : unReadCounts}}</text></view> -->
					<view class="number-sign-wrapper">
						<uni-badge class="" :text="msg.unReadCounts" type="error" />
						<view v-if="msg.unReadCounts == 0" style="height: 20px;"></view>
					</view>
				</view>
			</view>
			
			<!-- <view class="item-box">
				
				<view class="left-part">
					<image src="../../static/images/me.png" class="face-icon"></image>
					
					<view class="info-box">
						<text class="title-text">风间影月</text>
						<text class="title-sub-text">暂无聊天记录</text>
					</view>
				</view>
				
				<view class="right-part">
					<text class="time-text">15:15</text>
					<view class="number-sign-wrapper"><text class="number-sign">1</text></view>
				</view>
			</view> -->
		</view>
		
	</view>
</template>

<script>
	const app = getApp();
	export default {
		data() {
			const CHAT = app.globalData.CHAT;
			return {
				unReadCounts: 223,
				
				msgList:[1,2,3,5,6,7,8,9,10],
				lastestHrUserChatList: [],
				
				CHAT,
			}
		},
		onShow() {
			// 把最新的聊天记录列表渲染在此
			this.doMeAFavor();
			
			// 获得我的未读数量map
			// this.getMyUnReadCounts();
		},
		onReachBottom() {
			// this.loadMorMsg();
		},
		onLoad() {
			var me = this;
			// this.CHAT.onMessage(function(res){
			// 	// console.log('message.vue 收到服务器内容：' + res.data);
			// 	me.dealReceiveLastestMsg(JSON.parse(res.data));
			// });	
			
			uni.$on("receiveMsgInMsgVue", function(data) {
				console.log('监听receiveMsgInMsgVue：' + data);
				me.dealReceiveLastestMsg(JSON.parse(data));
			});
			
			uni.$on("reRenderReceiveMsgInMsgVue", function(data) {
				me.doMeAFavor();
			});
		},
		onUnload() {
			uni.$off("receiveMsgInMsgVue");
			uni.$off("reRenderReceiveMsgInMsgVue");
		},
		methods: {
			doMeAFavor() {
				var lastestHrUserChatList = uni.getStorageSync("lastestHrUserChatList");
				if (lastestHrUserChatList != null && lastestHrUserChatList != undefined && lastestHrUserChatList != "") {
					this.lastestHrUserChatList = lastestHrUserChatList;
					
					// 获得我的未读数量map
					this.getMyUnReadCounts(lastestHrUserChatList);
				}
			},
			
			getMyUnReadCounts(lastestHrUserChatList) {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/chat/getMyUnReadCounts?myId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var unReadCountsMap = result.data.data;
							console.log(unReadCountsMap);
							
							console.log(lastestHrUserChatList);
							for (var i = 0 ; i < lastestHrUserChatList.length ; i ++) {
								var tempChat = lastestHrUserChatList[i];
								var tempChatSourceUserId = tempChat.sourceUserId;
								var unReadCounts = unReadCountsMap[tempChatSourceUserId];
								if (unReadCounts == null || unReadCounts == "" || unReadCounts == undefined) {
									unReadCounts = 0;
								}
								unReadCounts = parseInt(unReadCounts);
								if (unReadCounts < 0) {
									unReadCounts = 0;
								}
								tempChat.unReadCounts = unReadCounts;
								lastestHrUserChatList.splice(i, 1, tempChat);
							}
							this.lastestHrUserChatList = lastestHrUserChatList;
						}
					}
				})
			
			},
			
			// 处理收到的消息
			dealReceiveLastestMsg(msgJSON) {
				console.log(msgJSON);
				var chatMsg = msgJSON.chatMsg;
				var chatTime = msgJSON.chatTime;
				var hrUserId = chatMsg.senderId;
				
				var receiverType = chatMsg.receiverType;
				if (receiverType != 2) {
					return;
				}
				
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/userinfo/get?userId=" + hrUserId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var currentSourceUserInfo = result.data.data;
							me.currentSourceUserInfo = currentSourceUserInfo;
							
							me.saveLastestMsgToLocal(hrUserId, currentSourceUserInfo, chatMsg.msg, chatTime);
						}
					}
				})
			},
				
			// 记录每个人的最后一条消息，记录在本地，用于显示聊天列表
			saveLastestMsgToLocal(sourceUserId, sourceUser, msgContent, chatTime) {
				
				var lastMsg = {
					sourceUserId: sourceUserId,		// 源头用户，聊天对象，这里是HR
					name: sourceUser.nickname,
					face: sourceUser.face,
					msgContent: msgContent,
					chatTime: chatTime,
					unReadCounts: 0
				}
				console.log(lastMsg);
				// return;
				// 先获得本地存储与候选人聊天的list，如果没有则新创建
				var lastestHrUserChatList = uni.getStorageSync("lastestHrUserChatList");
				if (lastestHrUserChatList == null || lastestHrUserChatList == undefined || lastestHrUserChatList == "") {
					lastestHrUserChatList = [];
				}
				
				// 循环判断，如果存在，则剔除，放入最新的
				var dealMsg = false;
				for ( var i = 0 ; i < lastestHrUserChatList.length ; i ++) {
					var tmp = lastestHrUserChatList[i];
					if (tmp.sourceUserId == lastMsg.sourceUserId) {
						lastestHrUserChatList.splice(i, 1, lastMsg);
						dealMsg = true;
						break;
					}
				}
				if (!dealMsg) {
					lastestHrUserChatList.unshift(lastMsg);
				}
				uni.setStorageSync("lastestHrUserChatList", lastestHrUserChatList);
				this.lastestHrUserChatList = lastestHrUserChatList;
				// uni.removeStorageSync("lastestHrUserChatList");
			},
			
			loadMorMsg() {
				this.msgList = this.msgList.concat(this.msgList);
			},
			
			goChatWithHR(hrUserId) {
				uni.navigateTo({
					url: "messageList?hrUserId=" + hrUserId,
					animationType: "slide-in-right",
					success() {
					}
				});
			},
			
			showMyFollowedHR() {
				uni.navigateTo({
					url: "countsPage/myFollowedHR",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			showWhoLookMe() {
				uni.navigateTo({
					url: "countsPage/whoLookMe",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
		}
	}
</script>

<style>
	@import url("message.css");
</style>

