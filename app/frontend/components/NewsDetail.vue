<template>
    <v-container fluid id="preparation-body">
        <v-card color="mainColor" class="rounded-xl mx-16">
            <v-container class="pa-8 black--text">
                <v-row justify="center">
                    <v-col cols="auto">
                        <v-btn depressed fab color="white" @click="pageBack">
                            <v-icon x-large color="maccha">mdi-arrow-left</v-icon>
                        </v-btn>
                    </v-col>
                    <v-col cols="10" class="text-center">
                        <h1>{{news.title}}</h1>
                        <p>{{news.createdAt}}</p>
                    </v-col>
                    <v-col cols="auto">
                        <v-btn depressed fab color="transparent">
                            <v-icon x-large color="transparent"></v-icon>
                        </v-btn>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <v-card outlined class="rounded-xl" color="white">
                            <v-card-text class="black--text" id="news-body">
                                <p>{{news.body}}</p>
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
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
        font-size: 17px;
    }
    #news-body{
        white-space: pre-line;
    }
</style>
