<template>
    <v-container fluid id="preparation-body">
        <v-card color="mainColor" class="rounded-xl mx-16">
            <v-container class="pa-8 black--text">
                <v-col cols="12">
                    <h1>お知らせ</h1>
                </v-col>
                <v-col cols="12">
                    <v-card outlined class="rounded-xl" color="white black--text">
                        <v-card-title>
                            <span>2021/12/12</span>
                            <v-divider vertical class="mx-2"></v-divider>
                            <p>第1条（適用）</p>
                        </v-card-title>
                    </v-card>
                </v-col>
            </v-container>
        </v-card>
    </v-container>
</template>

<script>
    export default {
        name: "News",
        mounted() {
            document.title = "お知らせ | Sycall"
        },
    }
</script>

<style scoped>
    p{
        margin: 0;
    }
    h2{
        margin-top: 10px;
    }
</style>
