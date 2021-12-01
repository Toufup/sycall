import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex)

const actions = {
    getVideoCurrentTime({commit}, player){
        player.getCurrentTime().then((time)=>{
            commit("updateVideoCurrentTime", time)
        })
    },
    sendSelectedCallInfo({commit}, result){
        commit("updateSelectedCallInfo", result)
    },
    sendVideoUrl({commit}, url){
        commit("updateVideoUrl", url)
    }
}

const mutations = {
    updateVideoCurrentTime(state, time){
        state.time = time;
    },
    updateSelectedCallInfo(state, result){
        state.selectedCallInfo = result;
    },
    updateVideoUrl(state, url){
        const urlReg = /^(https\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)+([\S]{11}$)/
        state.videoId = url.match(urlReg).pop()
    },
    showSuccessAlert(state, props){
        state.successAlert.action = props.action;
        state.successAlert.flag = props.flag;
        state.successAlert.type = props.type;
    },
    closeSuccessAlert(state){
        state.successAlert.action = null;
        state.successAlert.flag = false;
        state.successAlert.type = null;
    },
    setIsLogin(state,bool){
        state.isLogin = bool
    }
}

const state = {
    time: 0,
    selectedCallInfo: null,
    videoId: null,
    successAlert: {
        action: null,
        flag: false,
        type: null,
    },
    isLogin: false,
}

const getters = {
    videoCurrentTime(state){
        return state.time;
    },
    selectedCallInfo(state){
        return state.selectedCallInfo
    },
    videoId(state){
        return state.videoId
    },
    successAlert(state){
        return state.successAlert
    },
    isLogin(state){
        return state.isLogin
    }
}

export default new Vuex.Store({
    actions,
    mutations,
    state,
    getters,
    plugins: [
        createPersistedState({
            key: "sycallApp",
            paths: ["selectedCallInfo", "videoId", "isLogin"],
            storage: window.sessionStorage
        })
    ]
})
