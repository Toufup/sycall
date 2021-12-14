<template>
    <v-container fluid id="admin-body">
        <v-sheet class="mainColor rounded-xl mx-16">
            <v-container px-16 py-8>
                <v-tabs vertical color="maccha"
                    v-model="currentTab" class="rounded-l-xl"
                >
                    <v-tab v-for="tab in tabs" :key="tab.name" :to="{name: tab.route}">
                        <v-icon left>mdi-{{tab.icon}}</v-icon>{{tab.name}}
                    </v-tab>
                    <v-tabs-items v-model="currentTab" class="rounded-r-xl">
                        <router-view></router-view>
                    </v-tabs-items>
                </v-tabs>
            </v-container>
        </v-sheet>
    </v-container>
</template>

<script>
    import "animate.css"
    export default {
        name: "Dashboard",
        data() {
            return {
                tabs:[
                    {icon: "account-music", name: "アーティスト", route: "artists"},
                    {icon: "music-clef-treble", name: "曲", route: "songs"},
                    {icon: "file-document", name: "バージョン", route: "callLyricsVersions"},
                    {icon: "music-box", name: "歌詞", route: "callLyrics"},
                    {icon: "fire", name: "人気キーワード", route: "populars"},
                ],
                currentTab: "Artists",
            }
        },
    }
</script>

<style>
    .v-tabs-slider-wrapper {
        left: auto !important;
        right: 0;
    }
</style>
