import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import axios from 'axios'

const axiosInstance = axios.create({
  baseURL: 'http://localhost:3001',
})

Vue.config.productionTip = false

Vue.prototype.$axios = axiosInstance

new Vue({
  vuetify,
  render: h => h(App)
}).$mount('#app')
