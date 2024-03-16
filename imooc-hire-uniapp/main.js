
import App from './App'
import DateUtil from "@/components/DateUtil.js";

Vue.prototype.DateUtil = DateUtil;
Vue.prototype.userType = {
	hr: 1,
	candidate: 2
}

// #ifndef VUE3
import Vue from 'vue'
Vue.config.productionTip = false
App.mpType = 'app'
const app = new Vue({
    ...App
})
app.$mount()
// #endif

// #ifdef VUE3
import { createSSRApp } from 'vue'
export function createApp() {
  const app = createSSRApp(App)
  return {
    app
  }
}
// #endif