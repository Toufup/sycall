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
                <!-- ログイン機能は一旦コメントアウト -->
                <!-- <v-col cols="auto">
                    <div id="navbar-right">
                        <v-btn depressed rounded outlined color="mainColor" class="ml-2">Login</v-btn>
                        <v-btn depressed rounded color="mainColor" class="ml-2">Sign up</v-btn>
                    </div>
                </v-col> -->
                <v-col cols="auto">
                    <div id="navbar-right">
                        <v-btn depressed rounded outlined color="mainColor" class="ml-2" @click="logout">Log out</v-btn>
                    </div>
                </v-col>
            </v-row>
        </v-container>
    </v-app-bar>
</template>

<script>
    import axios from 'axios'
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
            logout(){
                axios.delete("/logout")
                .then((res) => {
                    if (res.data.state) {
                        this.$router.push("/")
                    }
                })
            }
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
