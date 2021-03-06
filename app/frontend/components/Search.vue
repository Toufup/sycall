<template>
    <div id="search-box">
        <div align="center" class="d-flex align-center mb-1" v-if="popularWords">
            <v-icon large color="warning">mdi-fire</v-icon>
            <p class="ma-0">人気キーワード：</p>
            <v-chip v-for="popular in popularWords" :key="popular.id" class="ma-1 black-text"
                link outlined color="black" @click="keyword = popular.word"
            >
                {{ popular.word }}
            </v-chip>
        </div>
        <div>
            <v-text-field placeholder="曲名、アーティスト名で検索する" 
                autofocus clearable clear-icon="mdi-close-circle" hide-details
                prepend-inner-icon="mdi-subtitles"
                background-color="white" color="maccha" rounded outlined
                id="search-input" v-model="keyword"
            ></v-text-field>
        </div>
        <div class="mt-2 mb-7">
            <v-list v-if="isLoading" rounded max-height="200px" class="rounded-xl overflow-y-auto">
                <v-list-item>
                    <v-list-item-content>
                        <v-progress-circular indeterminate color="maccha"></v-progress-circular>
                    </v-list-item-content>
                </v-list-item>
            </v-list>
            <v-list v-else-if="isValid && hasResult" rounded max-height="280px" class="rounded-xl overflow-y-auto">
                <v-list-item-group color="maccha" mandatory v-model="activeTarget">
                    <v-list-item 
                        v-for="result in results" :key="result.id" 
                        @click="selectResult(result)" v-slot="{ active }">
                        <v-list-item-icon>
                            <v-icon large v-show="!active">mdi-checkbox-blank-circle-outline</v-icon>
                            <v-icon large v-show="active">mdi-checkbox-marked-circle</v-icon>
                        </v-list-item-icon>
                        <v-list-item-content>
                            <v-list-item-title>{{result.title}}</v-list-item-title>
                            <v-list-item-subtitle>
                                アーティスト：{{result.artist}}
                            </v-list-item-subtitle>
                            <v-list-item-subtitle>
                                形式：{{result.language}}
                            </v-list-item-subtitle>
                            <!-- <v-list-item-subtitle>
                                コール作成者：{{result.creator}}
                            </v-list-item-subtitle> -->
                        </v-list-item-content>
                    </v-list-item>
                </v-list-item-group>
            </v-list>
            <v-list v-else-if="isValid && !hasResult" rounded max-height="200px" class="rounded-xl overflow-y-auto">
                <v-list-item>
                    <v-list-item-content>
                        <v-list-item-title class="font-weight-bold">一致するコールは見つかりませんでした</v-list-item-title>
                        <v-list-item-subtitle>
                            <span class="maccha--text font-weight-bold">「フィードバック・ご意見」</span>
                            から開発者にリクエストしましょう！♪
                        </v-list-item-subtitle>
                    </v-list-item-content>
                </v-list-item>
            </v-list>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'
    import {mapActions} from 'vuex'
    export default {
        name: "Search",
        data() {
            return {
                isValid: false,
                hasResult: false,
                selectedResult: null,
                activeTarget: 0,
                keyword: "",
                isLoading: false,
                results: [],
                popularWords: [],
            }
        },
        computed: {
            hasSelected(){
                return this.selectedResult ? true : false
            }
        },
        watch: {
            keyword(value){
                this.activeTarget = 0;
                this.selectedResult = null;

                if (value && value.trim()) {
                    this.isLoading = true;
                    axios.get("/calls/search", {params: {keyword: value}})
                    .then(res => {
                        this.isValid = true;
                        this.results = res.data;
                        this.isLoading = false;
                        this.results.length > 0 ? this.hasResult = true : this.hasResult = false;
                        this.selectResult(this.results[0]);
                    })
                } else {
                    this.hasResult = false;
                    this.results = [];
                    this.isValid = false;
                    this.selectResult(null);
                }
            },
            hasSelected: {
                immediate: true,
                handler(value){
                    this.$emit("checkCallError",value)
                }
            }
        },
        methods: {
            ...mapActions(["sendSelectedCallInfo"]),
            selectResult(result){
                if (result) {
                    this.selectedResult = result;
                } else {
                    this.selectedResult = null;
                }
                this.sendSelectedCallInfo(result);
            }
        },
        mounted() {
            // 選択していたコールがあればクリアしておく
            this.sendSelectedCallInfo(null);
            axios.get("/calls/get_popular_words")
            .then(res => {
                this.popularWords = res.data
            })
        },
    }
</script>
