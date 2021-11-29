import VueRouter from 'vue-router'

import TopPageBody from '../components/TopPageBody.vue'
import PreparationBody from '../components/PreparationBody.vue'
import PracticeBody from '../components/PracticeBody.vue'
import Dashboard from '../components/admin/Dashboard.vue'
import Artists from '../components/admin/Artists.vue'
import Songs from '../components/admin/Songs.vue'
import CallLyricsVersions from '../components/admin/CallLyricsVersions.vue'
import CallLyrics from '../components/admin/CallLyrics.vue'

export default new VueRouter({
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
            path: "/admin",
            redirect: {name: "artists"},
            component: Dashboard,
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
            ]
        }
    ]
})
