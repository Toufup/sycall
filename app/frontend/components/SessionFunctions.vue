<template>
    <div id="session-functions">
        <!-- <v-btn depressed rounded outlined color="mainColor" class="ml-2">Login</v-btn> -->
        <!-- <v-btn depressed rounded color="mainColor" class="ml-2">Sign up</v-btn> -->
        <v-btn v-show="isLogin" depressed rounded outlined color="mainColor" class="ml-2" @click="logout">Logout</v-btn>
    </div>
</template>

<script>
    import {mapGetters, mapMutations} from 'vuex'
    import axios from 'axios'
    export default {
        name: "SessionFunctions",
        computed: {
            ...mapGetters(["isLogin"])
        },
        methods: {
            ...mapMutations(["setIsLogin"]),
            logout(){
                axios.delete("/logout")
                .then((res) => {
                    if (res.data.state) {
                        this.setIsLogin(false)
                        this.$router.push("/")
                    }
                })
            }
        },
    }
</script>
