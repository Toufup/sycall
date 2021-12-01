<template>
    <v-app-bar flat absolute app height="80" color="transparent">
        <v-container mx-md-16 mx-sm-12 fluid>
            <v-row align="center">
                <v-col cols="auto">
                    <a>
                        <div id="logo-box" @mouseover="mouseOverAction" @mouseout="mouseOutAction" @click="toHome($event)" ref="logoBox">
                            <img :src="outlineLogo" 
                                height="50" width="50" 
                                ref="logo"/>
                            <h2 class="white--text">Sycall</h2>
                        </div>
                    </a>
                </v-col>
                <v-spacer></v-spacer>
                <v-col cols="auto">
                    <SessionFunctions></SessionFunctions>
                </v-col>
            </v-row>
        </v-container>
    </v-app-bar>
</template>

<script>
    import SessionFunctions from './SessionFunctions.vue'
    import {hearts} from '../src/effects/hearts'
    import {animateCss} from '../src/effects/animateCss'
    export default {
        name: "NavBar",
        data() {
            return {
                outlineLogo: require('../images/sycall.png'),
                filledLogo: require('../images/sycall_filled.png'),
            }
        },
        components: {
            SessionFunctions
        },
        methods: {
            mouseOverAction(){
                this.$refs.logo.src = this.filledLogo
            },
            mouseOutAction(){
                this.$refs.logo.src = this.outlineLogo
            },
            toHome(event){
                animateCss(this.$refs.logoBox,"jello")
                hearts(event.target)
                if (this.$route.path === "/") {
                    return
                }
                setTimeout(() => {
                    this.$router.push({
                        path: "/",
                    })
                }, 90);
            },
        },
    }
</script>

<style scoped>
    #logo-box {
        display: flex;
        flex-direction: row;
        align-items: center;
    }
    h1{
        font-size: xxx-large;
    }
    #navbar-right{
        display: flex;
        flex-direction: row;
        justify-content: flex-end;
    }
</style>
