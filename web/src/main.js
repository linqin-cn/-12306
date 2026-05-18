import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import  Antd from 'ant-design-vue'
import * as Icons from '@ant-design/icons-vue'

const app = createApp (App);
app.use(Antd).use(store).use(router).mount('#app');

// 注册全局图标组件
const icons = Icons;
for (const icon in icons) {
  app.component(icon, icons[icon]);
}
