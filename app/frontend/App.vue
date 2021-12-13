<template>
    <v-app id="top-wrapper">
        <NavBar></NavBar>
        <v-main >
            <transition appear enter-active-class="animate__animated animate__fadeIn">
                <keep-alive include="PreparationBody">
                    <router-view></router-view>
                </keep-alive>
            </transition>
        </v-main>
        <Footer ></Footer>
    </v-app>
</template>

<script>
    import "animate.css"
    import 'vue-swatches/dist/vue-swatches.css'
    import NavBar from './components/NavBar.vue';
    import Footer from './components/Footer.vue'
    export default {
        name: "App",
        components: {
            NavBar,
            Footer
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
