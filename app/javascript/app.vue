<template>
    <v-app id="top-wrapper">
        <NavBar></NavBar>
        <v-main>
            <TopPageBody></TopPageBody>
        </v-main>
        <Footer></Footer>
    </v-app>
</template>

<script>
    import NavBar from './components/NavBar.vue';
    import TopPageBody from './components/TopPageBody.vue'
    import Footer from './components/Footer.vue'
    export default {
        name: "App",
        components: {
            NavBar,
            TopPageBody,
            Footer
        },
    }
</script>

<style>
    .v-application{
        font-family: 'Russo One', 'M PLUS 1p', sans-serif;
    }
    a{
        text-decoration: none;
    }
    #top-wrapper {
        background: linear-gradient(241deg, #825d94, #2b5876);
        background-size: 400% 400%;
        animation: AnimationName 4s ease infinite;
    }
    @keyframes AnimationName {
        0%{background-position:81% 0%}
        50%{background-position:20% 100%}
        100%{background-position:81% 0%}
    }
</style>
