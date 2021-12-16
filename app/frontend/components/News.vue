<template>
    <v-container fluid id="preparation-body">
        <v-card color="mainColor" class="rounded-xl mx-16">
            <v-container class="pa-8 black--text">
                <v-col cols="12">
                    <h1>お知らせ</h1>
                </v-col>
                <v-col cols="12">
                    <v-card outlined class="rounded-xl" color="white">
                        <v-card-text class="black--text">
                            <template v-for="news in newsList">
                                <div id="newsDigest" :key="news.id" class="d-flex ma-4">
                                    <span>{{news.createdAt}}</span>
                                    <v-divider vertical class="mx-4"></v-divider>
                                    <p>{{news.title}}</p>
                                </div>
                            </template>
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
        name: "News",
        data() {
            return {
                newsList: []
            }
        },
        mounted() {
            axios.get("/api/news/index")
            .then(res => {
                this.newsList = res.data
            })
            document.title = "お知らせ | Sycall"
        },
    }
</script>

<style scoped>
    p{
        margin: 0;
    }
    #newsDigest{
        font-size: 20px;
    }
</style>
