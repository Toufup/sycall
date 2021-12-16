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
    openSnackbar(state, payload){
        if (payload.timeout) { state.snackbar.timeout = payload.timeout }
        state.snackbar.icon = payload.icon
        state.snackbar.flag = true;
        state.snackbar.text = payload.text;
    },
    closeSnackbar(state){
        state.snackbar.flag = false;
        state.snackbar.text = null;
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
    snackbar: {
        flag: false,
        timeout: 3000,
        text: null,
        icon: "check-circle"
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
    snackbar(state){
        return state.snackbar
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
