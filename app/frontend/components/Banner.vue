<template>
    <v-container id="news-body">
        <v-banner outlined color="white" class="rounded-xl pa-0" single-line>
            <div class="d-flex align-center justify-center" id="banner-text">
                <v-icon left color="maccha">mdi-information</v-icon>
                <a>
                    <span class="black--text d-flex align-baseline">
                        2021/12/16 Sycall 正式リリースしました！
                        <v-icon small>mdi-open-in-new</v-icon>
                    </span>
                </a>
            </div>
        </v-banner>
    </v-container>
</template>

<script>
    export default {
        name: "Banner",
    }
</script>

<style scoped>
    a:hover {
        color: #323232;
        text-decoration: underline;
    }
</style>
