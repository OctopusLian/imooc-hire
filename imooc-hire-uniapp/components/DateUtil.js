
//	此资源由 58学课资源站 收集整理
//	想要获取完整课件资料 请访问：58xueke.com
//	百万资源 畅享学习
const DateUtil = {};

DateUtil.formatCompareDatetime = function(nowTimeStr, msgLocalDateTime) {
	// console.log("nowTimeStr = " + nowTimeStr);
	// console.log("msgLocalDateTime = " + msgLocalDateTime);
	// 比较1分钟之内就不显示了，表示聊天互动激烈，参考微信也是如此
	var lastTimestamp = Date.parse(msgLocalDateTime)/1000;	// 上一条消息时间
	var nowTimeTimestamp = Date.parse(nowTimeStr)/1000;		// 当前时间
	
	// console.log("lastTimestamp = " + lastTimestamp);
	// console.log("nowTimeTimestamp = " + nowTimeTimestamp);
	
	var timestampDiff = nowTimeTimestamp - lastTimestamp; // 上一条时间戳与当前时间戳相差秒数
	// console.log("timestampDiff = " + timestampDiff);
	if ( timestampDiff < 60 ) {
		return null;
	} else {
		return this.formatWeekDatetime(nowTimeStr);
	}
}

// 7天以内，格式化为 今天，昨天，星期一，星期二，星期三，星期四，星期五
// 超过7天，显示格式化后的 yyyy-dd-mm hh-MM-ss
DateUtil.formatWeekDatetime = function(strDateTime) {
	function zeroize(num) {
		return (String(num).length == 1 ? '0' : '') + num;
	}
		
	// var pendingDateTime = new Date(strDateTime);
	var timestamp = Date.parse(strDateTime)/1000;
	// console.log("timestamp = " + timestamp);
	
	var curTimestamp = parseInt(new Date().getTime() / 1000); //当前时间戳
	var timestampDiff = curTimestamp - timestamp; // 参数时间戳与当前时间戳相差秒数
	
	var curDate = new Date( curTimestamp * 1000 ); // 当前时间日期对象
	var tmDate = new Date( timestamp * 1000 );  // 参数时间戳转换成的日期对象
	
	var Y = tmDate.getFullYear(), m = tmDate.getMonth() + 1, d = tmDate.getDate();
	var H = tmDate.getHours(), i = tmDate.getMinutes(), s = tmDate.getSeconds();
		
	
	// console.log("pendingDateTime = " + pendingDateTime);
	// var pendingDateTimeStr = this.formatDateToStr(pendingDateTime);
	// console.log("pendingDateTimeStr = " + pendingDateTimeStr);
	if ( timestampDiff < 60 ) { // 一分钟以内
		
		return '今天 ' + zeroize(H) + ':' + zeroize(i);
		// return "刚刚";
	} else if( timestampDiff < 3600 ) { // 一小时前之内
		return '今天 ' + zeroize(H) + ':' + zeroize(i);
		// return Math.floor( timestampDiff / 60 ) + " 分钟前";
	} else if ( curDate.getFullYear() == Y && curDate.getMonth()+1 == m && curDate.getDate() == d ) {
		return '今天 ' + zeroize(H) + ':' + zeroize(i);
	} else {
        var newDate = new Date( (curTimestamp - 86400) * 1000 ); // 参数中的时间戳加一天转换成的日期对象
        if ( newDate.getFullYear() == Y && newDate.getMonth()+1 == m && newDate.getDate() == d ) {
            return '昨天 ' + zeroize(H) + ':' + zeroize(i);
        } else if ( curDate.getFullYear() == Y ) {
            return  zeroize(m) + '月' + zeroize(d) + '日 ' + zeroize(H) + ':' + zeroize(i);
        } else {
            return  Y + '年' + zeroize(m) + '月' + zeroize(d) + '日 ' + zeroize(H) + ':' + zeroize(i);
        }
    }
}

// 把字符串日期时间拆分获得年份和时间
DateUtil.getDateStr = function(strDateTime) {
    var arr = strDateTime.split(" ");
	console.log("arr[0] = " + arr[0]);
    return arr[0];
}
DateUtil.getTimeStr = function(strDateTime) {
    var arr = strDateTime.split(" ");
	console.log("arr[0] = " + arr[1]);
    return arr[1];
}

//将num左补0为len长度的字符串
DateUtil.addZero = function(num, len) {
    var l = num.toString().length;
    while(l < len) {
        num = "0" + num;
        l++;
    }
    return num;
}

//将传入的Date格式化为"yyyy/MM/dd HH:mm:ss"
DateUtil.formatDateToStr = function(d){
    var year = d.getFullYear();
    var month = d.getMonth() + 1;
    var day = d.getDate();
    var hours = d.getHours();
    var minutes = d.getMinutes();
    var seconds = d.getSeconds();
    // var milliSeconds = d.getMilliseconds();
    var resStr = year + "/" + this.addZero(month, 2) + "/" + this.addZero(day, 2) + " " + this.addZero(hours,2) + ":" + this.addZero(minutes,2) + ":" + this.addZero(seconds,2);
    return resStr;
}

DateUtil.MINUTE = 1000 * 60;
DateUtil.HOUR = DateUtil.MINUTE * 60;
DateUtil.DAY = DateUtil.HOUR * 24;
DateUtil.WEEK = DateUtil.DAY * 7;
DateUtil.MONTH = DateUtil.WEEK * 4;
DateUtil.YEAR = DateUtil.MONTH * 12;
//时间转换到本地的天
DateUtil.toLocaleDateString = function(datestr) {
  let date = new Date(datestr);
  let m = date.getMonth() + 1;
  if (m < 10) {
    m = "0" + m;
  }
  let day = date.getDate();
  if (day < 10) {
    day = "0" + day;
  }
  return date.getFullYear() + "-" + m + "-" + day;
};
 
DateUtil.toLocaleMinutString = function(datestr) {
  let date = new Date(datestr);
 
  let m = date.getMonth() + 1;
  if (m < 10) {
    m = "0" + m;
  }
  let day = date.getDate();
  if (day < 10) {
    day = "0" + day;
  }
 
  let h = date.getHours();
  if (h < 10) {
    h = "0" + h;
  }
  let MM = date.getMinutes();
  if (MM < 10) {
    MM = "0" + MM;
  }
  let SS = date.getSeconds();
  if (SS < 10) {
    SS = "0" + SS;
  }
  return `${date.getFullYear()}-${m}-${day} ${h}:${MM}:${SS}`;
};
 
//时间转换成显示时间 如比较进的显示多少分钟前 这种
DateUtil.toShowTime = function(datestr) {
  // datestr = datestr.replace(new RegExp(/-/gm) ,"/");
  let curdate = new Date();
  let date = new Date(datestr);
  let dt = curdate.getTime() - date.getTime();
  if (dt < DateUtil.HOUR) {
    let MINUTE = dt / DateUtil.MINUTE;
    MINUTE = Math.max(MINUTE, 1);
    MINUTE = Math.floor(MINUTE);
    return MINUTE + "分钟前";
  }
  if (dt < DateUtil.DAY) {
    let HOUR = dt / DateUtil.HOUR;
    HOUR = Math.max(HOUR, 1);
    HOUR = Math.floor(HOUR);
    return HOUR + "小时前";
  }
  if (dt < DateUtil.WEEK) {
    let DAY = dt / DateUtil.DAY;
    DAY = Math.max(DAY, 1);
    DAY = Math.floor(DAY);
    return DAY + "天前";
  }
  return DateUtil.toLocaleMinutString(datestr);
};
 
DateUtil.toShowTimeFormat = function(datestr) {
  datestr = datestr.replace(new RegExp(/-/gm) ,"/");
  let curdate = new Date();
  let date = new Date(datestr);
  let dt = curdate.getTime() - date.getTime();
  if (dt < DateUtil.HOUR) {
    let MINUTE = dt / DateUtil.MINUTE;
    MINUTE = Math.max(MINUTE, 1);
    MINUTE = Math.floor(MINUTE);
    return MINUTE + "分钟前";
  }
  if (dt < DateUtil.DAY) {
    let HOUR = dt / DateUtil.HOUR;
    HOUR = Math.max(HOUR, 1);
    HOUR = Math.floor(HOUR);
    return HOUR + "小时前";
  }
  if (dt < DateUtil.WEEK) {
    let DAY = dt / DateUtil.DAY;
    DAY = Math.max(DAY, 1);
    DAY = Math.floor(DAY);
    return DAY + "天前";
  }
  if (dt < DateUtil.MONTH) {
    let WEEK = dt / DateUtil.WEEK;
    WEEK = Math.max(WEEK, 1);
    WEEK = Math.floor(WEEK);
    return WEEK + "周前";
  }
  if (dt < DateUtil.YEAR) {
    let MONTH = dt / DateUtil.MONTH;
    MONTH = Math.max(MONTH, 1);
    MONTH = Math.floor(MONTH);
    return MONTH + "月前";
  }
  return DateUtil.toLocaleMinutString(datestr);
};
 
export default DateUtil;