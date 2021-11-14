import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex)

const actions = {
    getVideoCurrentTime({commit}, player){
        player.getCurrentTime().then((time)=>{
            commit("updateVideoCurrentTime", time)
        })
    },
}

const mutations = {
    updateVideoCurrentTime(state, time){
        state.time = time;
    },
}

const state = {
    time: 0,
}

const getters = {
    videoCurrentTime(state){
        return state.time;
    }
}

export default new Vuex.Store({
    actions,
    mutations,
    state,
    getters,
})
