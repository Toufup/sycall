<template>
    <v-container class="pa-8 black--text">
        <v-col cols="12">
            <v-card outlined class="rounded-xl" color="white">
                <v-card-title>
                    <h1 style="font-size:45px;">
                        <v-icon x-large color="maccha">mdi-check-circle</v-icon>ありがとうございます！
                    </h1>
                </v-card-title>
                <v-card-text>
                    <span>頂いた内容をもとにサービスを改善し続けてまいります。</span><br>
                    <span>
                        <a href="https://twitter.com/SycallApp" target="_blank">
                            <v-chip color="#1DA1F2" small link class="ma-1" outlined>
                                Twitterの公式アカウント<v-icon small>mdi-open-in-new</v-icon>
                            </v-chip>
                        </a>
                        をフォローして、最新のリリース情報をゲットしましょう！
                    </span>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn x-large depressed class="ma-1 rounded-xl white--text" color="black" @click="closeForm">
                        閉じる
                    </v-btn>
                    <v-btn x-large depressed class="ma-1 rounded-xl" color="maccha" outlined @click="openNew">
                        別のフィードバックを送信
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-col>
    </v-container>
</template>

<script>
    export default {
        name: "Thanks",
        methods: {
            closeForm(){
                this.$emit("closeForm")
            },
            openNew(){
                this.$emit("openNew")
            }
        },
    }
</script>
