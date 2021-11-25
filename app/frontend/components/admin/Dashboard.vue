<template>
    <v-container fluid id="admin-body">
        <v-sheet class="mainColor rounded-xl mx-16">
            <v-container px-16 py-8>
                <v-tabs vertical color="maccha"
                    v-model="currentTab" class="rounded-l-xl"
                >
                    <v-tab v-for="tab in tabs" :key="tab.name">
                        <v-icon left>mdi-{{tab.icon}}</v-icon>{{tab.name}}
                    </v-tab>
                    <v-tabs-items v-model="currentTab" class="rounded-r-xl">
                        <v-tab-item v-for="comp in components" :key="comp">
                            <keep-alive>
                                <component :is="comp"></component>
                            </keep-alive>
                        </v-tab-item>
                    </v-tabs-items>
                </v-tabs>
            </v-container>
        </v-sheet>
    </v-container>
</template>

<script>
    import Artists from './Artists.vue'
    import Songs from './Songs.vue'
    import CallVersions from './CallVersions.vue'
    import CallLyrics from './CallLyrics.vue'
    export default {
        name: "Dashboard",
        components: {
            Artists,
            Songs,
            CallVersions,
            CallLyrics
        },
        data() {
            return {
                tabs:[
                    {icon: "account-music", name: "アーティスト"},
                    {icon: "music-clef-treble", name: "曲"},
                    {icon: "file-document", name: "バージョン"},
                    {icon: "music-box", name: "歌詞"},
                ],
                currentTab: "Artists",
                components: ["Artists", "Songs", "CallVersions", "CallLyrics"],
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
