<template>
    <v-container id="artists-group">
        <v-btn depressed rounded color="primary" class="black--text">
            <v-icon left color="black">mdi-plus-circle</v-icon>追加
        </v-btn>
        <v-list>
            <div id="artist" v-for="artist in artists" :key="artist.id">
                <v-list-item>
                    <v-list-item-icon>
                        <v-icon large color="maccha">mdi-account-music</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title class="black--text">{{artist.name}}</v-list-item-title>
                    </v-list-item-content>
                    <v-btn depressed rounded color="mainColor" class="black--text mx-2">
                        <v-icon left color="black">mdi-pencil</v-icon>編集
                    </v-btn>
                    <v-btn depressed rounded color="pink" class="black--text mx-2">
                        <v-icon left color="black">mdi-delete</v-icon>削除
                    </v-btn>
                </v-list-item>
                <v-divider></v-divider>
            </div>
        </v-list>
        <!-- <v-pagination v-model="page" :length="5" circle color="maccha"></v-pagination> -->
    </v-container>
</template>

<script>
    export default {
        name: "Artists",
        data() {
            return {
                artists: [
                    {id: 1, name: "ITZY"},
                    {id: 2, name: "TWICE"},
                    {id: 3, name: "NiziU"},
                    {id: 4, name: "BLACKPINK"},
                    {id: 5, name: "EVERGLOW"},
                ],
                page: 1,
            }
        },
    }
</script>
