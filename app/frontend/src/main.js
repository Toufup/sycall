import Vue from 'vue';
import axios from 'axios'
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import App from '../App.vue';
import VueRouter from 'vue-router';
import router from '../router/index.js';
import VueYoutube from 'vue-youtube'
import store from '../store'

let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
axios.defaults.headers.common['X-CSRF-Token'] = token

Vue.config.productionTip = false;

Vue.use(Vuetify);
Vue.use(VueRouter);
Vue.use(VueYoutube)

const vuetify = new Vuetify({
    theme: {
        themes: {
            light: {
                mainColor: "#58ffaa",
                primary: "#fffa6e",
                maccha: "#049d3b",
                white: "#f5f5f7",
                black: "#323232",
                gray: "#595959",
                pink: "#ff94ce",
            },
        },
    },
});

document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        vuetify,
        router,
        store,
        el: "#app",
        render: h => h(App),
    })
})
