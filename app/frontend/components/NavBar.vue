<template>
    <v-app-bar flat app height="100" color="transparent" >
        <v-container mx-md-16 mx-sm-10 fluid>
            <v-row align="center">
                <v-col cols="auto">
                    <router-link to="/">
                        <div id="logo-box" @mouseover="mouseOverAction" @mouseout="mouseOutAction" @click="sparkles($event)">
                            <img :src="outlineLogo" 
                                height="70" width="70" 
                                ref="logo"/>
                            <h1 class="white--text">Sycall</h1>
                        </div>
                    </router-link>
                </v-col>
                <v-spacer></v-spacer>
                <v-col cols="auto">
                    <div id="navbar-right">
                        <v-btn depressed large rounded outlined color="mainColor" class="ml-2">Login</v-btn>
                        <v-btn depressed large rounded color="mainColor" class="ml-2">Sign up</v-btn>
                    </div>
                </v-col>
            </v-row>
        </v-container>
    </v-app-bar>
</template>

<script>
    import {hearts} from '../src/effects/hearts'
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
            sparkles(event){
                hearts(event.target)
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
