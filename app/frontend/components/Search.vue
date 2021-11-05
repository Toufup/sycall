<template>
    <div id="subtitle">
        <div id="search-bar">
            <h2 class="black--text">どのコールで練習しますか？</h2>
            <v-text-field placeholder="曲名、アーティスト名で検索する" 
                clearable clear-icon="mdi-close-circle"
                prepend-inner-icon="mdi-subtitles" class="mt-2"
                background-color="white" color="primary" rounded outlined
                id="search-input"
            ></v-text-field>
        </div>
        <div id="result-list">
            <v-menu activator="#search-input" offset-y max-height="200px">
                <v-list v-for="result in results" :key="result.id">
                    <v-list-item>
                        <v-list-item-content>
                            <v-list-item-title>{{result.title}}</v-list-item-title>
                        </v-list-item-content>
                    </v-list-item>
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
                results: [
                    {id:"001", title: "WANNABE", artist: "ITZY", creator: "Admin"},
                    {id:"002", title: "ICY", artist: "ITZY", creator: "Admin"},
                    {id:"003", title: "LOCO", artist: "ITZY", creator: "Admin"},
                    {id:"004", title: "LOCO", artist: "ITZY", creator: "Admin"},
                    {id:"005", title: "LOCO", artist: "ITZY", creator: "Admin"},
                    {id:"006", title: "LOCO", artist: "ITZY", creator: "Admin"},
                    {id:"007", title: "LOCO", artist: "ITZY", creator: "Admin"},
                    {id:"008", title: "LOCO", artist: "ITZY", creator: "Admin"},
                    {id:"009", title: "LOCO", artist: "ITZY", creator: "Admin"},
                    {id:"010", title: "LOCO", artist: "ITZY", creator: "Admin"},
                    {id:"011", title: "LOCO", artist: "ITZY", creator: "Admin"},
                    {id:"012", title: "LOCO", artist: "ITZY", creator: "Admin"},
                ]
            }
        },
    }
</script>

<style scoped>

</style>
