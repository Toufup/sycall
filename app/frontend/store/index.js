import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex)

const actions = {
    getVideoCurrentTime({commit}, player){
        player.getCurrentTime().then((time)=>{
            commit("updateVideoCurrentTime", time)
        })
    },
    sendSelectedCallInfo({commit}, result){
        commit("updateSelectedCallInfo", result)
    }
}

const mutations = {
    updateVideoCurrentTime(state, time){
        state.time = time;
    },
    updateSelectedCallInfo(state, result){
        state.selectedCallInfo = result;
    }
}

const state = {
    time: 0,
    selectedCallInfo: null,
}

const getters = {
    videoCurrentTime(state){
        return state.time;
    },
    selectedCallInfo(state){
        return state.selectedCallInfo
    }
}

export default new Vuex.Store({
    actions,
    mutations,
    state,
    getters,
})
