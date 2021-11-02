<template>
    <v-container px-16 py-10 id="top-page-body">
        <v-row justify="space-between">
            <v-col>
                <div id="top-body-left">
                    <h1 class="mainColor--text">最高なコールを！</h1>
                    <p>Sycall は K-POP アイドル曲のコール練習 を楽しくする。 <br/> 最高なコールを決めて推しを応援しよう！</p>
                    <v-btn depressed x-large rounded color="mainColor" class="mt-4" @click="sparkles($event)">Try Now!</v-btn>
                </div>
            </v-col>
            <v-col>
                <div id="top-body-lright">
                    <v-img src="https://dummyimage.com/300x200/000/fff"  ></v-img>
                </div>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    import party from "party-js";
    export default {
        name: "TopPageBody",
        methods: {
            sparkles(event){
                party.sparkles(event.target,{
                    count: party.variation.range(10, 20),
                    speed: party.variation.range(50, 450),
                })
            }
        },
    }
</script>

<style scoped>
    /* h1{
        font-size: xx-large;
    } */
    p{
        color: #f5f5f7;
    }
</style>
