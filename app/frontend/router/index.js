import VueRouter from 'vue-router'

import TopPageBody from '../components/TopPageBody.vue'
import PreparationBody from '../components/PreparationBody.vue'
import PracticeBody from '../components/PracticeBody.vue'

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
    ]
})
