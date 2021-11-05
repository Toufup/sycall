<template>
    <div id="subtitle">
        <div id="search-bar">
            <h2 class="black--text">どのコールで練習しますか？</h2>
            <v-text-field placeholder="曲名、アーティスト名で検索する" 
                clearable clear-icon="mdi-close-circle"
                prepend-inner-icon="mdi-subtitles" class="mt-2"
                background-color="white" color="primary" rounded outlined
                id="search-input" v-model="keyword"
            ></v-text-field>
        </div>
        <div id="result-list">
            <v-menu activator="#search-input" offset-y max-height="200px">
                <v-list rounded v-show="hasResult">
                    <v-list-item-group color="primary" v-model="selected">
                        <v-list-item v-for="result in results" :key="result.id">
                            <v-list-item-content>
                                <v-list-item-title>{{result.title}}</v-list-item-title>
                                <v-list-item-subtitle>
                                    アーティスト：{{result.artist}}
                                </v-list-item-subtitle>
                                <v-list-item-subtitle>
                                    作成者：{{result.creator}}
                                </v-list-item-subtitle>
                            </v-list-item-content>
                        </v-list-item>
                    </v-list-item-group>
                </v-list>
            </v-menu>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Search",
        data() {
            return {
                // TODO インプットエリアをもう一回クリックすると表示しなくなる現象を解消する
                isActive: true,
                hasResult: false,
                selected: null,
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
        watch: {
            keyword(value){
                console.log(value);
                if (value && value !== this.selected ) {
                    this.results = this.calls.filter((c) => {
                        return c.title.toLowerCase().indexOf(value) !== -1
                    });
                    this.results.length > 0 ? this.hasResult = true : this.hasResult = false
                } else {
                    this.hasResult = false
                }
            },
        },
    }
</script>

<style scoped>

</style>
