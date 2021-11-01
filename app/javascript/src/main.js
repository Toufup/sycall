import Vue from 'vue'
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import App from '../App.vue'
Vue.config.productionTip = false;

Vue.use(Vuetify);
const vuetify = new Vuetify();

document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        vuetify,
        el: "#app",
        render: h => h(App),
    })
})
