import Vue from 'vue'
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import colors from 'vuetify/lib/util/colors'
import App from '../App.vue'
Vue.config.productionTip = false;

Vue.use(Vuetify);
const vuetify = new Vuetify({
    theme: {
        themes: {
            light: {
                mainColor: "#58ffaa",
                primary: "#ffaee4",
                white: "#f5f5f7",
                black: "#323232",
                navy: "#2d5776",
            },
        },
    },
});

document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        vuetify,
        el: "#app",
        render: h => h(App),
    })
})
