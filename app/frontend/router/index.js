import VueRouter from 'vue-router'
import store from '../store'

import TopPageBody from '../components/TopPageBody.vue'
import PreparationBody from '../components/PreparationBody.vue'
import PracticeBody from '../components/PracticeBody.vue'
import LoginBody from '../components/LoginBody.vue'
import Dashboard from '../components/admin/Dashboard.vue'
import Artists from '../components/admin/Artists.vue'
import Songs from '../components/admin/Songs.vue'
import CallLyricsVersions from '../components/admin/CallLyricsVersions.vue'
import CallLyrics from '../components/admin/CallLyrics.vue'
import Populars from '../components/admin/Populars.vue'
import Terms from '../components/Terms.vue'

export default new VueRouter({
    mode: "history",
    routes: [
        {
            path: "/",
            component: TopPageBody,
        },
        {
            path: "/preparation",
            component: PreparationBody,
        },
        {
            path: "/practice",
            component: PracticeBody,
        },
        {
            path: "/login",
            component: LoginBody,
            beforeEnter: ((to,from,next) => {
                if(store.getters.isLogin && new Date(store.getters.loginExpireDate) > new Date()){
                    next("/")
                }else{
                    store.commit("setIsLogin", false)
                    next()
                }
            })
        },
        {
            path: "/admin",
            redirect: {name: "artists"},
            component: Dashboard,
            beforeEnter: ((to,from,next) => {
                if(store.getters.isLogin && new Date(store.getters.loginExpireDate) > new Date()){
                    next()
                }else{
                    store.commit("setIsLogin", false)
                    next("/login")
                }
            }),
            children: [
                {
                    path: "artists",
                    name: "artists",
                    component: Artists,
                },
                {
                    path: "songs",
                    name: "songs",
                    component: Songs,
                },
                {
                    path: "call-lyrics-versions",
                    name: "callLyricsVersions",
                    component: CallLyricsVersions,
                },
                {
                    path: "call-lyrics",
                    name: "callLyrics",
                    component: CallLyrics,
                },
                {
                    path: "populars",
                    name: "populars",
                    component: Populars,
                },
            ]
        },
        {
            path: "/terms",
            component: Terms,
        }
    ]
})
