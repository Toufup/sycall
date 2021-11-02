<template>
    <v-app :style="{'backgroundColor': '#323232',}">
        <NavBar></NavBar>
    </v-app>
</template>

<script>
    import NavBar from './components/NavBar.vue'
    export default {
        name: "App",
        components: {
            NavBar,
        },
    }
</script>

<style>
    .v-application{
        font-family: 'Russo One', sans-serif, 'Roboto', sans-serif;
    }
    a{
        text-decoration: none;
    }
</style>
