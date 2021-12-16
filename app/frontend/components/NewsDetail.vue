<template>
    <v-container fluid id="preparation-body">
        <v-card color="mainColor" class="rounded-xl mx-16">
            <v-container class="pa-8 black--text">
                <v-row justify="space-between">
                    <v-col cols="auto">
                        <v-btn depressed fab color="white" @click="pageBack">
                            <v-icon x-large color="maccha">mdi-arrow-left</v-icon>
                        </v-btn>
                    </v-col>
                    <v-col cols="auto">
                        <h1>{{news.title}}</h1>
                        <p>{{news.createdAt}}</p>
                    </v-col>
                </v-row>
                <v-col cols="12">
                    <v-card outlined class="rounded-xl" color="white">
                        <v-card-text class="black--text">
                            <p>{{news.body}}</p>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-container>
        </v-card>
    </v-container>
</template>

<script>
    import axios from 'axios'
    export default {
        name: "NewsDetail",
        data() {
            return {
                news: {}
            }
        },
        methods: {
            pageBack(){
                this.$router.push("/news");
            }
        },
        mounted() {
            axios.get("/api/news/"+this.$route.params.id)
            .then(res => {
                this.news = res.data
                document.title = `${this.news.title} | Sycall`
            })
        },
    }
</script>

<style scoped>
    p{
        margin: 0;
    }
</style>
