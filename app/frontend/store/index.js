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
        const urlReg = /^(https\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)+([\S]{11})([\S]*$)/
        state.videoId = url.match(urlReg)[4]
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
        // 1日後にログインセッションが切れる
        if (bool) {
            state.loginDate = new Date(Date.now())
            state.loginExpireDate = new Date(Date.now())
            state.loginExpireDate.setDate(state.loginDate.getDate() + 1)
        } else {
            state.loginDate = null
            state.loginExpireDate = null
        }
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
    loginDate: null,
    loginExpireDate: null,
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
    },
    loginDate(state){
        return state.loginDate
    },
    loginExpireDate(state){
        return state.loginExpireDate
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
            paths: ["selectedCallInfo", "videoId", "isLogin", "loginExpireDate"],
            storage: window.sessionStorage
        })
    ]
})
