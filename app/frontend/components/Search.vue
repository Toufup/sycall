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
        <!-- TODO E 結果を選択した時に、末尾にチェックマークを付ける -->
        <!-- TODO B リストアイテムをクリック後、Valueを入力欄に反映させる -->
        <!-- TODO D 結果リストをオーバーフロー形式にする、最大heightは3行 -->
        <!-- TODO A 結果がない場合の表示 -->
        <div id="result-list">
            <transition enter-active-class="animate__animated animate__fadeIn"
            leave-active-class="animate__animated animate__fadeOut">
            <!-- TODO C 理想：結果リストを浮かせる -->
            <!-- TODO C 出来なければ：結果リストの位置を入力欄にくっつけるように調整する。 -->
                <v-list rounded v-show="hasResult" class="rounded-xl mt-n7 ">
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
            </transition>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Search",
        data() {
            return {
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
                // 入力値があれば判別ロジックに入る
                if (value && value !== this.selected ) {
                    this.results = this.calls.filter((c) => {
                        // タイトルで検索するロジック
                        // TODO AA アーティスト名で検索するロジックを考える。
                        return c.title.toLowerCase().indexOf(value.toLowerCase()) !== -1
                    });
                    // 結果があれば「結果あり」のフラグを、なければ「結果なし」のフラグをつける。
                    this.results.length > 0 ? this.hasResult = true : this.hasResult = false
                } else {
                    // TODO A 入力値がなければ判別ロジックに入らず、入力欄が初期状態であるフラグを設定
                    this.hasResult = false
                }
            },
        },
    }
</script>

<style scoped>

</style>
