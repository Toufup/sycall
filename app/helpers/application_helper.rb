module ApplicationHelper
    def default_meta_tags
        {
            site: "Sycall",
            title: "K-POPコール練習アプリ",
            reverse: true,
            charset: 'utf-8',
            description: "Sycall は K-POP のコール練習を楽しくする。登録不要で 1 クリックでスタート!「最高」な「コール」を決めて推しを応援しよう!今すぐ始めてみよう!(PC推奨)",
            keywords: ["kpop", "fanchant", "kpop groups", "kpop girl groups", "kpop アイドル", "kpop グループ", "bts", "blackpink", "twice"],
            canonical: "https://sycall.app/",
            separator: "|",
            icon: [
                { href: image_url("favicon.png") },
                { href: image_url("favicon.png"), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
            ],
            og: {
                site_name: "Sycall | K-POPコール練習アプリ",
                title: "K-POPコール練習なら【Sycall】! 登録不要で 1 クリックでスタート!",
                description: :description,
                type: 'website',
                url: "https://sycall.app/",
                image: image_url('ogp.png'),
                locale: 'ja_JP',
            },
            twitter: {
                card: "summary_large_image",
                site: "@SycallApp",
            }
        }
    end
end
