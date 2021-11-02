<template>
    <v-app :style="{'backgroundColor': '#323232',}">
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
</style>
