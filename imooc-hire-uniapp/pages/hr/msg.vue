<!-- HR 互动消息页面 -->
<template>
	<view>
		
		<view class="navigation-bar" style="z-index: 99999;">
			<text class="page-title">互动消息</text>
		</view>
		
		<view class="msg-box">
			
			<view class="item-box" @click="gotoMyCollectResume">
				
				<view class="left-part">
					<image src="../../static/icons/hr/new-join-cand.png" class="face-icon"></image>
					
					<view class="info-box">
						<text class="title-text">我收藏的候选人</text>
						<text class="title-sub-text">收藏的候选人简历都会出现在此</text>
					</view>
				</view>
				
				<view class="right-part">
					<!-- 我关注的，看过我的，都是当前时间 -->
					<!-- <text class="time-text">13:00</text> -->
					<!-- <view class="number-sign-wrapper"><text class="number-sign">9</text></view> -->
				</view>
			</view>
			
			<view class="item-box" @click="showInterestedPendingList">
				
				<view class="left-part">
					<image src="../../static/icons/hr/interested-cand.png" class="face-icon"></image>
					
					<view class="info-box">
						<text class="title-text">我的面试安排</text>
						<text class="title-sub-text">我发布的面试邀约都在此</text>
					</view>
				</view>
				
				<view class="right-part">
					<!-- 我关注的，看过我的，都是当前时间 -->
					<!-- <text class="time-text">15:15</text> -->
					<!-- <view class="number-sign-wrapper"><text class="number-sign">9</text></view> -->
				</view>
			</view>
				
			<view class="item-box" v-for="(msg, index) in lastestCandUserChatList" :key="index" @click="goToMsgList(msg.sourceUserId)">
				<view class="left-part">
					<image :src="msg.face" class="face-icon"></image>
					
					<view class="info-box">
						<text class="title-text">{{msg.name}}</text>
						<text class="title-sub-text">{{msg.msgContent}}</text>
					</view>
				</view>
				
				<view class="right-part">
					<!-- {{DateUtil.formatWeekDatetime(new Date(Date.parse(m.msgSendDateTime)))}} -->
					<text class="time-text">{{DateUtil.formatWeekDatetime(new Date(Date.parse(msg.chatTime)))}}</text>
					<!-- <text class="time-text">{{msg.chatTime}}</text> -->
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
			var CHAT = app.globalData.CHAT;
			return {
				unReadCounts: 1,
				
				msgList:[1,2,3,5,6,7,8,9,10],
				lastestCandUserChatList: [],
				
				CHAT,
			}
		},
		onReachBottom() {
			// this.loadMorMsg();
		},
		onShow() {
			// 把最新的聊天记录列表渲染在此
			this.doMeAFavor();
			
			// 获得我的未读数量map
			// this.getMyUnReadCounts();
		},
		onLoad() {
			console.log('msg.vue - onload');
			var me = this;
			
			// this.CHAT.onMessage(function(res){
			// 	console.log('msg.vue 收到服务器内容：' + res.data);
			// 	me.dealReceiveLastestMsg(JSON.parse(res.data));
			// });
			
			uni.$on("receiveMsgInMsgVue", function(data) {
				// console.log('监听receiveMsgInMsgVue：' + data);
				me.dealReceiveLastestMsg(JSON.parse(data));
			});
			
			uni.$on("reRenderReceiveMsgInMsgVue", function(data) {
				console.log('监听reRenderReceiveMsgInMsgVue：' + data);
				me.doMeAFavor();
			});
		},
		onUnload() {
			uni.$off("receiveMsgInMsgVue");
			uni.$off("reRenderReceiveMsgInMsgVue");
		},
		methods: {
			doMeAFavor() {
				console.log('监听doMeAFavor!!!');
				var lastestCandUserChatList = uni.getStorageSync("lastestCandUserChatList");
				if (lastestCandUserChatList != null && lastestCandUserChatList != undefined && lastestCandUserChatList != "") {
					this.lastestCandUserChatList = lastestCandUserChatList;
					
					// 获得我的未读数量map
					this.getMyUnReadCounts(lastestCandUserChatList);
				}
			},
			
			getMyUnReadCounts(lastestCandUserChatList) {
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
							
							for (var i = 0 ; i < lastestCandUserChatList.length ; i ++) {
								var tempChat = lastestCandUserChatList[i];
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
								lastestCandUserChatList.splice(i, 1, tempChat);
							}
							this.lastestCandUserChatList = lastestCandUserChatList;
						}
					}
				})
			
			},
			
			// 处理收到的消息
			dealReceiveLastestMsg(msgJSON) {
				console.log(msgJSON);
				var chatMsg = msgJSON.chatMsg;
				var chatTime = msgJSON.chatTime;
				var candUserId = chatMsg.senderId;
				
				var receiverType = chatMsg.receiverType;
				if (receiverType != 1) {
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
					url: serverUrl + "/userinfo/get?userId=" + candUserId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var currentSourceUserInfo = result.data.data;
							me.currentSourceUserInfo = currentSourceUserInfo;
							
							// if (chatMsg == 2) {
								
							// }
							me.saveLastestMsgToLocal(candUserId, currentSourceUserInfo, chatMsg.msg, chatTime);
						}
					}
				})
			},
				
			// 记录每个人的最后一条消息，记录在本地，用于显示聊天列表
			saveLastestMsgToLocal(sourceUserId, sourceUser, msgContent, chatTime) {
				
				var lastMsg = {
					sourceUserId: sourceUserId,		// 源头用户，聊天对象，这里是 求职者
					name: sourceUser.nickname,
					face: sourceUser.face,
					msgContent: msgContent,
					chatTime: chatTime,
					unReadCounts: 0
				}
				console.log(lastMsg);
				// return;
				// 先获得本地存储与候选人聊天的list，如果没有则新创建
				var lastestCandUserChatList = uni.getStorageSync("lastestCandUserChatList");
				if (lastestCandUserChatList == null || lastestCandUserChatList == undefined || lastestCandUserChatList == "") {
					lastestCandUserChatList = [];
				}
				
				// 循环判断，如果存在，则剔除，放入最新的
				var dealMsg = false;
				for ( var i = 0 ; i < lastestCandUserChatList.length ; i ++) {
					var tmp = lastestCandUserChatList[i];
					if (tmp.sourceUserId == lastMsg.sourceUserId) {
						lastestCandUserChatList.splice(i, 1, lastMsg);
						dealMsg = true;
						break;
					}
				}
				if (!dealMsg) {
					lastestCandUserChatList.unshift(lastMsg);
				}
				uni.setStorageSync("lastestCandUserChatList", lastestCandUserChatList);
				this.lastestCandUserChatList = lastestCandUserChatList;
				// uni.removeStorageSync("lastestCandUserChatList");
			},
			
			loadMorMsg() {
				this.msgList = this.msgList.concat(this.msgList);
			},
			
			goToMsgList(candUserId) {
				uni.navigateTo({
					url: "msgList?resumeUserId=" + candUserId,
					animationType: "slide-in-right",
					success() {
					}
				});
			},
			
			showInterestedPendingList() {
				uni.navigateTo({
					url: "interview/pendingList",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoMyCollectResume() {
				uni.navigateTo({
					url: "./statistics/collectResume",
					animationType: "slide-in-bottom",
				});
			},
			
			showNewRefreshResume() {
				uni.navigateTo({
					url: "statistics/newRefreshResume",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
		}
	}
</script>

<style>
	@import url("msg.css");
</style>

