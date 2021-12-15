import VueRouter from 'vue-router'
import store from '../store'

// メイン
import TopPageBody from '../components/TopPageBody.vue'
import PreparationBody from '../components/PreparationBody.vue'
import PracticeBody from '../components/PracticeBody.vue'
import LoginBody from '../components/LoginBody.vue'
import Terms from '../components/Terms.vue'
import Privacy from '../components/Privacy.vue'

// 管理画面
import Dashboard from '../components/admin/Dashboard.vue'
import Artists from '../components/admin/Artists.vue'
import Songs from '../components/admin/Songs.vue'
import CallLyricsVersions from '../components/admin/CallLyricsVersions.vue'
import CallLyrics from '../components/admin/CallLyrics.vue'
import Populars from '../components/admin/Populars.vue'
import News from '../components/admin/News.vue'

// エラーハンドリング
import NotFound404 from '../components/errors/NotFound404.vue'

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
                {
                    path: "news",
                    name: "news",
                    component: News,
                },
            ]
        },
        {
            path: "/terms",
            component: Terms,
        },
        {
            path: "/privacy",
            component: Privacy,
        },
        {
            // ページが見つからないパスのエラーハンドリング。一番下に配置すべき
            path: '*', 
            component: NotFound404
        },
    ]
})
