<template>
    <v-container fluid id="footer">
        <v-sheet class="mainColor rounded-t-xl mx-16">
            <v-container px-16>
                <v-row align="center">
                    <v-col cols="4">
                        <div id="footer-left">
                            <h2 class="black--text">Sycall</h2>
                            <v-divider vertical class="black mx-2"></v-divider>
                            <v-btn icon color="black">
                                <v-icon>mdi-twitter</v-icon>
                            </v-btn>
                        </div>
                    </v-col>
                    <v-col cols="8">
                        <div id="footer-right">
                            <v-chip color="mainColor" small link class="black--text mb-1">
                                利用規約
                            </v-chip>
                            <v-chip color="mainColor" small link class="black--text mb-1">
                                よくある質問
                            </v-chip>
                            <v-chip color="mainColor" small link class="black--text mb-1">
                                フィードバック・ご意見
                            </v-chip>
                        </div>
                    </v-col>
                </v-row>

            </v-container>
        </v-sheet>
    </v-container>
</template>

<script>
    export default {
        name: "Footer",
    }
</script>

<style scoped>
    #footer {
        padding-bottom: 0;
    }
    #footer-left {
        display: flex;
        flex-direction: row;
        justify-content: flex-start;
    }
    #footer-right {
        display: flex;
        flex-direction: row;
        justify-content: flex-end;
    }
</style>
