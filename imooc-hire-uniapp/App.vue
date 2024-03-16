<script>
	import provinceList from './json/area_province.js';
	import cityList from './json/area_city.js';
	import districtList from './json/area_district.js';
	export default {
		globalData: {
			serverUrl: "http://192.168.1.6:8000",		// 开发环境，不能使用localhost
			// serverUrl: "http://localhost",					// 错误示范！！！
			// serverUrl: "http://192.168.1.6",					// 生产环境
			
			chatServerUrl: "ws://192.168.1.6:875/ws",
			
			provinceList: provinceList,
			cityList: cityList,
			districtList: districtList,
			
			// 整个聊天的websocket对象
			CHAT: null,
			// 用于标记当前的聊天服务有没有连接上
			chatSocketOpen: false,
		},
		data() {
			return {
				userType: {
					hr: 1,
					candidate: 2
				}
			}
		},
		onLaunch: function() {
			console.log('App Launch')
			// 判断当前用户身份，根据全局本地缓存的身份来显示当前用户界面为HR或是候选人
			// var userType = uni.getStorageSync('userType');
			// if (userType === this.userType.hr) {
			// 	this.changeToHR();
			// } else {
			// 	this.changeToCandidate();
			// }
			
			// 程序启动的时候，连接聊天服务器
			var me = this;
			if (me.getUserInfoSession() != null && me.getUserInfoSession() != "" && me.getUserInfoSession() != undefined) {
				me.globalData.CHAT = uni.connectSocket({
					url: me.globalData.chatServerUrl,
					complete: ()=> {}
				});
				
				// 当客户端和聊天服务连接，表示ws连接打开，则会被监听到
				me.globalData.CHAT.onOpen(function(){
					me.globalData.chatSocketOpen = true;
					console.log("ws连接已打开，socketOpen = " + me.globalData.chatSocketOpen);
					
					var chatMsg = {
						senderId: me.getUserInfoSession().id,
						msgType: 0
					}
					var dataContent = {
						chatMsg: chatMsg
					}
					var msgPending = JSON.stringify(dataContent);
					
					// 第一次初始化，发送的初始化消息
					me.globalData.CHAT.send({
						data: msgPending
					});
				});
				me.globalData.CHAT.onClose(function(){
					me.globalData.chatSocketOpen = false;
					console.log("ws连接已关闭，socketOpen = " + me.globalData.chatSocketOpen);
				});
				
				me.globalData.CHAT.onMessage(function(res){
					console.log('App.vue 收到服务器内容：' + res.data);
					
					me.dealReceiveLastestMsgForCandUser(JSON.parse(res.data));
					me.dealReceiveLastestMsgForHrUser(JSON.parse(res.data));
					
					// uni.$emit('receiveMsgInMsgVue', res.data);
					uni.$emit('receiveMsgInMsgListVue', res.data);
				});
				
				// 连接失败
				me.globalData.CHAT.onError(function(){
					me.globalData.chatSocketOpen = false;
					console.log('WebSocket连接打开失败，请检查！');
				});
			}
			
		},
		onShow: function() {
			console.log('App Show')
			
			// ws重连
			// if (!me.globalData.chatSocketOpen) {
			// 	me.globalData.chatSocketOpen = true;
			// }
		},
		onHide: function() {
			console.log('App Hide')
		},
		methods: {
			closeWSConnect() {
				this.globalData.CHAT.close();
			},
			
			reConnect() {
				var me = this;
				
				uni.showToast({
					icon: "loading",
					title: "断线重连中...",
					duration: 8000
				});
				
				me.globalData.CHAT = uni.connectSocket({
					url: me.globalData.chatServerUrl,
					complete: ()=> {},
				});
				
				me.globalData.CHAT.onOpen(function(){
					me.globalData.chatSocketOpen = true;
					console.log("ws重连成功，socketOpen = " + me.globalData.chatSocketOpen);
					// 重连成功，重新获得最新聊天记录列表，以防万一有新的消息，在服务器宕机的时候么有接收到
					uni.$emit('reFetchMsgListFromFirstPage', "Hei Boys~");
					
					var chatMsg = {
						senderId: me.getUserInfoSession().id,
						msgType: 0
					}
					var dataContent = {
						chatMsg: chatMsg
					}
					var msgPending = JSON.stringify(dataContent);
					
					me.globalData.CHAT.send({
						data: msgPending
					});
					uni.hideToast();
					
					uni.showToast({
						icon: "none",
						title: "服务器开了小差，请重新发送消息~",
						duration: 2000
					});
				});
				
				me.globalData.CHAT.onClose(function(){
					me.globalData.chatSocketOpen = false;
					console.log("ws连接已关闭，socketOpen = " + me.globalData.chatSocketOpen);
				});
				
				me.globalData.CHAT.onMessage(function(res){
					console.log('App.vue 收到服务器内容：' + res.data);
					
					me.dealReceiveLastestMsgForCandUser(JSON.parse(res.data));
					me.dealReceiveLastestMsgForHrUser(JSON.parse(res.data));
					
					// uni.$emit('receiveMsgInMsgVue', res.data);
					uni.$emit('receiveMsgInMsgListVue', res.data);
					

				});
				
				// 连接失败
				me.globalData.CHAT.onError(function(){
					me.globalData.chatSocketOpen = false;
					console.log('WebSocket连接打开失败，请检查！');
					
					uni.hideToast();
					
					uni.showToast({
						icon: "none",
						title: "无法连接服务，请联系管理员...",
						duration: 3000
					});
				});
			},
			
			// 处理求职者收到的消息
			dealReceiveLastestMsgForCandUser(msgJSON) {
				console.log(msgJSON);
				var chatMsg = msgJSON.chatMsg;
				var chatTime = msgJSON.chatTime;
				var hrUserId = chatMsg.senderId;
				
				var receiverType = chatMsg.receiverType;
				console.log('chatMsg.receiverType = ' + receiverType);
				if (receiverType != 2) {
					return;
				}
				
				var me = this;
				var userId = me.getUserInfoSession().id;
				
				var serverUrl = me.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: me.getUserSessionToken()
					},
					url: serverUrl + "/userinfo/get?userId=" + hrUserId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var currentSourceUserInfo = result.data.data;
							me.currentSourceUserInfo = currentSourceUserInfo;
							
							var msgShow = chatMsg.msg;
							if (chatMsg.msgType == 2) {
								msgShow = "[图片]"
							} else if (chatMsg.msgType == 4) {
								msgShow = "[视频]"
							} else if (chatMsg.msgType == 3) {
								msgShow = "[语音]"
							} else if (chatMsg.msgType == 7) {
								msgShow = "[面试邀约]"
							} else if (chatMsg.msgType == 71) {
								msgShow = "[面试取消]"
							} else if (chatMsg.msgType == 72) {
								msgShow = "[面试拒绝]"
							} else if (chatMsg.msgType == 73) {
								msgShow = "[面试接受]"
							}
							me.saveLastestMsgToLocalForCandUser(hrUserId, currentSourceUserInfo, msgShow, chatTime);
						}
					}
				})
			},
				
			// 求职者 记录每个人的最后一条消息，记录在本地，用于显示聊天列表
			saveLastestMsgToLocalForCandUser(sourceUserId, sourceUser, msgContent, chatTime) {
				
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
				
				uni.$emit('reRenderReceiveMsgInMsgVue', "domeafavor");
			},
			
			// 处理HR收到的消息
			dealReceiveLastestMsgForHrUser(msgJSON) {
				console.log(msgJSON);
				var chatMsg = msgJSON.chatMsg;
				var chatTime = msgJSON.chatTime;
				var candUserId = chatMsg.senderId;
				
				var receiverType = chatMsg.receiverType;
				if (receiverType != 1) {
					return;
				}
				
				var me = this;
				var userId = me.getUserInfoSession().id;
				
				var serverUrl = me.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: me.getUserSessionToken()
					},
					url: serverUrl + "/userinfo/get?userId=" + candUserId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var currentSourceUserInfo = result.data.data;
							me.currentSourceUserInfo = currentSourceUserInfo;
							
							var msgShow = chatMsg.msg;
							if (chatMsg.msgType == 2) {
								msgShow = "[图片]"
							} else if (chatMsg.msgType == 4) {
								msgShow = "[视频]"
							} else if (chatMsg.msgType == 3) {
								msgShow = "[语音]"
							} else if (chatMsg.msgType == 5) {
								msgShow = "[简历]"
							} else if (chatMsg.msgType == 71) {
								msgShow = "[面试取消]"
							} else if (chatMsg.msgType == 72) {
								msgShow = "[面试拒绝]"
							} else if (chatMsg.msgType == 73) {
								msgShow = "[面试接受]"
							}
							me.saveLastestMsgToLocalForHrUser(candUserId, currentSourceUserInfo, msgShow, chatTime);
						}
					}
				})
			},
				
			// HR 记录每个人的最后一条消息，记录在本地，用于显示聊天列表
			saveLastestMsgToLocalForHrUser(sourceUserId, sourceUser, msgContent, chatTime) {
				
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
				
				uni.$emit('reRenderReceiveMsgInMsgVue', "domeafavor");
			},
			
			sendSocketMessage(msg) {
				if (this.globalData.chatSocketOpen) {
					uni.sendSocketMessage({
						data: msg
					});
				} else {
					uni.showToast({
						icon: "none",
						title: "您已断开聊天服务器的连接"
					})
				}
			},
			
			// 根据生日计算年龄
			getAge(birthday){     
				if (birthday == null || birthday == undefined || birthday =='') {
					return 0;
				}
			    var returnAge;  
			    var strBirthdayArr = birthday.split("-");  
			    var birthYear = strBirthdayArr[0];  
			    var birthMonth = strBirthdayArr[1];  
			    var birthDay = strBirthdayArr[2];  
			      
			    var d = new Date();  
			    var nowYear = d.getFullYear();  
			    var nowMonth = d.getMonth() + 1;  
			    var nowDay = d.getDate();  
			      
			    if(nowYear == birthYear){  
			        returnAge = 0;//同年 则为0岁  
			    }  
			    else{  
			        var ageDiff = nowYear - birthYear ; //年之差  
			        if(ageDiff > 0){  
			            if(nowMonth == birthMonth) {  
			                var dayDiff = nowDay - birthDay;//日之差  
			                if(dayDiff < 0)  
			                {  
			                    returnAge = ageDiff - 1;  
			                }  
			                else  
			                {  
			                    returnAge = ageDiff ;  
			                }  
			            }  
			            else  
			            {  
			                var monthDiff = nowMonth - birthMonth;//月之差  
			                if(monthDiff < 0)  
			                {  
			                    returnAge = ageDiff - 1;  
			                }  
			                else  
			                {  
			                    returnAge = ageDiff ;  
			                }  
			            }  
			        }  
			        else  
			        {  
			            returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天  
			        }  
			    }  
			    return returnAge;//返回周岁年龄  
			},
			
			// 判断是否为空
			isStrEmpty (str) {
				if (str == null || str == undefined || str == "") {
					return true;
				} else {
					return false;
				}
				
			},
			// 判断用户是否登录
			userIsLogin() {
				var userToken = this.getUserSessionToken();
				var userInfo = this.getUserInfoSession();
				console.log("userInfo=" + userInfo);
				console.log("userToken=" + userToken);
				if (!this.isStrEmpty(userToken) && !this.isStrEmpty(userInfo)) {
					return true;
				} else {
					return false;
				}
			},
			
			// 用户登录以后的session存取，token和userInfo
			setUserSessionToken(token){
				uni.setStorageSync("userToken", token);
			},
			getUserSessionToken() {
				var token = uni.getStorageSync("userToken");
				if (this.isStrEmpty(token)) {
					return "";
				}
				return token;
			},
			setUserInfoSession(user){
				uni.setStorageSync("userInfo", JSON.stringify(user));
			},
			getUserInfoSession() {
				var user = uni.getStorageSync("userInfo");
				if (this.isStrEmpty(user)) {
					return null;
				}
				return JSON.parse(user);
			},
			clearUserInfo () {
				uni.removeStorageSync("userInfo");
				uni.removeStorageSync("userToken");
				uni.removeStorageSync("userType");
			},
			
			graceNumber(number) {
				if (number == 0) {
					return "0";
				} else if (number > 999 && number <= 9999) {
					return (number/1000).toFixed(1) + 'k';
				} else if (number > 9999 && number <= 99999) {
					return (number/10000).toFixed(1) + 'w';
				} else if (number > 99999) {
					return "10w+";
				} 
				return number;
			},
			
			getDateBeforeNow(stringTime) {
				// console.log(stringTime);
				stringTime = new Date(stringTime.replace(/-/g,'/'))
				
				var minute = 1000 * 60;
				var hour = minute * 60;
				var day = hour * 24;
				var week = day * 7;
				var month = day * 30;
					
				var time1 = new Date().getTime(); //当前的时间戳
				// console.log(time1);
				// console.log(new Date(stringTime));
				var time2 = Date.parse(new Date(stringTime)); //指定时间的时间戳
				// console.log(time2);
				var time = time1 - time2;
					
				var result = null;
				if(time < 0) {
					// alert("设置的时间不能早于当前时间！");
					result = stringTime;
				}else if(time/month >= 1){
					result = parseInt(time/month) + "月前";
				}else if(time/week >= 1){
					result = parseInt(time/week) + "周前";
				}else if(time/day >= 1){
					result = parseInt(time/day) + "天前";
				}else if(time/hour >= 1){
					result = parseInt(time/hour) + "小时前";
				}else if(time/minute >= 1){
					result = parseInt(time/minute) + "分钟前";
				}else {
					result = "刚刚";
				}
				// console.log(result);
				return result;
			},
			
			dateFormat(fmt, date) {
			    let ret;
			    const opt = {
			        "Y+": date.getFullYear().toString(),        // 年
			        "m+": (date.getMonth() + 1).toString(),     // 月
			        "d+": date.getDate().toString(),            // 日
			        "H+": date.getHours().toString(),           // 时
			        "M+": date.getMinutes().toString(),         // 分
			        "S+": date.getSeconds().toString()          // 秒
			        // 有其他格式化字符需求可以继续添加，必须转化成字符串
			    };
			    for (let k in opt) {
			        ret = new RegExp("(" + k + ")").exec(fmt);
			        if (ret) {
			            fmt = fmt.replace(ret[1], (ret[1].length == 1) ? (opt[k]) : (opt[k].padStart(ret[1].length, "0")))
			        };
			    };
			    return fmt;
			},
			
			// 切换为候选人
			changeToCandidate() {
				uni.setTabBarItem({
					index: 0,
					text: "职位",
					pagePath: "/pages/candidate/position",
					iconPath: "/static/icons/candidate/cand-recommend.png",
					selectedIconPath: "/static/icons/candidate/cand-recommend-selected.png",
					success() {
						uni.setTabBarItem({
							index: 1,
							text: "消息",
							pagePath: "/pages/candidate/message",
							iconPath: "/static/icons/candidate/cand-msg.png",
							selectedIconPath: "/static/icons/candidate/cand-msg-selected.png",
							success() {
								uni.setTabBarItem({
									index: 2,
									text: "发现",
									pagePath: "/pages/candidate/discover",
									iconPath: "/static/icons/candidate/cand-discover.png",
									selectedIconPath: "/static/icons/candidate/cand-discover-selected.png",
									success() {
										uni.setTabBarItem({
											index: 3,
											text: "我的",
											pagePath: "/pages/candidate/mine",
											iconPath: "/static/icons/candidate/cand-me.png",
											selectedIconPath: "/static/icons/candidate/cand-me-selected.png",
											success() {
												uni.setStorageSync('userType', 2);
												setTimeout(function () {
													uni.switchTab({
														url: "/pages/candidate/position"
													})
												}, 100);
											}
										});
									}
								});
							}
						});
					}
				});
				
			},
			
			// 切换为HR
			changeToHR() {
				// uni.setTabBarStyle({
				// 	color: "#8a8a8a",
				// 	selectedColor: "#1868ff" 
				// })
				uni.setTabBarItem({
					index: 0,
					text: "推荐",
					pagePath: "/pages/hr/recommend",
					iconPath: "/static/icons/hr/hr-recommend.png",
					selectedIconPath: "/static/icons/hr/hr-recommend-selected.png",
					success() {
						uni.setTabBarItem({
							index: 1,
							text: "消息",
							pagePath: "/pages/hr/msg",
							iconPath: "/static/icons/hr/hr-msg.png",
							selectedIconPath: "/static/icons/hr/hr-msg-selected.png",
							success() {
								uni.setTabBarItem({
									index: 2,
									text: "职位",
									pagePath: "/pages/hr/job",
									iconPath: "/static/icons/hr/hr-job.png",
									selectedIconPath: "/static/icons/hr/hr-job-selected.png",
									success() {
										uni.setTabBarItem({
											index: 3,
											text: "我的",
											pagePath: "/pages/hr/me",
											iconPath: "/static/icons/hr/hr-me.png",
											selectedIconPath: "/static/icons/hr/hr-me-selected.png",
											success() {
												uni.setStorageSync('userType', 1);
												setTimeout(function () {
													uni.switchTab({
														url: "/pages/hr/recommend"
													})
												}, 100);
											}
										});
									}
								});
							}
						});
					}
				});
				
				// setTimeout(function () {
				// 	uni.setTabBarStyle({
				// 		color: "#8a8a8a",
				// 		selectedColor: "#1868ff"
				// 	}) 
				// }, 100);

			},
			
		}
	}
</script>

<style>
/*每个页面公共css */
.line-wrapper {
	display: flex;
	flex-direction: row;
	justify-content: center;
}
.line {
	background-color: #f6f6f6;
	/* background-color: red; */
	height: 1px;
	width: 90%;
	align-self: center;
}


/* uni-radio .uni-radio-input.uni-radio-input-checked{
	background-color: #31B9B3!important;
	border-color: #31B9B3!important;
	background-clip: content-box!important;
	padding: 6rpx!important;
	box-sizing: border-box;
} */

/* uni-radio .uni-radio-input.uni-radio-input-checked::before{
	display: none!important;
} */

.uni-radio-input {
	width: 26px;
	height: 26px;
}
uni-radio:not([disabled]) .uni-radio-input:hover {
	border-color: #31B9B3 !important;
}
uni-radio .uni-radio-input.uni-radio-input-checked {
	border-color: #31B9B3 !important;
	background: #31B9B3 !important;
}
uni-radio .uni-radio-input.uni-radio-input-checked::before {
	background: #31B9B3 !important;
	border-color: #31B9B3 !important;
}

.radio-group {
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
}

.radio-item {
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
}

.radio-words {
	align-self: center;
	/* margin-left: 6px; */
	font-size: 17px;
	font-weight: 400;
}

uni-slider .uni-slider-handle-wrapper{
	height: 3px;
}

</style>
