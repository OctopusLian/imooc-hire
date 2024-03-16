
//	此资源由 58学课资源站 收集整理
//	想要获取完整课件资料 请访问：58xueke.com
//	百万资源 畅享学习
// 发送信息的铃声
function playSendSound() {
	// // #ifdef APP-PLUS
	// var volumeValue = plus.device.getVolume() // 获取当前音量
	// if (volumeValue <= 0) {
	// 	return;
	// }
	// // #endif
	
	
	const innerAudioContext = uni.createInnerAudioContext();
	innerAudioContext.autoplay = true;
	innerAudioContext.src = '../../static/files/sound/send-sound.mp3';
	innerAudioContext.onPlay(() => {
	});
	innerAudioContext.onStop((res) => {
		innerAudioContext.destroy() 	// 播放完毕销毁实例
	});
	innerAudioContext.onError((res) => {
	});
}

// 接受信息的铃声
function playReceiveSound() {
	// // #ifdef APP-PLUS
	// var volumeValue = plus.device.getVolume() // 获取当前音量
	// if (volumeValue <= 0) {
	// 	uni.vibrateLong();
	// 	return;
	// }
	// // #endif
	
	console.log(1111)
	
	const innerAudioContext = uni.createInnerAudioContext();
	innerAudioContext.autoplay = true;
	innerAudioContext.src = '../../static/files/sound/receive-sound.mp3';
	innerAudioContext.onPlay(() => {
	});
	innerAudioContext.onStop((res) => {
		innerAudioContext.destroy() 	// 播放完毕销毁实例
	});
	innerAudioContext.onError((res) => {
	});
}

module.exports = {
	playSendSound, playReceiveSound
}
