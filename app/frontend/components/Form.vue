<template>
    <v-card color="mainColor">
        <form action="https://docs.google.com/forms/u/3/d/e/1FAIpQLSdoCe9AFGGQeQr1FC6kXwpwHNVrWl5_QVGZtgNWZm21uCBmhA/formResponse" method="post" target="dummyIframe" v-show="!hasSent" @submit="hasSent = true">
            <v-container class="pa-8 black--text">
                <v-col cols="12">
                    <h1 style="font-size:45px;">フィードバック・ご意見</h1>
                    <p>Sycall をご利用いただきありがとうございます。<br>
                        ご利用中の不具合や、ご意見、ご要望などありましたら、お気軽にご連絡ください。
                    </p>
                </v-col>
                <v-col cols="12">
                    <v-card outlined class="rounded-xl" color="white">
                        <v-card-title>
                            <p>お問い合わせの種類（<v-icon color="pink">mdi-asterisk</v-icon>必須）</p>
                        </v-card-title>
                        <v-card-text>
                            <v-radio-group v-model="contactVal" class="ma-0" :error="this.hasContactTypeErr"
                            >
                                <v-radio v-for="type in contactType" :key="type"
                                    :label="type" :value="type" name="entry.1447489468"
                                    color="maccha" required
                                ></v-radio>
                            </v-radio-group>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12">
                    <v-card outlined class="rounded-xl" color="white">
                        <v-card-title>
                            <p>お問い合わせ内容（<v-icon color="pink">mdi-asterisk</v-icon>必須）</p>
                        </v-card-title>
                        <v-card-text>
                            <v-textarea v-model.trim="contactBody" :error="this.hasContactBodyErr" required
                                outlined color="maccha" class="rounded-xl" name="entry.1448313913"
                            >
                            </v-textarea>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12">
                    <v-card outlined class="rounded-xl" color="white">
                        <v-card-title>
                            <p>返信の必要な場合、メールアドレスをご記載ください（任意）</p>
                        </v-card-title>
                        <v-card-text>
                            <v-text-field v-model="email" outlined color="maccha" class="rounded-xl"
                                name="entry.402567380"
                            >
                            </v-text-field>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" class="text-end">
                    <v-btn x-large depressed class="ma-1 rounded-xl white--text" color="black" @click="closeForm">
                        閉じる
                    </v-btn>
                    <v-btn x-large depressed class="ma-1 black--text rounded-xl" color="primary" 
                        @click="submit" type="submit"
                    >送信</v-btn>
                </v-col>
            </v-container>
        </form>
        <iframe name="dummyIframe" style="display:none;" @load="afterSubmit"></iframe>
        <Thanks v-show="hasSent" @openNew="openNew" @closeForm="closeForm"></Thanks>
    </v-card>
</template>

<script>
    import party from "party-js";
    import Thanks from './Thanks.vue'
    export default {
        name: "Form",
        components: {
            Thanks
        },
        data() {
            return {
                contactVal: null,
                contactType: ["不具合報告", "ご意見・ご要望"],
                contactBody: null,
                email: null,
                hasContactTypeErr: false,
                hasContactBodyErr: false,
                hasSent: false
            }
        },
        computed: {
            canSubmit(){
                return !this.hasContactTypeErr && !this.hasContactBodyErr ? true : false
            }
        },
        watch: {
            contactVal(val){
                this.hasContactTypeErr = val ? false : true
            },
            contactBody(body){
                this.hasContactBodyErr = body ? false : true
            },
        },
        methods: {
            submit(event){
                this.hasContactTypeErr = this.contactVal ? false : true
                this.hasContactBodyErr = this.contactBody ? false : true
                if (this.canSubmit) {
                    party.confetti(event)
                } else {
                    return
                }
            },
            afterSubmit(){
                this.contactVal = null
                this.contactBody = null
                this.email = null
            },
            openNew(){
                this.hasSent = false
            },
            closeForm(){
                this.$emit("closeForm")
            }
        },
    }
</script>

<style scoped>
    p{
        margin: 0;
    }
</style>
