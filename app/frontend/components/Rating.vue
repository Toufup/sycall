<template>
    <v-container class="pa-8 black--text">
        <form action="https://docs.google.com/forms/u/3/d/e/1FAIpQLScR2wgHZGeN0IrysE4m5XEETkxZbxLCOPsiH0gsdtnSD_OzRw/formResponse" method="post" target="dummyIframe" @submit="hasRate = true">
            <v-col cols="12">
                <h1 style="font-size:45px;">おつかれさまです！</h1>
                <v-card outlined class="rounded-xl" color="white">
                    <v-card-title>
                        <h3>アプリの使用感はいかがだったでしょうか？</h3>
                    </v-card-title>
                    <v-card-subtitle>
                        よろしければ満足度を教えてください。今後の改善に参考させていただきます。
                    </v-card-subtitle>
                    <v-card-text class="text-center">
                        <v-rating length="5" size="60" background-color="maccha" color="maccha" hover
                            v-show="!hasRate" v-model="rating" type="radio"
                        ></v-rating>
                        <input type="hidden" name="entry.886849203" :value="rating">
                        <h1 class="maccha--text" v-show="hasRate">
                            <v-icon color="maccha" large>mdi-handshake</v-icon>
                            ご協力ありがとうございます！
                        </h1>
                    </v-card-text>
                </v-card>
            </v-col>
            <v-col cols="12" class="d-flex justify-space-between">
                <v-btn x-large depressed class="ma-1 rounded-xl white--text" color="#1DA1F2"
                    :href="shareTwitter" target="_blank"
                >
                    <v-icon color="white">mdi-twitter</v-icon>Twitterにシェア
                </v-btn>
                <v-btn x-large depressed class="ma-1 black--text rounded-xl" color="primary" 
                    type="submit" v-show="!hasRate"
                >送信</v-btn>
                <v-btn x-large depressed class="ma-1 white--text rounded-xl" color="pink" 
                    v-show="hasRate" to="/preparation"
                >もう一曲練習する</v-btn>
            </v-col>
        </form>
        <iframe name="dummyIframe" style="display:none;"></iframe>
    </v-container>
</template>

<script>
    export default {
        name: "Rating",
        data() {
            return {
                rating: 0,
                hasRate: false,
            }
        },
        props: {
            shareTwitter: {
                type: String,
                require: true,
            }
        }
    }
</script>
