<template>
    <v-container id="news-body">
        <v-banner outlined color="transparent" class="rounded-xl pa-0" height="40" width="auto" single-line>
            <div class="d-flex justify-center" id="banner-text">
                <transition mode="out-in" enter-active-class="animate__animated animate__slideInDown"
                    leave-active-class="animate__animated animate__fadeOutDown"
                >
                    <template v-for="news in newsList">
                        <div :key="news.id" v-if="currentNews.id === news.id"
                            class="d-flex align-center"
                        >
                            <v-icon left color="mainColor">mdi-information</v-icon>
                            <a class="d-flex align-baseline">
                                <p class="white--text">
                                    {{currentNews.title}} 
                                </p>
                                <v-icon small color="white">mdi-open-in-new</v-icon>
                            </a>
                        </div>
                    </template>
                </transition>
            </div>
        </v-banner>
    </v-container>
</template>

<script>
    import "animate.css"
    import axios from 'axios'
    export default {
        name: "Banner",
        data() {
            return {
                newsList: [],
                newsIndex: 0,
            }
        },
        computed: {
            currentNews(){
                return this.newsList[this.newsIndex]
            }
        },
        mounted() {
            axios.get("/api/news/index")
            .then(res => {
                this.newsList = res.data
            })
            this.newsTimer = setInterval(() => {
                ++this.newsIndex;
                if (this.newsIndex > this.newsList.length - 1) {
                    this.newsIndex = 0;
                }
            }, 5000);
        },
        beforeDestroy() {
            clearInterval(this.newsTimer);
        },
    }
</script>

<style scoped>
    a:hover {
        color: #f5f5f7;
        text-decoration: underline;
    }
    p{
        margin: 0;
    }
</style>
