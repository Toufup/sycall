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
            <v-list v-show="isValid && !hasResult" rounded max-height="200px" class="rounded-xl overflow-y-auto mt-n7 mb-7">
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
            <v-list v-if="hasResult" rounded max-height="280px" class="rounded-xl overflow-y-auto mt-n5 mb-7">
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
                                コール作成者：{{result.creator}}
                            </v-list-item-subtitle>
                        </v-list-item-content>
                    </v-list-item>
                </v-list-item-group>
            </v-list>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'
    export default {
        name: "Search",
        data() {
            return {
                isValid: false,
                hasResult: false,
                selectedResult: null,
                activeTarget: 0,
                keyword: "",
                results: [],
                calls: [
                    {id:"001", title: "WANNABE", artist: "ITZY", creator: "Admin"},
                    {id:"002", title: "ICY", artist: "ITZY", creator: "Admin"},
                    {id:"003", title: "LOCO", artist: "ITZY", creator: "Admin"},
                    {id:"004", title: "LOCO", artist: "ITZY", creator: "Admin"},
                    {id:"005", title: "This Fell", artist: "TWICE", creator: "Admin"},
                ]
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

                axios.get("/calls/search", {
                    params: {
                        keyword: value
                    }
                })
                .then(res => {
                    console.log(res.data)
                })
                .catch(err => {
                    console.error(err.message); 
                })

                if (value && value.trim()) {
                    this.isValid = true;
                    this.results = this.calls.filter((c) => {
                        return c.title.toLowerCase().indexOf(value.trim().toLowerCase()) !== -1 || 
                                c.artist.toLowerCase().indexOf(value.trim().toLowerCase()) !== -1
                    });
                    this.results.length > 0 ? this.hasResult = true : this.hasResult = false;
                    this.selectedResult = this.results[0];
                } else {
                    this.hasResult = false;
                    this.isValid = false;
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
            selectResult(result){
                this.selectedResult = result;
            }
        },
    }
</script>
