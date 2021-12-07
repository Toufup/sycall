<template>
    <div id="search-box">
        <div>
            <v-text-field placeholder="曲名、アーティスト名で検索する" 
                clearable clear-icon="mdi-close-circle"
                prepend-inner-icon="mdi-subtitles" class="mt-2"
                background-color="white" color="maccha" rounded outlined
                id="search-input" v-model="keyword"
            ></v-text-field>
        </div>
        <div>
            <v-list v-if="isLoading" rounded max-height="200px" class="rounded-xl overflow-y-auto mt-n7 mb-7">
                <v-list-item>
                    <v-list-item-content>
                        <v-progress-circular indeterminate color="maccha"></v-progress-circular>
                    </v-list-item-content>
                </v-list-item>
            </v-list>
            <v-list v-else-if="isValid && hasResult" rounded max-height="280px" class="rounded-xl overflow-y-auto mt-n5 mb-7">
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
                            <!-- <v-list-item-subtitle>
                                コール作成者：{{result.creator}}
                            </v-list-item-subtitle> -->
                        </v-list-item-content>
                    </v-list-item>
                </v-list-item-group>
            </v-list>
            <v-list v-else-if="isValid && !hasResult" rounded max-height="200px" class="rounded-xl overflow-y-auto mt-n7 mb-7">
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
    }
</script>
