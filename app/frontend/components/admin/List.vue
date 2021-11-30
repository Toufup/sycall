<template>
    <v-list>
        <div v-for="item in items" :key="item.id">
            <v-list-item>
                <v-list-item-icon>
                    <v-icon large color="maccha">mdi-{{iconName}}</v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                    <slot name="contentArea" :item=item></slot>
                </v-list-item-content>
                <v-dialog max-width="600px" :value="dialogEditId === item.id" class="rounded-xl" 
                    @click:outside="dialogEditId = false">
                    <template v-slot:activator="{on}">
                        <v-btn depressed rounded color="mainColor" class="black--text mx-2" 
                            v-on="on" @click="startEditing(item.id)">
                            <v-icon left color="black">mdi-pencil</v-icon>編集
                        </v-btn>
                    </template>
                    <v-card>
                        <v-card-title>
                            <h3>{{moduleName}}を編集する</h3>
                        </v-card-title>
                        <v-card-text>
                            <v-container>
                                <v-row>
                                    <slot name="formEditArea"></slot>
                                </v-row>
                            </v-container>
                        </v-card-text>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn depressed rounded color="black" class="white--text mx-2" 
                            @click="dialogEditId = false">
                                キャンセル
                            </v-btn>
                            <v-btn depressed rounded color="mainColor" class="black--text mx-2" 
                                @click="edit(item.id)">
                                <v-icon left color="black">mdi-content-save</v-icon>保存
                            </v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>
                <v-dialog max-width="600px" :value="dialogDeleteId === item.id" class="rounded-xl">
                    <template v-slot:activator="{on}">
                        <v-btn depressed rounded color="pink" class="black--text mx-2" 
                        v-on="on" @click="openDialog(item.id, 'dialogDeleteId')"
                        >
                            <v-icon left color="black">mdi-delete</v-icon>削除
                        </v-btn>
                    </template>
                    <v-card>
                        <v-card-title>
                            <h3>本当に削除しますか？</h3>
                        </v-card-title>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn depressed rounded color="black" class="white--text mx-2" @click="dialogDeleteId = false">
                                キャンセル
                            </v-btn>
                            <v-btn depressed rounded color="pink" class="black--text mx-2" 
                                @click="destroy(item.id)">
                                <v-icon left color="black">mdi-delete</v-icon>削除
                            </v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>
            </v-list-item>
            <v-divider></v-divider>
        </div>
    </v-list>
</template>

<script>
    import axios from 'axios'
    import {mapMutations} from 'vuex'
    export default {
        name: "List",
        data() {
            return {
                dialogDeleteId: false,
                dialogEditId: false,
            }
        },
        props: {
            items: {
                type: Array,
                required: true,
            },
            iconName: {
                type: String,
                required: true,
            },
            apiPath: {
                type: String,
                required: true,
            },
            moduleName: {
                type: String,
                required: true,
            },
            editFormat: {
                type: Object,
                required: false,
            },
        },
        watch: {
            dialogEditId(bool){
                if (!bool) {
                    console.log("closed");
                    this.$emit('handleEditDialogBlur')
                }
            }
        },
        methods: {
            ...mapMutations(["showSuccessAlert"]),
            openDialog(id, dialogId){
                this[dialogId] = id
            },
            destroy(id){
                this.dialogDeleteId = false
                axios.delete(`${this.apiPath}/${id}`)
                .then(() => {
                    this.$emit("destroyItem", id)
                    this.showSuccessAlert({
                        action: "削除",
                        flag: true, 
                        type: this.moduleName
                    })
                })
                .catch(err => {
                    console.error(err); 
                })
            },
            startEditing(id){
                this.$emit("startEditing", id)
                this.openDialog(id, 'dialogEditId')
            },
            edit(id){
                this.dialogEditId = false;
                axios.put(`${this.apiPath}/${id}`, this.editFormat)
                .then((res) => {
                    const obj = Object.assign(this.editFormat, res.data)
                    this.$emit("updateItem", obj)
                    this.showSuccessAlert({
                        action: "変更",
                        flag: true, 
                        type: this.moduleName
                    })
                })
                .catch(err => {
                    console.error(err); 
                })
            },
        },
    }
</script>
