<template>
    <v-container fluid id="admin-body">
        <v-alert dismissible type="success" color="maccha" dense class="mx-16 rounded-xl" 
            :value="successAlert.flag" @input="closeSuccessAlert" transition="scale-transition">
            {{successAlert.type}}を{{successAlert.action}}しました！
        </v-alert>
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
    import {mapGetters, mapMutations} from 'vuex'
    export default {
        name: "Dashboard",
        data() {
            return {
                tabs:[
                    {icon: "account-music", name: "アーティスト", route: "artists"},
                    {icon: "music-clef-treble", name: "曲", route: "songs"},
                    {icon: "file-document", name: "バージョン", route: "callLyricsVersions"},
                    {icon: "music-box", name: "歌詞", route: "callLyrics"},
                ],
                currentTab: "Artists",
            }
        },
        computed: {
            ...mapGetters(["successAlert"]),
        },
        methods: {
            ...mapMutations(["closeSuccessAlert"])
        },
    }
</script>

<style>
    .v-tabs-slider-wrapper {
        left: auto !important;
        right: 0;
    }
</style>
