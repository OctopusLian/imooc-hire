<style>
.page {
	position: absolute;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background-color: #ffffff;
}

.place-box {
	background-color: #4a4c52;
}
.place-box-touched {
	background-color: #6d6b6b;
}

.right-arrow {
	width: 32rpx;
	height: 32rpx;
	margin-left: 20rpx;
}

.active {
	background-color: #31B9B3;
	color: #ffffff;
}
</style>
<template>
	<view class="page">
			
		<view 
			v-for="(item, index) in cityList"
			:class="{active : index == activeIndex}"
			:key="index"
			@click="chooseLocation(item.city_id, showDistrict ? item.district_name : item.city_name)" 
			@touchstart="touchstartLocation(index)"
			@touchend="touchendLocation()"
			style="padding-left: 30rpx;padding-right: 30rpx;width: 750rpx;height: 120rpx;display: flex;flex-direction: row;justify-content: space-between;">
			
			<text style="align-self: center;font-size: 16px;">{{showDistrict ? item.district_name : item.city_name}}</text>
		</view>
		
	</view>
</template>

<script>
	export default {
		components: {
		},
		data() {
			return {
				placeTouched: false,
				cityList: [],
				activeIndex: -1,
				showDistrict: false
			}
		},
		onLoad(params) {
			var provinceId = params.provinceId;
			
			var cityList = getApp().globalData.cityList;
			var districtList = getApp().globalData.districtList;
			
			this.showDistrict = false;
			var realCityList = [];
			for (var i = 0; i < cityList.length; i ++) {
				var tempProvinceId = cityList[i].province_id;
				if (tempProvinceId == provinceId) {
					realCityList.push(cityList[i]);
				}
			}
			
			// 如果是北京1、天津2、上海9、重庆22，他们需要从区中获得，作为给用户展示并且可以更具体的选择
			// if(provinceId == 1 || provinceId == 2 || provinceId == 9 || provinceId == 22) {
			// 		var thatCityId = realCityList[0].city_id;
			// 		realCityList = [];
			// 		for (var i = 0; i < districtList.length; i ++) {
			// 			var city_id = districtList[i].city_id;
			// 			if (city_id == thatCityId) {
			// 				realCityList.push(districtList[i]);
			// 			}
			// 		}
			// 		this.showDistrict = true;
			// }
			
			this.cityList = realCityList;
		},
		methods: {
			updateBirthday() {
			},
			touchstartLocation(index) {
				this.activeIndex = index;
			},
			touchendLocation() {
				this.activeIndex = -1;
			},
			chooseLocation(cityId, areaName) {
				uni.setStorageSync("chosenLocationArea", areaName);
				uni.setStorageSync("needRefresh", "yes");
				uni.navigateBack({
					delta: 2
				})
			}
		}
	}
</script>

