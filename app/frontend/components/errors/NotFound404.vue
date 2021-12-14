<template>
    <v-container px-16 py-10 id="error-404-body">
        <v-row justify="center">
            <h1 class="mainColor--text">ページが見つかりません</h1>
        </v-row>
        <v-row justify="center">
            <h3 class="white--text">
                お探しのページは、移動または削除された可能性があります。
            </h3>
        </v-row>
        <v-row justify="center">
            <v-btn depressed x-large rounded color="primary" class="mt-4 mx-2 black--text" 
                to="/preparation"
            >
                コール練習へ戻る
            </v-btn>
        </v-row>
    </v-container>
</template>

<script>
    export default {
        name: "NotFound404",
        mounted() {
            document.title = "ページが見つかりません | Sycall"
        },
    }
</script>

<style scoped>
    #error-404-body{
        margin-top: 80px;
    }
</style>
