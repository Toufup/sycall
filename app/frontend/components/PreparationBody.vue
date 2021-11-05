<template>
    <v-container fluid id="preparation-body">
        <v-sheet class="mainColor rounded-xl mx-16">
            <v-container px-16 py-8>
                <div id="musicVideo">
                    <h2 class="black--text">どのミュージックビデオで練習しますか？</h2>
                    <v-text-field placeholder="YouTube動画のリンクを貼り付ける" 
                        autofocus clearable clear-icon="mdi-close-circle"
                        background-color="white" color="primary" rounded outlined
                        prepend-inner-icon="mdi-youtube" class="mt-2"
                    ></v-text-field>
                </div>
                <Search></Search>
                <v-row id="start-button" justify="center" align="center">
                    <v-btn color="primary" class="my-4 black--text"
                        depressed x-large rounded width="170px"
                    >START</v-btn>
                </v-row>
            </v-container>
        </v-sheet>
    </v-container>
</template>

<script>
    import Search from './Search.vue'
    export default {
        name: "PreparationBody",
        components: {
            Search,
        }
    }
</script>

<style scoped>
</style>
