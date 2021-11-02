<template>
    <div>
        <v-app-bar flat app height="100" color="transparent">
            <v-container mx-16>
                <v-row align="center">
                    <a href="#">
                        <div class="logo-box" @mouseover="mouseOverAction" @mouseout="mouseOutAction">
                            <img :src="outlineLogo" 
                                height="70" width="70" 
                                ref="logo"/>
                            <h1 class="white--text">Sycall</h1>
                        </div>
                    </a>
                    <v-spacer></v-spacer>
                    <v-btn depressed large rounded outlined color="mainColor" class="mx-4">Login</v-btn>
                    <v-btn depressed large rounded color="mainColor" class="mx-4">Sign up</v-btn>
                </v-row>
            </v-container>
        </v-app-bar>
    </div>
    
</template>

<script>
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
        },
    }
</script>

<style scoped>
    .logo-box {
        display: flex;
        flex-direction: row;
        align-items: center;
    }
    h1{
        font-size: xxx-large;
    }
</style>
