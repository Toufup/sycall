<template>
    <v-app id="top-wrapper">
        <NavBar></NavBar>
        <v-snackbar top rounded="xl" color="primary" content-class="black--text"
            :value="snackbar.flag" @input="closeSnackbar" :timeout="snackbar.timeout"
        >
            <v-icon left color="black">mdi-{{snackbar.icon}}</v-icon>{{snackbar.text}}
        </v-snackbar>
        <v-main >
            <transition appear enter-active-class="animate__animated animate__fadeIn">
                <router-view></router-view>
            </transition>
        </v-main>
        <Footer ></Footer>
    </v-app>
</template>

<script>
    import "animate.css"
    import 'vue-swatches/dist/vue-swatches.css'
    import NavBar from './components/NavBar.vue'
    import Footer from './components/Footer.vue'
    import {mapGetters, mapMutations} from 'vuex'
    export default {
        name: "App",
        components: {
            NavBar,
            Footer
        },
        computed: {
            ...mapGetters(["snackbar"]),
        },
        methods: {
            ...mapMutations(["closeSnackbar"]),
        },
    }
</script>

<style>
    .v-application{
        font-family: 'Russo One', 'M PLUS Rounded 1c', sans-serif;
    }
    .v-dialog {
        border-radius: 24px !important;
    }
    .v-pagination__item, .v-pagination__navigation{
        box-shadow: none;
        border: 1px solid gray;
    }
    a{
        text-decoration: none;
    }
    #top-wrapper {
        background: linear-gradient(241deg,  #825d94, #2b5876, #173041);
        background-size: 400% 400%;
        animation: bgGradation 4s ease infinite;
    }
    @keyframes bgGradation {
        0%{background-position:81% 0%}
        50%{background-position:20% 100%}
        100%{background-position:81% 0%}
    }
</style>
