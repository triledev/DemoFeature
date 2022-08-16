# ``Feed Loader``

## Feed Feature Specs

### Story: Subscriber requests to see their news feed

### Narrative #1
```
As an online subscriber  
I want the app to automatically load my latest news feed  
So I can always stay up to date with current events
```

#### Scenarios (Acceptance criteria)
>
Given __the__ subscriber has connectivity  
When __the__ subscriber request *to* see __the__ feed  
Then __the__ app should display __the__ latest feed *from* remote  
  And *replace* __the__ cache __with the__ *new* feed


### Narrative #2
```
As an offline subscriber  
I want the app to show the latest saved version of my news feed  
So I can always stay up to date with current events
```

#### Scenarios (Acceptance criteria)
>
Given the subscriber doesn't have connectivity  
__When__ the subscriber request __to__ see the feed  
__Then__ the app should display the latest feed saved

>
Given the subscriber desn't have connectivity  
__And__ the cache __is__ empty  
__When__ the subscriber request __to__ see the feed  
__Then__ the app should display an __error__ message

---

# Use Cases

## Load Feed

### Data:
- URL

### Primary course (happy path):
1. Execute "Load Feed Items" command with above data.  
2. System downloads data from the URL.
3. System validates downloaded data.
4. System creates feed items from valid data.
5. System delivers feed items.

### Invalid data - error course (sad path):
1. System delivers error.  

### No connectivity - error course (sad path):
1. System delivers error.  

## Load Feed Fallback (Cache)

### Data:
- Max age

### Primary course:
1. Execute "Retrieve Feed Items" command with above data.  
2. System fetches feed data from cache.  
3. System creates feed items from cached data.  
4. system delivers feed items.  

### No cache course (sad path):
1. System delivers no feed items.

## Save Feed Items

### Data:
- Feed items

### Primary course (happy path):
1. Execute "Save Feed Items" command with above data.  
2. System encodes feed items.  
3. System timestamps the new cache.  
4. System replaces the cache with new data.  
5. System delivers success message.

---

GET * http://api.mediastack.com/v1/news?access_key=bc6aff46b7ed7e0b2e29c421ffc9fcfd&countries=us&languages=en&limit=100 *

```
// Live News Data

http://api.mediastack.com/v1/news
    ? access_key = YOUR_ACCESS_KEY
    
// optional parameters: 

    & sources = cnn,bbc
    & categories = business,sports
    & countries = us,au
    & languages = en,-de
    & keywords = virus,-corona
    & sort = published_desc
    & offset = 0
    & limit = 100
```

---

### Example API Response:

If your API request has been successful, the mediastack API will return HTTP status 200 together with a JSON result, carrying a pagination object as well as a data object containing one or multiple news articles.

200 RESPONSE

```
{
    "pagination":{
        "limit":100,
        "offset":0,
        "count":100,
        "total":10000
    },
    "data":[
        {
            "author":"The Sentinel",
            "title":"Off to the races: Hold on, more divisive controversy and a hefty election is gaining speed",
            "description":"Sure, if you\u2019re like many in the region, you\u2019re thinking election news is like bad weather these days, always on the horizon.\u00a0While the much-watched \u201cmid-term\u201d congressional races capture most of the headlines, November will bring a bevy of consequential choices to every voter across Colorado.",
            "url":"https:\/\/sentinelcolorado.com\/orecent-headlines\/off-to-the-races-hold-on-more-divisive-controversy-and-a-hefty-election-is-gaining-speed\/",
            "source":"aurorasentinel",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T18:43:15+00:00"
        },
        {
            "author":"Associated Press",
            "title":"Israeli medics say 3 killed in stabbing attack near Tel Aviv",
            "description":"JERUSALEM (AP) \u2014 Israeli medics say at least three people were killed in a stabbing attack near Tel Aviv. Israeli police said they suspect it was a militant attack and that the assailant fled in a vehicle. Security forces set up roadblocks in the area around where the killings occurred on Thursday night, in theThe post Israeli medics say 3 killed in stabbing attack near Tel Aviv appeared first on KION546.",
            "url":"https:\/\/kion546.com\/news\/ap-national-news\/2022\/05\/05\/israeli-medics-say-3-killed-in-stabbing-attack-near-tel-aviv\/",
            "source":"kionrightnow",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T18:42:38+00:00"
        },
        {
            "author":"Scott Schaefer",
            "title":"VIDEO: \u2018If Only I Had Listened\u2026\u2019 Neighbors tell stories at \u20187 Stories\u2019 event",
            "description":"A \u201c7 Stories\u201d event was held at the Highline Heritage Museum on Friday, April 22, 2022, with local storytellers speaking on the theme \u0026#8220;If Only I Had Listened\u0026#8230;\u0026#8220; This event [\u0026#8230;]",
            "url":"https:\/\/b-townblog.com\/2022\/05\/05\/video-if-only-i-had-listened-neighbors-tell-stories-at-7-stories-event\/",
            "source":"b-townblog",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T18:36:15+00:00"
        },
        {
            "author":"National Security Agency",
            "title":"Publication - National Cryptologic Museum Library",
            "description":"SRH-013 Ultra History of US Strategic Air Force Europe VS. German Air Force",
            "url":"https:\/\/www.dvidshub.net\/publication\/issues\/63546",
            "source":"dvidshub",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T18:45:06+00:00"
        },
        {
            "author":"National Security Agency",
            "title":"Publication - National Cryptologic Museum Library",
            "description":"SRH-012-002 The Role of Communication Intelligence in the American-Japanese Naval War Vol 2",
            "url":"https:\/\/www.dvidshub.net\/publication\/issues\/63544",
            "source":"dvidshub",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T18:45:00+00:00"
        },
        {
            "author":"Sammy Approved",
            "title":"Happy Cinco De Mayo: Five Fast Facts About The Holiday Linked To African American History",
            "description":"There is one part they don\u0027t teach you in the history books: How Cinco De Mayo is linked to African American history. Take a look at five fast facts about the holiday and how Africans are tied into it all.\u00a0",
            "url":"https:\/\/globalgrind.com\/5050249\/happy-cinco-de-mayo-five-fast-facts-about-the-holiday-linked-to-african-american-history\/",
            "source":"globalgrind",
            "image":"https:\/\/globalgrind.com\/wp-content\/uploads\/sites\/16\/2021\/05\/1620247208824.jpg?quality=80\u0026strip=all\u0026w=560\u0026crop=0,0,100,320px",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T18:43:36+00:00"
        },
        {
            "author":null,
            "title":"How our brains influence language change",
            "description":"Our language is changing constantly. Researchers of the University of Vienna found that, over centuries, frequently occurring speech sound patterns get even more frequent. The reason for this development is that our brain can perceive, process and learn frequent, and thus prototypical sound patterns more easily than less frequent ones. The results of the study were published in the journal Cognitive Linguistics.",
            "url":"https:\/\/phys.org\/news\/2022-05-brains-language.html",
            "source":"Phys.org - News And Articles On Science And Technology",
            "image":"https:\/\/scx1.b-cdn.net\/csz\/news\/tmb\/2020\/2-language.jpg",
            "category":"science",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T18:48:53+00:00"
        },
        {
            "author":"Kerry Crowley",
            "title":"Baseball comes full circle as SF Giants honor Buster Posey, the newest Little League coach",
            "description":"The Giants are holding \u0022Buster Posey Day\u0022 at Oracle Park on Saturday ahead of a game against the St. Louis Cardinals.",
            "url":"https:\/\/www.marinij.com\/2022\/05\/05\/baseball-comes-full-circle-as-sf-giants-honor-buster-posey-the-newest-little-league-coach\/",
            "source":"marinij",
            "image":"https:\/\/www.marinij.com\/wp-content\/uploads\/2022\/05\/BNG-L-POSEY-1105-2.jpg?w=1400px\u0026strip=all",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T18:45:32+00:00"
        },
        {
            "author":"VeggieDog",
            "title":"Man who attacked Dave Chappelle on stage won\u0092t be charged with a felony",
            "description":"https:\/\/ktla.com\/news\/local-news\/man-who-attacked-dave-chappelle-on-hollywood-bowl-stage-wont-be-charged-with-a-felony\/?fbclid=IwAR3du3l9Ze44pFKFocR6ElL-rnJx5limMe-_8CembR40o9pw65k_M8RUDb0 A man who rushed comedian Dave Chappelle on stage at the Hollywood Bowl won\u0092t be charged with a felony,...",
            "url":"https:\/\/www.sportsbookreview.com\/forum\/players-talk\/3698536-man-who-attacked-dave-chappelle-stage-won-t-charged-felony.html",
            "source":"sbrforum",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T18:49:05+00:00"
        },
        {
            "author":"leighnordstrom",
            "title":"What Do the Celebrities Eat at the Met Gala? Melissa King\u00a0Explains",
            "description":"Chef Melissa King explains what she made for the Met Gala menu and how the night unfolded.",
            "url":"https:\/\/wwd.com\/eye\/people\/chef-melissa-king-met-gala-2022-food-1235174819\/",
            "source":"wwd",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T18:44:42+00:00"
        },
        {
            "author":"Raj Bhala",
            "title":"Wartime World Trade: Fragmentation Thrice Over",
            "description":"Wartime World Trade: Fragmentation Thrice Over",
            "url":"https:\/\/www.bqprime.com\/business\/wartime-world-trade-fragmentation-thrice-over",
            "source":"Bloomberg | Latest And Live Business",
            "image":null,
            "category":"business",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T18:49:56+00:00"
        },
        {
            "author":"Bryce Grafton",
            "title":"\u0022Respectfully, I hope a razor scooter nails you in the shin today\u0022 - Cincinnati Reds pitcher has a savage response to Twitter hater",
            "description":"\u0022Respectfully, I hope a razor scooter nails you in the shin today\u0022 - Cincinnati Reds pitcher has a savage response to Twitter hater",
            "url":"https:\/\/www.sportskeeda.com\/baseball\/news-respectfully-i-hope-razor-scooter-nails-shin-today-cincinnati-reds-pitcher-savage-response-twitter-hater?utm_source=feed\u0026utm_medium=referral\u0026utm_campaign=sportskeeda",
            "source":"Sportskeeda",
            "image":"https:\/\/static.sportskeeda.com\/editor\/2022\/05\/92a0e-16517762635801-1920.jpg",
            "category":"sports",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:10:20+00:00"
        },
        {
            "author":"Balakrishna",
            "title":"SRH vs DC memes, IPL 2022: Top 10 funny memes from the latest match",
            "description":"SRH vs DC memes, IPL 2022: Top 10 funny memes from the latest match",
            "url":"https:\/\/www.sportskeeda.com\/cricket\/news-srh-vs-dc-memes-ipl-2022-top-10-funny-memes-latest-match?utm_source=feed\u0026utm_medium=referral\u0026utm_campaign=sportskeeda",
            "source":"Sportskeeda",
            "image":"https:\/\/static.sportskeeda.com\/editor\/2022\/05\/4322c-16517752325181-1920.jpg",
            "category":"sports",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:10:20+00:00"
        },
        {
            "author":"Rudransh Khurana",
            "title":"IPL 2022: [Watch] Khaleel Ahmed gets smacked on the chest by Nicholas Pooran\u0027s rocket shot",
            "description":"IPL 2022: [Watch] Khaleel Ahmed gets smacked on the chest by Nicholas Pooran\u0027s rocket shot",
            "url":"https:\/\/www.sportskeeda.com\/cricket\/news-ipl-2022-watch-khaleel-ahmed-gets-smacked-chest-nicholas-pooran-s-rocket-shot?utm_source=feed\u0026utm_medium=referral\u0026utm_campaign=sportskeeda",
            "source":"Sportskeeda",
            "image":"https:\/\/static.sportskeeda.com\/editor\/2022\/05\/34744-16517728902916-1920.jpg",
            "category":"sports",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:10:20+00:00"
        },
        {
            "author":"Akhil Khatri",
            "title":"\u0022I\u2019d pay any amount of money to give Skip a 10-foot head start and let me do this to him\u0022 - Former NBA champion mocks Skip Bayless for suggesting Dillon Brooks\u0027 foul was soft",
            "description":"\u0022I\u2019d pay any amount of money to give Skip a 10-foot head start and let me do this to him\u0022 - Former NBA champion mocks Skip Bayless for suggesting Dillon Brooks\u0027 foul was soft",
            "url":"https:\/\/www.sportskeeda.com\/basketball\/news-former-nba-champion-mocks-bayless-comments-dillon-brooks-foul?utm_source=feed\u0026utm_medium=referral\u0026utm_campaign=sportskeeda",
            "source":"Sportskeeda",
            "image":"https:\/\/static.sportskeeda.com\/editor\/2022\/05\/dde56-16517707760169-1920.jpg",
            "category":"sports",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:10:20+00:00"
        },
        {
            "author":"Letters to the Editor",
            "title":"As a society, we should move away from student loans and provide free college",
            "description":"The campus of the University of Illinois Chicago in 2020.Pat Nabong\/Sun-Times Regarding student loans: In the past, a high school diploma was sufficient, and one could advance in society and find a meaningful career with one. Thanks to taxpayers, a high school education has been free and accessible to everyone. Nowadays, a high school diploma doesn\u2019t have the weight it once had, and so a bachelor\u2019s degree or more is becoming necessary for one to advance in society and find a meaningful career. Maybe we should consider expanding that free high school education to free college education, so...",
            "url":"https:\/\/chicago.suntimes.com\/2022\/5\/5\/23057044\/student-loans-free-college-careers-reproductive-rights-federal-legislation-mental-health-letters",
            "source":"suntimes",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:08:29+00:00"
        },
        {
            "author":null,
            "title":"New shape memory alloy discovered through artificial intelligence framework",
            "description":"Researchers from the Department of Materials Science and Engineering at Texas A\u0026M University have used an Artificial Intelligence Materials Selection framework (AIMS) to discover a new shape memory alloy. The shape memory alloy showed the highest efficiency during operation achieved thus far for nickel-titanium-based materials. In addition, their data-driven framework offers proof of concept for future materials development.\u00a0",
            "url":"https:\/\/phys.org\/news\/2022-05-memory-alloy-artificial-intelligence-framework.html",
            "source":"Phys.org - News And Articles On Science And Technology",
            "image":"https:\/\/scx1.b-cdn.net\/csz\/news\/tmb\/2022\/new-shape-memory-alloy-1.jpg",
            "category":"science",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:08:39+00:00"
        },
        {
            "author":"Alex Simon",
            "title":"Grizzlies\u2019 Brooks suspended for Game 3; Warriors\u2019 Green fined for double-bird gesture",
            "description":"Brooks\u0027 foul of Payton II injured the guard, who will miss at least two weeks.",
            "url":"https:\/\/www.dailydemocrat.com\/2022\/05\/05\/grizzlies-brooks-suspended-for-game-3-warriors-green-fined-for-double-bird-gesture\/",
            "source":"dailydemocrat",
            "image":"https:\/\/www.dailydemocrat.com\/wp-content\/uploads\/2022\/05\/BNG-L-WARRIORS-0502-53-2.jpg?w=1400px\u0026strip=all",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:05:10+00:00"
        },
        {
            "author":"Dan Weil",
            "title":"Dividend Stocks Outperform. Here\u0027s 2 Funds Investors Might Consider.",
            "description":"While the S\u0026P 500 index has dropped 13% this year, the S\u0026P 500 Dividend Aristocrats index has slipped only 6%.",
            "url":"https:\/\/www.thestreet.com\/investing\/dividend-funds-morningstar-top-rated",
            "source":"thestreet",
            "image":"http:\/\/www.thestreet.com\/.image\/c_limit%2Ccs_srgb%2Cfl_progressive%2Ch_1200%2Cq_auto:good%2Cw_1200\/MTgxNzM1NjE4OTA3MjE5MTEw\/dividends_3.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:10:06+00:00"
        },
        {
            "author":"Blair Marnell",
            "title":"History remembers names in new House of the Dragon trailer",
            "description":"In the age of dragons, the Targaryen family goes to war over the Iron Throne in the new trailer for the Game of Thrones spinoff, House of the Dragon.",
            "url":"https:\/\/www.digitaltrends.com\/movies\/house-of-the-dragon-hbo-max-teaser-trailer\/",
            "source":"digitaltrends",
            "image":"https:\/\/icdn.digitaltrends.com\/image\/digitaltrends\/house-of-the-dragon-history-teaser-440x292-c.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:10:02+00:00"
        },
        {
            "author":null,
            "title":"BCE announces election of Directors",
            "description":"(marketscreener.com) MONTR\u0026Eacute;AL, May 5, 2022 \/PRNewswire\/ - BCE Inc. today announced that shareholders voted in favour of all items of business put forth by BCE at the company\u0027s Annual Meeting of Shareholders today, including the election of the Directors by a majority of the votes cast by shareholders present or represented by proxy:NomineeVotes For%...https:\/\/www.marketscreener.com\/quote\/stock\/BCE-INC-1409161\/news\/BCE-announces-election-of-Directors-40287414\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/BCE-INC-1409161\/news\/BCE-announces-election-of-Directors-40287414\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:09:03+00:00"
        },
        {
            "author":"dc correspondent",
            "title":"Free treatment to all types of cancers in AP, says CM",
            "description":"State government\u0027s ultimate goal is that no single patient shall die of cancer or rush to neighbouring states for treatment, says CM",
            "url":"https:\/\/www.deccanchronicle.com\/nation\/current-affairs\/060522\/free-treatment-to-all-types-of-cancers-in-ap-says-cm.html",
            "source":"deccanchronicle",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:01:23+00:00"
        },
        {
            "author":"Erica Bivens",
            "title":"Ky Sec. of State announces more than 30,000 voters have requested absentee ballots",
            "description":"The receipt deadline to count an absentee ballot is May 17 by 6 p.m.",
            "url":"https:\/\/www.wtvq.com\/ky-sec-of-state-announces-more-than-30000-voters-have-requested-absentee-ballots\/",
            "source":"wtvq",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:08:30+00:00"
        },
        {
            "author":"Oak Ridge National Laboratory",
            "title":"Supercomputing, Neutrons Crack Code to Uranium Compound\u0027s Signature Vibes",
            "description":"Oak Ridge National Laboratory researchers used the nation\u0027s fastest supercomputer to map the molecular vibrations of an important but little-studied uranium compound produced during the nuclear fuel cycle for results that could lead to a cleaner, safer world.",
            "url":"http:\/\/www.newswise.com\/articles\/view\/770440\/?sc=rsla",
            "source":"newswise",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:20:46+00:00"
        },
        {
            "author":"Oregon Health \u0026 Science University",
            "title":"New study reveals the effect of extended space flight on astronauts\u0027 brains",
            "description":"Long-duration space flight alters fluid-filled spaces along veins and arteries in the brain, according to new research from Oregon Health \u0026 Science University and scientists across the country.",
            "url":"http:\/\/www.newswise.com\/articles\/view\/770433\/?sc=rsla",
            "source":"newswise",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:20:46+00:00"
        },
        {
            "author":"University of California, Irvine",
            "title":"UCI Researchers Reveal Possible Molecular Blood Signature for Suicide in Major Depression",
            "description":"A University of California, Irvine-led team of researchers, along with members of the Pritzker Research Consortium, have developed an approach to identify blood biomarkers that could predict the suicide risk of major depressive disorder (MDD) patients.",
            "url":"http:\/\/www.newswise.com\/articles\/view\/770430\/?sc=rsla",
            "source":"newswise",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:15:47+00:00"
        },
        {
            "author":null,
            "title":"Mission Complete: Miniature tug pulls MSC\u2019s massive surge sealift ship to final destination [Image 5 of 5]",
            "description":"NEWPORT NEWS, Va. (April 2, 2022) Signet Warhorse II towed Military Sealift Command\u0027s Large, Medium-Speed, Roll-on\/Roll-off (LMSR) ship USNS Yano (T-AKR 297) from Newport News Marine Terminal in Newport News, Va., to the Maritime Administration Reserve Fleet in Beaumont, Texas, where the vessel will permanently join MARAD\u2019s Ready Reserve Force (RRF). The 16-day tow completed on April 18.",
            "url":"https:\/\/www.dvidshub.net\/image\/7177133\/mission-complete-miniature-tug-pulls-mscs-massive-surge-sealift-ship-final-destination",
            "source":"dvidshub",
            "image":"https:\/\/cdn.dvidshub.net\/media\/thumbs\/photos\/2205\/7177133\/250x153_q75.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:15:55+00:00"
        },
        {
            "author":"LaShawn Sykes",
            "title":"Mission Complete: Miniature tug pulls MSC\u2019s massive surge sealift ship to final destination [Image 4 of 5]",
            "description":"NEWPORT NEWS, Va. (April 2, 2022) Signet Warhorse II towed Military Sealift Command\u0027s Large, Medium-Speed, Roll-on\/Roll-off (LMSR) ship USNS Yano (T-AKR 297) from Newport News Marine Terminal in Newport News, Va., to the Maritime Administration Reserve Fleet in Beaumont, Texas, where the vessel will permanently join MARAD\u2019s Ready Reserve Force (RRF). The 16-day tow completed on April 18.",
            "url":"https:\/\/www.dvidshub.net\/image\/7177131\/mission-complete-miniature-tug-pulls-mscs-massive-surge-sealift-ship-final-destination",
            "source":"dvidshub",
            "image":"https:\/\/cdn.dvidshub.net\/media\/thumbs\/photos\/2205\/7177131\/250x188_q75.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:17:18+00:00"
        },
        {
            "author":null,
            "title":"Mission Complete: Miniature tug pulls MSC\u2019s massive surge sealift ship to final destination [Image 1 of 5]",
            "description":"NEWPORT NEWS, Va. (April 2, 2022) Signet Warhorse II towed Military Sealift Command\u0027s Large, Medium-Speed, Roll-on\/Roll-off (LMSR) ship USNS Yano (T-AKR 297) from Newport News Marine Terminal in Newport News, Va., to the Maritime Administration Reserve Fleet in Beaumont, Texas, where the vessel will permanently join MARAD\u2019s Ready Reserve Force (RRF). The 16-day tow completed on April 18.",
            "url":"https:\/\/www.dvidshub.net\/image\/7177125\/mission-complete-miniature-tug-pulls-mscs-massive-surge-sealift-ship-final-destination",
            "source":"dvidshub",
            "image":"https:\/\/cdn.dvidshub.net\/media\/thumbs\/photos\/2205\/7177125\/250x138_q75.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:16:48+00:00"
        },
        {
            "author":"Jongrim Ha, M. Ayhan Kose, Franziska Ohnsorge",
            "title":"Coping with high inflation and borrowing costs in emerging market and developing economies",
            "description":"As the old adage goes, all good things come to an end. Gone are the days of low inflation and easy global financial conditions. Many emerging market and developing economies (EMDEs) have recently been experiencing an unpleasant combination of elevated inflation and rising borrowing costs. At 8.5 percent in March 2022, inflation in EMDEs has\u0026hellip;",
            "url":"https:\/\/www.brookings.edu\/blog\/future-development\/2022\/05\/05\/coping-with-high-inflation-and-borrowing-costs-in-emerging-market-and-developing-economies\/",
            "source":"brookings",
            "image":"https:\/\/www.brookings.edu\/wp-content\/uploads\/2022\/05\/shutterstock_82131970.jpg?w=273",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:16:21+00:00"
        },
        {
            "author":"Reuters",
            "title":"Dollar index hits 20-year high, sterling tumbles on dovish BoE",
            "description":"NEW YORK \u0026#8212; The dollar hit a 20-year high against a basket of currencies on Thursday as a sharp stocks selloff boosted demand for the safe-haven currency and as the Federal Reserve was seen as tightening monetary policy more than peers. Stocks tumbled on Thursday as investors fretted the Fed might need to take more [\u0026#8230;]",
            "url":"https:\/\/financialpost.com\/pmn\/business-pmn\/dollar-index-hits-20-year-high-sterling-tumbles-on-dovish-boe",
            "source":"business",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:18:22+00:00"
        },
        {
            "author":null,
            "title":"Green Energy Group (Seabird Exploration Plc): Prospectus approval",
            "description":"(marketscreener.com) NOT FOR RELEASE, PUBLICATION OR DISTRIBUTION, IN WHOLE OR IN PART, DIRECTLY OR INDIRECTLY, IN AUSTRALIA, CANADA, JAPAN OR THE UNITED STATES OR ANY OTHER JURISDICTION IN WHICH THE RELEASE, PUBLICATION OR DISTRIBUTION WOULD BE UNLAWFUL. Green Energy Group : Prospectus approval Reference is made to the stock exchange release from Green Energy Group...https:\/\/www.marketscreener.com\/quote\/stock\/SEABIRD-EXPLORATION-PLC-1413266\/news\/Green-Energy-Group-Seabird-Exploration-Plc-Prospectus-approval-40287429\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/SEABIRD-EXPLORATION-PLC-1413266\/news\/Green-Energy-Group-Seabird-Exploration-Plc-Prospectus-approval-40287429\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:16:02+00:00"
        },
        {
            "author":"Jennifer Iyer",
            "title":"Great Y Circus is back in Redlands after pandemic tightrope",
            "description":"Organizers say the show is one of the oldest community circuses in the country, perhaps the world.",
            "url":"https:\/\/www.sbsun.com\/2022\/05\/05\/great-y-circus-is-back-in-redlands-after-pandemic-tightrope\/",
            "source":"sbsun",
            "image":"https:\/\/www.sbsun.com\/wp-content\/uploads\/2022\/05\/RDF-L-YCIRCUS-0505-03TP.jpg?w=1400px\u0026strip=all",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:17:52+00:00"
        },
        {
            "author":"Record Staff",
            "title":"International Workers\u2019 Day Is Celebrated in Chelsea",
            "description":"By Roberto Jimenez Rivera Candidate for State Representative Workers are the backbone of our community. During my time on the School Committee and working as a community organizer, I have been advocating for stronger worker protections and more opportunities for\u0026#8230;Read more \u0026#8594;",
            "url":"http:\/\/chelsearecord.com\/2022\/05\/05\/international-workers-day-is-celebrated-in-chelsea\/",
            "source":"chelsearecord",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:18:21+00:00"
        },
        {
            "author":"Bluehorseshoe",
            "title":"Phil Mickelson lost $40 million gambling.",
            "description":"Phil Mickelson had gambling losses totaling $40 million between 2010 and 2014, according to a new biography of the golf superstar. Alan Shipnuck, author of the forthcoming book \u0022Phil: The Rip-Roaring (and Unauthorized!) Biography of Golf\u0027s Most Colorful Superstar,\u0022 published an excerpt on the...",
            "url":"https:\/\/www.sportsbookreview.com\/forum\/players-talk\/3698538-phil-mickelson-lost-40-million-gambling.html",
            "source":"sbrforum",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:20:06+00:00"
        },
        {
            "author":"City News Service",
            "title":"No felony charges for Dave Chappelle\u2019s attacker, DA says",
            "description":"Los Angeles County prosecutors declined Thursday to pursue any felony charges against a man who rushed the stage at the Hollywood Bowl on Tuesday night and tackled comedian Dave Chappelle while armed with a replica gun that contained a switchblade.",
            "url":"https:\/\/www.presstelegram.com\/2022\/05\/05\/no-felony-charges-for-dave-chappelles-attacker-da-says\/",
            "source":"Press-Telegram",
            "image":"https:\/\/www.presstelegram.com\/wp-content\/uploads\/2022\/05\/LDN-L-NETFLIXFEST-0422-CHAPPELLE-1.jpg?w=1400px\u0026strip=all",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:31:00+00:00"
        },
        {
            "author":"Elliott Teaford",
            "title":"Ducks sign goalie prospect Calle Clang to 3-year, entry-level contract",
            "description":"He was 10-5-0 with a 2.28 goals-against average, a .915 save percentage and one shutout in 17 games with Rogle of the Swedish Hockey League this past season.",
            "url":"https:\/\/www.sgvtribune.com\/2022\/05\/05\/ducks-sign-goalie-prospect-calle-clang-to-3-year-entry-level-contract\/",
            "source":"sgvtribune",
            "image":"https:\/\/www.sgvtribune.com\/wp-content\/uploads\/2022\/05\/ducks-button.jpg?w=1400px\u0026strip=all",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:31:23+00:00"
        },
        {
            "author":"Airman 1st Class Trenton Jancze",
            "title":"97 AMW Airmen launch, protect 33 aircraft during severe weather flyaway [Image 7 of 9]",
            "description":"U.S. Air Force Maj. Kevin Bishop, 54th Air Refueling Squadron KC-135 Stratotanker instructor pilot, performs an external inspection of a KC-135 on the flight line during a severe weather flyaway at Altus Air Force Base, Oklahoma, May 4, 2022. Weather predictions forecasted a 50-percent chance of 1.5-inch hail and wind up to 60 knots which could result in extensive damage to the aircraft. (U.S. Air Force photo by Airman 1st Class Trenton Jancze)",
            "url":"https:\/\/www.dvidshub.net\/image\/7177202\/97-amw-airmen-launch-protect-33-aircraft-during-severe-weather-flyaway",
            "source":"dvidshub",
            "image":"https:\/\/cdn.dvidshub.net\/media\/thumbs\/photos\/2205\/7177202\/250x167_q75.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:34:39+00:00"
        },
        {
            "author":"Airman 1st Class Trenton Jancze",
            "title":"97 AMW Airmen launch, protect 33 aircraft during severe weather flyaway [Image 5 of 9]",
            "description":"U.S. Air Force Tech. Sgt. Alex Green, 58th Airlift Squadron instructor loadmaster, waits for a C-17 Globemaster III\u2019s engine to start during a severe weather flyaway at Altus Air Force Base, Oklahoma, May 4, 2022. All aircraft returned the next day to continue the base\u2019s mission: \u201ctraining exceptional mobility Airmen\u201d. (U.S. Air Force photo by Airman 1st Class Trenton Jancze)",
            "url":"https:\/\/www.dvidshub.net\/image\/7177200\/97-amw-airmen-launch-protect-33-aircraft-during-severe-weather-flyaway",
            "source":"dvidshub",
            "image":"https:\/\/cdn.dvidshub.net\/media\/thumbs\/photos\/2205\/7177200\/250x167_q75.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:34:34+00:00"
        },
        {
            "author":"Senior Airman Kayla Christenson",
            "title":"97 AMW Airmen launch, protect 33 aircraft during severe weather flyaway [Image 3 of 9]",
            "description":"A KC-135 Stratotanker takes off due to an incoming severe weather forecast at Altus Air Force Base (AAFB), Oklahoma, May 4, 2022. Despite the severe weather flyaway, the 97th Operations Group was able to continue student training, fulfilling the 97th Air Mobility Wing\u2019s vision to \u201cforge the world\u2019s most inspired, proficient and adaptive mobility warriors to deliver airpower for America.\u201d (U.S. Air Force photo by Senior Airman Kayla Christenson)",
            "url":"https:\/\/www.dvidshub.net\/image\/7177198\/97-amw-airmen-launch-protect-33-aircraft-during-severe-weather-flyaway",
            "source":"dvidshub",
            "image":"https:\/\/cdn.dvidshub.net\/media\/thumbs\/photos\/2205\/7177198\/250x166_q75.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:34:27+00:00"
        },
        {
            "author":null,
            "title":"UPDATE: RENREN, INC. DERIVATIVE LITIGATION SETTLEMENT WEBSITE UPDATED",
            "description":"(marketscreener.com) NEW YORK, May 5, 2022 \/PRNewswire\/ -- The law firms Reid Collins \u0026amp; Tsai LLP, Grant \u0026amp; Eisenhofer P.A., and Gardy \u0026amp; Notis, LLP, as Plaintiffs\u0027 Lead Counsel in In re Renren, Inc. Derivative Litigation, Index No. 653594\/2018 , announce that the Renren, Inc. \u0026nbsp;derivative settlement website has been updated to provide important new...https:\/\/www.marketscreener.com\/quote\/stock\/RENREN-INC-33950997\/news\/UPDATE-RENREN-INC-DERIVATIVE-LITIGATION-SETTLEMENT-WEBSITE-UPDATED-40287490\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/RENREN-INC-33950997\/news\/UPDATE-RENREN-INC-DERIVATIVE-LITIGATION-SETTLEMENT-WEBSITE-UPDATED-40287490\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:33:03+00:00"
        },
        {
            "author":null,
            "title":"Fed fingers crossed for 1994 re-run as hiking path shortens: McGeever",
            "description":"(marketscreener.com) The parallels between theFederal Reserve\u0027s interest rate hikes of 1994-95 and the cyclenow underway are becoming clearer, and policymakers are hopingfor a similar outcome: no recession. Fed Chair Jerome Powell signaled on Wednesday that he andhis colleagues want to get as much tightening done in as short aperiod as the strong...https:\/\/www.marketscreener.com\/news\/latest\/Fed-fingers-crossed-for-1994-re-run-as-hiking-path-shortens-McGeever--40287491\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/news\/latest\/Fed-fingers-crossed-for-1994-re-run-as-hiking-path-shortens-McGeever--40287491\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:32:34+00:00"
        },
        {
            "author":null,
            "title":"The Scary Replica Handgun with a Knife Used in Dave Chappelle Attack (Pics)",
            "description":"UPDATE: The L.A. Times reports Los Angeles County Dist. Atty. George Gasc\u00f3n\u2019s office will not be filing felony charges against Isaiah Lee. The case has now been referred to the L.A. city attorney\u2019s office for a possible misdemeanor filing. Dave Chappelle was tackled onstage Tuesday night, and now the Los Angeles Police Department has released photos of the attacker\u2019s gun-like knife. The incident took place during \u201cNetflix Is a Joke Presents: Dave Chappelle and Friends\u201d at the Hollywood Bowl, when a man in a black hoodie rushed the stage and tackled Chappelle to the ground just as he...",
            "url":"https:\/\/extratv.com\/2022\/05\/05\/the-scary-replica-handgun-with-a-knife-used-in-dave-chappelle-attack-pics\/",
            "source":"extratv",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:33:07+00:00"
        },
        {
            "author":"Will Lavin",
            "title":"Rag \u2018N\u2019 Bone Man, IDLES, Portishead and more feature in \u2018Man Down\u2019 mental health film",
            "description":"The film\u00a0focuses on men working in the music industry and looks at topics such as isolation, depression and suicideThe post Rag \u2018N\u2019 Bone Man, IDLES, Portishead and more feature in \u0026#8216;Man Down\u0026#8217; mental health film appeared first on NME.",
            "url":"https:\/\/www.nme.com\/news\/music\/rag-n-bone-man-idles-portishead-man-down-mental-health-film-3219437?utm_source=rss\u0026utm_medium=rss\u0026utm_campaign=rag-n-bone-man-idles-portishead-man-down-mental-health-film",
            "source":"nme",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:32:24+00:00"
        },
        {
            "author":"Ian Walker",
            "title":"Genshin Impact Makes Its Devs One-Quarter Of A Bethesda Every Year",
            "description":"Genshin Impact raked in over $3 billion from mobile players in less than two years, according to the latest report from analytics firm Sensor Tower.Read more...",
            "url":"https:\/\/kotaku.com\/genshin-impact-mihoyo-mobile-ios-android-earnings-pokem-1848887015",
            "source":"kotaku",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:35:00+00:00"
        },
        {
            "author":null,
            "title":"At least three killed in suspected terror attack in Israel",
            "description":"At least three people were killed and four injured in a suspected terror attack in the central Israeli city of Elad, according to Israel\u0027s emergency response services.",
            "url":"https:\/\/www.cnn.com\/2022\/05\/05\/middleeast\/israel-terror-attack-elad-intl\/index.html",
            "source":"CNN Middle East",
            "image":"https:\/\/cdn.cnn.com\/cnnnext\/dam\/assets\/220505142942-01-elad-israel-terror-attack-intl-super-169.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:35:11+00:00"
        },
        {
            "author":"Connie Kim",
            "title":"Amazon commits $10.6M to affordable housing in Nashville",
            "description":"Amazon is committing $10.6 million to build and renovate 130 affordable homes in Nashville, Tennessee.The post Amazon commits $10.6M to affordable housing in Nashville appeared first on HousingWire.",
            "url":"https:\/\/www.housingwire.com\/articles\/amazon-commits-10-6m-to-affordable-housing-in-nashville\/",
            "source":"housingwire",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:35:22+00:00"
        },
        {
            "author":null,
            "title":"Israel\u2019s PM says Putin has apologised for Lavrov\u2019s Hitler remarks",
            "description":"Bennett thanked Putin for clarifying his attitude towards the Jewish people and the memory of the Holocaust.",
            "url":"https:\/\/www.aljazeera.com\/news\/2022\/5\/5\/israel-says-putin-apologised-over-his-fms-holocaust-remarks",
            "source":"Al Jazeera English",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:30:35+00:00"
        },
        {
            "author":"msmash",
            "title":"On Deck Cuts 25% Staff, MainStreet 30%, and Cameo Removes 87 Positions Including CTO and CPO",
            "description":"Cameo, the celebrity video greetings startup, laid off 87 of staffers Wednesday, a move that CEO Steven Galanis described as \u0022right-sizing.\u0022 From a report: The layoffs also affected some of Cameo\u0027s most senior executives, Protocol has learned. Leadership departures included Cameo CTO Rob Post, top marketing executive Emily Boschwitz, CPO Nundu Janakiram and Chief People Officer Melanie Steinbach, according to a source close to the company. The team in charge of music partnerships saw big cuts, according to a LinkedIn post. Also affected by the layoffs were the company\u0027s international operations...",
            "url":"https:\/\/tech.slashdot.org\/story\/22\/05\/05\/1934210\/on-deck-cuts-25-staff-mainstreet-30-and-cameo-removes-87-positions-including-cto-and-cpo?utm_source=rss1.0mainlinkanon\u0026utm_medium=feed",
            "source":"slashdot",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:00:00+00:00"
        },
        {
            "author":"Tribune News Service",
            "title":"Orioles say sharing concert profits with state is a disincentive to hosting acts like Paul McCartney, Billy Joel",
            "description":"If Camden Yards is to host more concerts like the upcoming Paul McCartney show or the Billy Joel performance from 2019, the Orioles do not want to share the profits with the state. If the authority opts in to an event, it receives 45% of the revenue while the Orioles receive 55%. However, for the June 12 show featuring music legend McCartney, the Orioles asked the MSA...",
            "url":"https:\/\/www.ocregister.com\/2022\/05\/05\/orioles-say-sharing-concert-profits-with-state-is-a-disincentive-to-hosting-acts-like-paul-mccartney-billy-joel\/",
            "source":"ocregister",
            "image":"https:\/\/www.ocregister.com\/wp-content\/uploads\/2022\/05\/202205041518TMS_____MNGTRPUB_SPORTS-ORIOLES-SAY-SHARING-CONCERT-PROFITS-WITH-1-BZ5.jpg?w=1400px\u0026strip=all",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:02:57+00:00"
        },
        {
            "author":"Staff Sgt. Jackie Sanders",
            "title":"\u202fNorthcom, Stratcom Top Leaders Hold Press Conference [Image 1 of 3]",
            "description":"U.S. Air Force Gen. Glen D. VanHerck, the commander of U.S. Northern Command and North American Aerospace Defense Command, and Navy Adm. Charles \u201cChas\u201d A. Richard, the commander of U.S. Strategic Command, hold a virtual press conference from the Pentagon, Washington, D.C., May 5, 2022. (DoD photo by U.S. Air Force Tech. Sgt. Jack Sanders)",
            "url":"https:\/\/www.dvidshub.net\/image\/7177296\/northcom-stratcom-top-leaders-hold-press-conference",
            "source":"dvidshub",
            "image":"https:\/\/cdn.dvidshub.net\/media\/thumbs\/photos\/2205\/7177296\/250x167_q75.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:56:39+00:00"
        },
        {
            "author":"Katie McKellar",
            "title":"Homes now 55% more expensive than a year ago due to rising mortgage rates",
            "description":"A \u201cfor sale\u201d sign is pictured at a home in Cottonwood Heights on April 15, 2022. The booming housing market has largely contributed to the U.S.\u2019s economic comeback from COVID-19, but today the market is facing a cloud of uncertainty, the National Association of Realtors\u2019 chief economist says. Jeffrey D. Allred, Deseret News The booming housing market has largely contributed to the U.S.\u2019s economic comeback from COVID-19, but today the market is facing a cloud of uncertainty, the National Association of Realtors\u2019 chief economist says. \u201cHousing kept the economy afloat as home prices...",
            "url":"https:\/\/www.deseret.com\/utah\/2022\/5\/5\/23058598\/housing-market-prices-predictions-uncertainty-expensive-mortgage-rates-federal-reserve-interest",
            "source":"deseretnews",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:55:48+00:00"
        },
        {
            "author":null,
            "title":"ARK INNOVATION FUND FALLS 9.5%, 3RD LARGEST DROP IN ITS HISTORY,\u0026#8230;",
            "description":"(marketscreener.com) ARK INNOVATION FUND FALLS 9.5%, 3RD LARGEST DROP IN ITS HISTORY, DURING MARKET SELLOFF https:\/\/www.marketscreener.com\/news\/latest\/ARK-INNOVATION-FUND-FALLS-9-5-3RD-LARGEST-DROP-IN-ITS-HISTORY-8230--40287579\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/news\/latest\/ARK-INNOVATION-FUND-FALLS-9-5-3RD-LARGEST-DROP-IN-ITS-HISTORY-8230--40287579\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T19:58:36+00:00"
        },
        {
            "author":null,
            "title":"Cantaloupe, Inc. Reports Third Quarter 2022 Financial Results, Which Includes Record Transaction Fee Revenue",
            "description":"(marketscreener.com) Cantaloupe, Inc. , a leading company in digital payments and software services, that provides end-to-end technology solutions for the convenience retail market, today reported results for the fiscal year 2022 third quarter ended March 31, 2022.\u0026ldquo;We are pleased to report another strong quarter, with 18% growth in revenue, primarily driven...https:\/\/www.marketscreener.com\/quote\/stock\/CANTALOUPE-INC-46310\/news\/Cantaloupe-Inc-Reports-Third-Quarter-2022-Financial-Results-Which-Includes-Record-Transaction-Fee-40288167\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/CANTALOUPE-INC-46310\/news\/Cantaloupe-Inc-Reports-Third-Quarter-2022-Financial-Results-Which-Includes-Record-Transaction-Fee-40288167\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:15:06+00:00"
        },
        {
            "author":null,
            "title":"NGM Bio Provides Business Highlights and Reports First Quarter 2022 Financial Results",
            "description":"(marketscreener.com) Initiated Phase 1\/1b clinical trial of NGM831, an ILT3 antagonist antibody product candidate, as a monotherapy and in combination with KEYTRUDA\u0026reg; , for the treatment of patients with advanced solid tumorsPresented preclinical research for NGM707, a dual ILT2\/ILT4 antagonist antibody product candidate, NGM831 and NGM438, a LAIR1 antagonist...https:\/\/www.marketscreener.com\/quote\/stock\/NGM-BIOPHARMACEUTICALS-I-56727727\/news\/NGM-Bio-Provides-Business-Highlights-and-Reports-First-Quarter-2022-Financial-Results-40288153\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/NGM-BIOPHARMACEUTICALS-I-56727727\/news\/NGM-Bio-Provides-Business-Highlights-and-Reports-First-Quarter-2022-Financial-Results-40288153\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:15:01+00:00"
        },
        {
            "author":null,
            "title":"American Water Publishes 2021 Inclusion, Diversity \u0026 Equity Report and ESG Data Summary; Launches Interactive ID\u0026E Website",
            "description":"(marketscreener.com) American Water , the largest publicly traded U.S. water and wastewater utility company, announced today that it has published its 2021 Inclusion, Diversity \u0026amp; Equity report and interactive website along with its Environmental, Social and Governance Data Summary as part of the company\u0026rsquo;s commitment to data transparency and sharing timely...https:\/\/www.marketscreener.com\/quote\/stock\/AMERICAN-WATER-WORKS-COMP-2989352\/news\/American-Water-Publishes-2021-Inclusion-Diversity-Equity-Report-and-ESG-Data-Summary-Launches-In-40288087\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/AMERICAN-WATER-WORKS-COMP-2989352\/news\/American-Water-Publishes-2021-Inclusion-Diversity-Equity-Report-and-ESG-Data-Summary-Launches-In-40288087\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:13:01+00:00"
        },
        {
            "author":null,
            "title":"Floor \u0026 Decor Holdings, Inc. Announces First Quarter Fiscal 2022 Financial Results",
            "description":"(marketscreener.com) Net sales increased 31.5% from the first quarter of fiscal 2021 to $1,028.7 million.Comparable store sales increased 14.3% from the first quarter of fiscal 2021.Diluted earnings per share decreased 7.0% to $0.66 from $0.71 in the first quarter of fiscal 2021; Adjusted diluted EPS* decreased 1.5% to $0.67 from $0.68 in the first quarter...https:\/\/www.marketscreener.com\/quote\/stock\/FLOOR-DECOR-HOLDINGS-I-34676171\/news\/Floor-Decor-Holdings-Inc-Announces-First-Quarter-Fiscal-2022-Financial-Results-40288057\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/FLOOR-DECOR-HOLDINGS-I-34676171\/news\/Floor-Decor-Holdings-Inc-Announces-First-Quarter-Fiscal-2022-Financial-Results-40288057\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:12:02+00:00"
        },
        {
            "author":null,
            "title":"DIAMONDROCK ACQUIRES KIMPTON FORT LAUDERDALE BEACH RESORT",
            "description":"(marketscreener.com) SIGNIFICANT VALUE CREATION OPPORTUNITIES IN OPERATIONS \u0026amp; SYNERGIES BETHESDA, Md., May 5, 2022 \/PRNewswire\/ -- DiamondRock Hospitality Company today announced it acquired a fee-simple interest in The Kimpton Fort Lauderdale Beach Resort, a boutique lifestyle beach resort in Fort Lauderdale, Florida, for a total investment of $35.3 million ....https:\/\/www.marketscreener.com\/quote\/stock\/DIAMONDROCK-HOSPITALITY-C-12354\/news\/DIAMONDROCK-ACQUIRES-KIMPTON-FORT-LAUDERDALE-BEACH-RESORT-40288038\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/DIAMONDROCK-HOSPITALITY-C-12354\/news\/DIAMONDROCK-ACQUIRES-KIMPTON-FORT-LAUDERDALE-BEACH-RESORT-40288038\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:11:21+00:00"
        },
        {
            "author":null,
            "title":"Natural Grocers by Vitamin Cottage Announces Second Quarter Fiscal 2022 Results",
            "description":"(marketscreener.com) LAKEWOOD, Colo., May 5, 2022 \/PRNewswire\/ --\u0026nbsp;Natural Grocers by Vitamin Cottage, Inc. today announced results for its second quarter of fiscal 2022 ended March 31, 2022 and raised its outlook for fiscal 2022. Highlights for...https:\/\/www.marketscreener.com\/quote\/stock\/NATURAL-GROCERS-BY-VITAMI-11096377\/news\/Natural-Grocers-by-Vitamin-Cottage-Announces-Second-Quarter-Fiscal-2022-Results-40288035\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/NATURAL-GROCERS-BY-VITAMI-11096377\/news\/Natural-Grocers-by-Vitamin-Cottage-Announces-Second-Quarter-Fiscal-2022-Results-40288035\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:11:16+00:00"
        },
        {
            "author":null,
            "title":"PacBio to Participate in the BofA Securities 2022 Healthcare Conference",
            "description":"(marketscreener.com) MENLO PARK, Calif., May 05, 2022 -- PacBio announced today that it will be participating in the upcoming BofA Securities 2022 Healthcare Conference in Las Vegas, Nevada. PacBio\u0026rsquo;s management is scheduled to present on Thursday, May 12 at 11:20 a.m. Pacific Time \/ 2:20 p.m. Eastern Time. The live webcast can be accessed at the...https:\/\/www.marketscreener.com\/quote\/stock\/PACIFIC-BIOSCIENCES-OF-CA-6797675\/news\/PacBio-to-Participate-in-the-BofA-Securities-2022-Healthcare-Conference-40288022\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/PACIFIC-BIOSCIENCES-OF-CA-6797675\/news\/PacBio-to-Participate-in-the-BofA-Securities-2022-Healthcare-Conference-40288022\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:11:02+00:00"
        },
        {
            "author":null,
            "title":"NHC Announces 3.6% Increase in Common Dividend",
            "description":"(marketscreener.com) National HealthCare Corporation , the nation\u0026rsquo;s oldest publicly traded long-term health care company, announced today that it will pay a quarterly dividend of 57 cents per common share to shareholders of record on June 30, 2022 and payable on August 1, 2022. This represents a 3.6% increase over last quarter\u0026rsquo;s regular common...https:\/\/www.marketscreener.com\/quote\/stock\/NATIONAL-HEALTHCARE-CORPO-15678\/news\/NHC-Announces-3-6-Increase-in-Common-Dividend-40288021\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/NATIONAL-HEALTHCARE-CORPO-15678\/news\/NHC-Announces-3-6-Increase-in-Common-Dividend-40288021\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:11:01+00:00"
        },
        {
            "author":null,
            "title":"Alkami Announces First Quarter 2022 Financial Results",
            "description":"(marketscreener.com) PLANO, Texas, May 05, 2022 -- Alkami Technology, Inc. , a leading cloud-based digital banking solutions provider for U.S. banks and credit unions, today announced results for its first quarter ending March 31, 2022. First Quarter 2022 Financial Highlights GAAP total revenue of $44.8 million, an increase of 35% compared to the year-ago...https:\/\/www.marketscreener.com\/quote\/stock\/ALKAMI-TECHNOLOGY-INC-121300011\/news\/Alkami-Announces-First-Quarter-2022-Financial-Results-40288019\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/ALKAMI-TECHNOLOGY-INC-121300011\/news\/Alkami-Announces-First-Quarter-2022-Financial-Results-40288019\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:11:01+00:00"
        },
        {
            "author":null,
            "title":"Diversey to Present at the Barclays Americas Select Franchise Conference on May 11, 2022",
            "description":"(marketscreener.com) FORT MILL, S.C., May 05, 2022 -- Diversey Holdings, Ltd. a leading provider of hygiene, infection prevention and cleaning solutions, announces that Phil Wieland, Chief Executive Officer, and Todd Herndon, Chief Financial Officer, will participate in a fireside chat at the Barclays Americas Select Franchise Conference on May 11, 2022. The...https:\/\/www.marketscreener.com\/quote\/stock\/DIVERSEY-HOLDINGS-LTD-120405768\/news\/Diversey-to-Present-at-the-Barclays-Americas-Select-Franchise-Conference-on-May-11-2022-40288017\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/DIVERSEY-HOLDINGS-LTD-120405768\/news\/Diversey-to-Present-at-the-Barclays-Americas-Select-Franchise-Conference-on-May-11-2022-40288017\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:11:01+00:00"
        },
        {
            "author":null,
            "title":"CDK Global, Inc. Reports Third Quarter Fiscal 2022 Results",
            "description":"(marketscreener.com) Revenue Growth of 6% Year over Year HOFFMAN ESTATES, Ill., May 05, 2022 -- CDK Global, Inc. today announced financial results for its fiscal 2022 third quarter ended March 31, 2022. Revenue of $459.7 million in the third quarter ended March 31, 2022Revenue growth of 6% year-over-year driven by both core and acquisition related...https:\/\/www.marketscreener.com\/quote\/stock\/CDK-GLOBAL-INC-18052701\/news\/CDK-Global-Inc-Reports-Third-Quarter-Fiscal-2022-Results-40288011\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/CDK-GLOBAL-INC-18052701\/news\/CDK-Global-Inc-Reports-Third-Quarter-Fiscal-2022-Results-40288011\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:11:01+00:00"
        },
        {
            "author":null,
            "title":"Twist Bioscience Reports Second Quarter 2022 Financial Results",
            "description":"(marketscreener.com) -- Record revenue of $48.1M in 2QFY22; Increase of 54% over $31.2M in Fiscal 2021 \u0026ndash;-- Orders Increased 32% in 2QFY22 over Fiscal 2021 to $55.0M --https:\/\/www.marketscreener.com\/quote\/stock\/TWIST-BIOSCIENCE-CORPORAT-46874562\/news\/Twist-Bioscience-Reports-Second-Quarter-2022-Financial-Results-40288010\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/TWIST-BIOSCIENCE-CORPORAT-46874562\/news\/Twist-Bioscience-Reports-Second-Quarter-2022-Financial-Results-40288010\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:11:01+00:00"
        },
        {
            "author":"Edgar Olivares",
            "title":"Comedores al aire libre, fuera de la lista de prioridades en Carmel-by-the-Sea",
            "description":"CARMEL-BY-THE-SEA, Cal. (KMUV) Despu\u00e9s de la reuni\u00f3n del Ayuntmaiento de la Ciudad el martes por la noche, el Consejo de la Ciudad de Carmel vot\u00f3 por unanimidad para no seguir adelante con el esfuerzo para colocar el programa permanente de comedores al aire libre en la lista de proyectos de m\u00e1xima prioridad de la ciudad.The post Comedores al aire libre, fuera de la lista de prioridades en Carmel-by-the-Sea appeared first on KION546.",
            "url":"https:\/\/kion546.com\/t23\/2022\/05\/05\/comedores-al-aire-libre-fuera-de-la-lista-de-prioridades-en-carmel-by-the-sea\/",
            "source":"kionrightnow",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:13:54+00:00"
        },
        {
            "author":"Petty Officer 2nd Class Tyler Zepeda",
            "title":"Awards Ceremony [Image 2 of 5]",
            "description":"Commander Nichols presents Twenty Years of Service recognition to Charles Burton.",
            "url":"https:\/\/www.dvidshub.net\/image\/7177353\/awards-ceremony",
            "source":"dvidshub",
            "image":"https:\/\/cdn.dvidshub.net\/media\/thumbs\/photos\/2205\/7177353\/250x167_q75.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:13:57+00:00"
        },
        {
            "author":null,
            "title":"McIlroy makes strong start to Wells Fargo with three-under 67",
            "description":"Rory McIlroy had a little bit of everything. A water ball off the tee on the fourth, his 13th, which led to a double-bogey; a couple of three-putts; but, mainly, his opening round of the Wells Fargo Championship at TPC Potomac on the outskirts of Washington DC contained many positive elements, among them seven birdies, as the Northern Irishman signed for an opening round of three-under-par 67. Playing for the first time since his runner-up finish in the Masters last month, McIlroy \u2013 who trailed early clubhouse leaders Matthew Wolff, Denny McCarthy, Callum Tarren and Aaron Rai by two, after...",
            "url":"https:\/\/www.irishtimes.com\/sport\/golf\/mcilroy-makes-strong-start-to-wells-fargo-with-three-under-67-1.4870718?localLinksEnabled=false",
            "source":"irishtimes",
            "image":"https:\/\/www.irishtimes.com\/polopoly_fs\/1.4870717.1651781689!\/image\/image.jpg_gen\/derivatives\/landscape_940\/image.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:15:15+00:00"
        },
        {
            "author":"Annie Costabile",
            "title":"Candace Parker finally faces her former team in the Sky\u2019s opener vs. the Sparks",
            "description":"The Sky\u2019s Candace Parker will face her former team, the Los Angeles Sparks, for the first time in Friday night\u2019s season opener. Ashlee Rezin\/Sun-Times Candace Parker sat with Sky head coach\/GM James Wade, Courtney Vandersloot and Allie Quigley after her first day of practice talking about tactics for Friday\u2019s season opener against the Los Angeles Sparks. \u201cWe have to look out for the shot fakes,\u201d she said as they stripped their practice shoes and socks off. Parker\u2019s first game against her former team should have been nearly a year ago when the Sparks came to Wintrust Arena on May 28...",
            "url":"https:\/\/chicago.suntimes.com\/chicago-sky-and-wnba\/2022\/5\/5\/23056740\/candace-parker-sky-sparks-wnba-season-opener",
            "source":"suntimes",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:11:58+00:00"
        },
        {
            "author":"Robin Pittman, Lisa Jacobs",
            "title":"LETTERS to the Editor: Week of May 5",
            "description":"Letters opposing and supporting Manhattan Beach\u0027s Measure A parcel tax",
            "url":"https:\/\/www.dailybreeze.com\/2022\/05\/05\/letters-to-the-editor-week-of-may-5\/",
            "source":"dailybreeze",
            "image":"https:\/\/www.dailybreeze.com\/wp-content\/uploads\/2022\/05\/WeGetLetters.jpg?w=1400px\u0026strip=all",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:11:19+00:00"
        },
        {
            "author":null,
            "title":"Watch Camila Cabello Get Adorned With Flowers\u2014From Hair to Nails\u2014Before the Met Gala 2022",
            "description":"The 25-year-old pop singer gets glammed\u2014and adorned with an excess of flowers\u2014for her second Met Gala.Director: Maya MargolinaDP: Alex GvojicEditor: Dan ScofieldProducer: Tia HillProducer, On-Set: Anneliese KristedjaAssistant Camera: Ryan ShawAudio: Chris BaroneAssociate Producer: Qieara ...",
            "url":"https:\/\/www.onenewspage.com\/video\/20220505\/14655777\/Watch-Camila-Cabello-Get-Adorned-With-Flowers%E2%80%94From-Hair.htm",
            "source":"onenewspage",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:11:14+00:00"
        },
        {
            "author":"Chris Barnewall",
            "title":"\u2018Ms. Pac-Man\u2019 And \u2018The Legend Of Zelda: Ocarina Of Time\u2019 Were Inducted Into The Video Game Hall Of Fame",
            "description":"Getty Image Four games were part of the Hall of Fame\u0027s latest class.",
            "url":"https:\/\/uproxx.com\/edge\/ms-pac-man-zelda-hall-of-fame\/",
            "source":"hitfix",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:17:28+00:00"
        },
        {
            "author":null,
            "title":"Stem GAAP EPS of -$0.15 beats by $0.01, revenue of $41.09M beats by $12.15M",
            "description":"Stem GAAP EPS of -$0.15 beats by $0.01, revenue of $41.09M beats by $12.15M",
            "url":"https:\/\/seekingalpha.com\/news\/3833673-stem-gaap-eps-of-0_15-beats-0_01-revenue-of-41_09m-beats-12_15m?utm_source=feed_news_all\u0026utm_medium=referral",
            "source":"Seeking Alpha",
            "image":null,
            "category":"business",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:13:04+00:00"
        },
        {
            "author":"Staff",
            "title":"Best Instagram Marketing Tips For Businesses 2022",
            "description":"UNITED STATES\u2014If you\u0026#8217;re a business owner, you know that marketing is key to success. And if you want to use Instagram as one of your marketing tools, you\u0026#8217;re in luck! This social media platform is growing more and more popular every day, and it offers unique opportunities for businesses to reach new customers and grow [\u0026#8230;]The post Best Instagram Marketing Tips For Businesses 2022 appeared first on Canyon News.",
            "url":"https:\/\/www.canyon-news.com\/best-instagram-marketing-tips-for-businesses-2022\/157984",
            "source":"canyon-news",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:39:09+00:00"
        },
        {
            "author":null,
            "title":"Kezar Announces Inducement Grants Under NASDAQ Listing Rule 5635(c)(4)",
            "description":"(marketscreener.com) Kezar Life Sciences, Inc., , a clinical-stage biotechnology company discovering and developing breakthrough treatments for immune-mediated and oncologic disorders, today announced that the Compensation Committee of the company\u0026rsquo;s Board of Directors granted two employees nonqualified stock options to purchase an aggregate of 29,000 shares of...https:\/\/www.marketscreener.com\/quote\/stock\/KEZAR-LIFE-SCIENCES-INC-44315919\/news\/Kezar-Announces-Inducement-Grants-Under-NASDAQ-Listing-Rule-5635-c-4-40288887\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/KEZAR-LIFE-SCIENCES-INC-44315919\/news\/Kezar-Announces-Inducement-Grants-Under-NASDAQ-Listing-Rule-5635-c-4-40288887\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:39:02+00:00"
        },
        {
            "author":null,
            "title":"Kimball Electronics Reports Q3 Results With Record Sales and Strong Operating Margin; Company Expects a Strong Pace to Carry Through the Fourth Quarter",
            "description":"(marketscreener.com) Net sales in the third quarter of fiscal 2022 totaled $368.1 million, an all-time quarterly high and up 19% year-over-year.Operating income of $20.3 million or 5.5% of net sales, an 80 basis point improvement compared to the third quarter of fiscal 2021.Net income of $13.6 million, or $0.54 per diluted share, a 30% improvement compared to...https:\/\/www.marketscreener.com\/quote\/stock\/KIMBALL-ELECTRONICS-INC-18407563\/news\/Kimball-Electronics-Reports-Q3-Results-With-Record-Sales-and-Strong-Operating-Margin-Company-Expect-40288868\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/KIMBALL-ELECTRONICS-INC-18407563\/news\/Kimball-Electronics-Reports-Q3-Results-With-Record-Sales-and-Strong-Operating-Margin-Company-Expect-40288868\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:38:01+00:00"
        },
        {
            "author":null,
            "title":"Compass Minerals Reports Fiscal 2022 Second-Quarter Results",
            "description":"(marketscreener.com) Compass Minerals , a leading global provider of essential minerals, today reported fiscal 2022 second-quarter results.Fiscal 2022 Second-Quarter and Recent HighlightsAchieved revenue of $449 million, an increase of 5% year over year; profitability tempered by higher distribution and production costsPlant Nutrition pricing increased year...https:\/\/www.marketscreener.com\/quote\/stock\/COMPASS-MINERALS-INTERNAT-12116\/news\/Compass-Minerals-Reports-Fiscal-2022-Second-Quarter-Results-40288822\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/COMPASS-MINERALS-INTERNAT-12116\/news\/Compass-Minerals-Reports-Fiscal-2022-Second-Quarter-Results-40288822\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:36:01+00:00"
        },
        {
            "author":"Maneuver Support Center of Excellence FFID Doctrine - Publications Branch",
            "title":"Publication - Military Police",
            "description":"The NCO\u0027s March in Army History; Year of the NCO; The Officer and the NCO: Who Does What?; AirLand Battle (Future), Part I; Juvenile Offenders; 40 Years of Challenge; Lineage and Battle Honors, 324th Military Police Battalion; Victims\u0027 Rights in the Military; Criminal Justice System, Part II; Enemy Prisoner of War Operations; K-9 Section Shepherds Depot Security; Rear Tactical Command Post to V Corps Command Post Concept; Team Spirit 89; Fit to Fight 88 (Squad Competition); Basic Principles of Staff Work; How DARE You!; Training the New Military Police Soldier",
            "url":"https:\/\/www.dvidshub.net\/publication\/issues\/63547",
            "source":"dvidshub",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:40:58+00:00"
        },
        {
            "author":null,
            "title":"Pandemic taught us how science feeds into \u2018messier\u2019 political system - Nolan",
            "description":"One of the biggest lessons from the Covid-19 pandemic is how the formal processes of science and medicine feed into the \u201cmuch messier system\u201d of politics and policy. This was the view of Prof Philip Nolan, who chaired the group that modelled the trajectory of the virus for the National Public Health Emergency Team (Nphet) that advised the Government. Speaking to The Irish Times at the launch of Pandemonium: Power, Politics and Ireland\u2019s Pandemic, the new book by Irish Times political reporter Jack Horgan-Jones and Irish Independent political correspondent Hugh O\u2019Connell, Prof Nolan...",
            "url":"https:\/\/www.irishtimes.com\/news\/politics\/pandemic-taught-us-how-science-feeds-into-messier-political-system-nolan-1.4870733?localLinksEnabled=false",
            "source":"irishtimes",
            "image":"https:\/\/www.irishtimes.com\/polopoly_fs\/1.4870732.1651783062!\/image\/image.jpg_gen\/derivatives\/landscape_940\/image.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:37:51+00:00"
        },
        {
            "author":"Sun-Times Wire",
            "title":"Des Plaines man charged after infant son dies of fentanyl poisoning",
            "description":"Sun-Times file A Des Plaines man has been charged after his infant son died from fentanyl poisoning last year, authorities said.Michael Piazza, 40, faces counts of involuntary manslaughter and child endangerment, the Cook County sheriff\u2019s office said. He was ordered held on $300,000 bail Wednesday.Piazza had bought illegal drugs in 2019 and was looking after his 1-month-old son on May 24, 2021 when the boy accidentally ingested them, authorities said.Piazza called 911 and said his son was sleeping in bed with him when he noticed he wasn\u2019t breathing, the sheriff\u2019s office said. Authorities...",
            "url":"https:\/\/chicago.suntimes.com\/crime\/2022\/5\/5\/23059128\/des-plaines-drug-charge-child-michael-piazza",
            "source":"suntimes",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:39:22+00:00"
        },
        {
            "author":"Paul Kasabian",
            "title":"Khris Middleton\u2019s Injury Return Timeline Discussed by Bucks\u2019 HC Mike Budenholzer",
            "description":"Milwaukee Bucks wing Khris Middleton, who is currently out with an\u0026nbsp;MCL...",
            "url":"https:\/\/bleacherreport.com\/articles\/10035054-khris-middletons-injury-return-timeline-discussed-by-bucks-hc-mike-budenholzer",
            "source":"Bleacher Report",
            "image":"https:\/\/media.bleacherreport.com\/image\/upload\/v1651782495\/lksbw7eb90xxdjyx8vei.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:35:44+00:00"
        },
        {
            "author":"Michael Allison",
            "title":"Google I\/O 2022: Latest News, Dates, \u0026 Registration",
            "description":"Google\u0027s I\/O is here again, with this year\u0027s event expected to bring Android 13, a Pixel 6a, and the long-anticipated Pixel Watch. Here\u0027s how to watch!",
            "url":"https:\/\/www.digitaltrends.com\/mobile\/how-to-watch-google-io-2022\/",
            "source":"digitaltrends",
            "image":"https:\/\/icdn.digitaltrends.com\/image\/digitaltrends\/google-hosts-its-annual-i-o-developers-conference-4-440x292-c.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:38:27+00:00"
        },
        {
            "author":"Arianna MacNeill",
            "title":"Cambridge to expand universal income program",
            "description":"\u0022This will be the first of such programs that is able to provide the assistance to every family that is eligible.\u201dThe post Cambridge to expand universal income program appeared first on Boston.com.",
            "url":"https:\/\/www.boston.com\/news\/local-news\/2022\/05\/05\/cambridge-expands-universal-income-program\/",
            "source":"boston",
            "image":"https:\/\/www.boston.com\/wp-content\/themes\/bdc-2020\/images\/tease-defaults\/fallback-tease-image-4x3-medium.png",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:39:07+00:00"
        },
        {
            "author":null,
            "title":"World Wrestling Entertainment GAAP EPS of $0.77 beats by $0.07, revenue of $333.4M beats by $7.7M",
            "description":"World Wrestling Entertainment GAAP EPS of $0.77 beats by $0.07, revenue of $333.4M beats by $7.7M",
            "url":"https:\/\/seekingalpha.com\/news\/3833806-world-wrestling-entertainment-gaap-eps-of-0_77-beats-0_07-revenue-of-333_4m-beats-7_7m?utm_source=feed_news_all\u0026utm_medium=referral",
            "source":"Seeking Alpha",
            "image":null,
            "category":"business",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:38:51+00:00"
        },
        {
            "author":null,
            "title":"\u0027Unretirement\u0027 is becoming a hot new trend in the sizzling U.S. labor market",
            "description":"The level of workers who retired then came back a year later is running around 3.2%, just about where it was before the pandemic.",
            "url":"https:\/\/www.cnbc.com\/2022\/05\/05\/unretirement-is-becoming-a-hot-new-trend-in-the-sizzling-us-labor-market.html",
            "source":"CNBC",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:32:03+00:00"
        },
        {
            "author":"Matt Parks , Staff Reporter",
            "title":"Elon Musk Buys Twitter; Opens Questions on the Site\u2019s Journalistic and Political Future",
            "description":"Elon Musk\u2019s recent purchase of Twitter for $44 billion and pledge to make the social media platform more transparent with goals of protecting free speech will result in several changes in the journalistic and political world.\u00a0The Tesla CEO declared in a Tweet that free speech will \u201cmatch the law.\u201d In a TED conference interview, April 14, Musk stated that he believes all content should remain online unless it clearly violates the law.\u00a0The rebuttal is that Twitter does not fall under the legal jurisdiction because the First Amendment\u2019s protection of speech is aimed against government...",
            "url":"https:\/\/seattlespectator.com\/2022\/05\/05\/elon-musk-buys-twitter-opens-questions-on-the-sites-journalistic-and-political-future\/",
            "source":"su-spectator",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:49:33+00:00"
        },
        {
            "author":"Airman 1st Class Sarah Williams",
            "title":"Goodfellow hosts 2nd annual intelligence Functional Advisory Council and Development Team conference",
            "description":"Brig. Gen. Max Pearson, Intelligence, Surveillance, and Reconnaissance Operations director, led discussions with the Functional Advisory Council and the 14N Development Team, consisting of 36 senior intelligence leaders representing all major commands during a weeklong conference at Goodfellow Air Force Base, Texas, April 11-14.",
            "url":"https:\/\/www.dvidshub.net\/news\/420081\/goodfellow-hosts-2nd-annual-intelligence-functional-advisory-council-and-development-team-conference",
            "source":"dvidshub",
            "image":"https:\/\/cdn.dvidshub.net\/media\/thumbs\/photos\/2205\/7177454\/250x167_q75.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:46:57+00:00"
        },
        {
            "author":"Airman 1st Class Sarah Williams",
            "title":"Goodfellow hosts 2nd annual intelligence Functional Advisory Council and Development Team conference [Image 2 of 2]",
            "description":"Intelligence leaders from the Intelligence Development Team pose for a photo at the Consolidated Learning Center, Goodfellow Air Force Base, Texas, April 14, 2022. The Intelligence DT is a group of senior officers tasked to assign Air Force intelligence officers to their positions. (U.S. Air Force photo by Airman 1st Class Sarah Williams)",
            "url":"https:\/\/www.dvidshub.net\/image\/7177454\/goodfellow-hosts-2nd-annual-intelligence-functional-advisory-council-and-development-team-conference",
            "source":"dvidshub",
            "image":"https:\/\/cdn.dvidshub.net\/media\/thumbs\/photos\/2205\/7177454\/250x167_q75.jpg",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:46:53+00:00"
        },
        {
            "author":"Julie Lane",
            "title":"Temporary power outage caused by tree limb on wires",
            "description":"More than 1,000 Islanders experienced a blackout Monday night after a tree limb fell onto what a PSEG-LI spokesman said were primary wires near 58 North Ferry Road, close to the IGA. Jeremy Walsh said PSEG-LI was notified at 9:30 p.m. and 700 customers saw their power restored within eight minutes. Another 367 customers got...The post Temporary power outage caused by tree limb on wires appeared first on Shelter Island Reporter.",
            "url":"https:\/\/shelterislandreporter.timesreview.com\/2022\/05\/05\/temporary-power-outage-caused-by-tree-limb-on-wires\/",
            "source":"shelterislandreporter",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:48:03+00:00"
        },
        {
            "author":"John Devine",
            "title":"Pro soccer: Monterey Bay FC set for long awaited home opener",
            "description":"Monterey Bay FC\u0027s long-anticipated home opener is set for Saturday at 7 p.m. at renovated Cardinale Stadium on the campus of CSU Monterey Bay.",
            "url":"https:\/\/www.montereyherald.com\/2022\/05\/05\/pro-soccer-monterey-bay-fc-set-for-long-awaited-home-opener\/",
            "source":"montereyherald",
            "image":"https:\/\/www.montereyherald.com\/wp-content\/uploads\/2022\/05\/20220415_151406_1.jpg?w=1400px\u0026strip=all",
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:48:16+00:00"
        },
        {
            "author":"Elle Gellrich",
            "title":"How To Choose The Right Airpods pro",
            "description":"The AirPods have become one of the most awaited product launches in recent years. The wireless headphones have made their way to the masses, and users have been making a mad dash to get their hands on them. With their light, compact profile, the AirPods make the perfect companion for when you\u0026#8217;re on the go. ... Read more",
            "url":"https:\/\/www.elist10.com\/how-to-choose-the-right-airpods-pro\/",
            "source":"sojones",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:46:48+00:00"
        },
        {
            "author":"Geoff Lee",
            "title":"Diabetics to browse Legacy Centre",
            "description":"File Photo \u0026#160; The Lloydminster Lions Club, along with Saskatchewan Health Authority and Primary Care...The post Diabetics to browse Legacy Centre first appeared on Meridian Source.",
            "url":"http:\/\/www.meridiansource.ca\/diabetics-to-browse-legacy-centre\/",
            "source":"meridianbooster",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:48:46+00:00"
        },
        {
            "author":"rosemaryfeitelberg",
            "title":"Tommy Hilfiger and Dee Ocleppo Talk Work and Home\u00a0Life",
            "description":"Rather than solely rehash the past, the couple focused more on current business ventures.",
            "url":"https:\/\/wwd.com\/eye\/people\/tommy-hilfiger-dee-ocleppo-fern-mallis-92y-talk-1235174634\/",
            "source":"wwd",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T20:48:45+00:00"
        },
        {
            "author":null,
            "title":"Ventas Reports 2022 First Quarter Results",
            "description":"(marketscreener.com) $0.01, Normalized FFO* per share of $0.69 - $0.73 and year-over-year same-store cash NOI* growth in the SHOP segment of 2 - 10%CEO Remarks\u0026ldquo;We are pleased that we grew first quarter year-over-year Normalized FFO and SHOP same-store cash NOI for the first time since the pandemic began . These strong results underscore the positive...https:\/\/www.marketscreener.com\/quote\/stock\/VENTAS-14836\/news\/Ventas-Reports-2022-First-Quarter-Results-40289444\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/VENTAS-14836\/news\/Ventas-Reports-2022-First-Quarter-Results-40289444\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T21:02:02+00:00"
        },
        {
            "author":null,
            "title":"Crew Energy Announces Q1 2022 Results Highlighted by Record Adjusted Funds Flow and Record Production",
            "description":"(marketscreener.com) CALGARY, Alberta, May 05, 2022 -- Crew Energy Inc. is a growth-oriented natural gas weighted producer operating exclusively in the world-class Montney play in northeast British Columbia . The Company is pleased to announce our operating and financial results for the three-month period ended March 31, 2022. Crew\u0026rsquo;s Financial Statements...https:\/\/www.marketscreener.com\/quote\/stock\/CREW-ENERGY-INC-1409571\/news\/Crew-Energy-Announces-Q1-2022-Results-Highlighted-by-Record-Adjusted-Funds-Flow-and-Record-Producti-40289437\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/CREW-ENERGY-INC-1409571\/news\/Crew-Energy-Announces-Q1-2022-Results-Highlighted-by-Record-Adjusted-Funds-Flow-and-Record-Producti-40289437\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T21:02:02+00:00"
        },
        {
            "author":null,
            "title":"Post Holdings Reports Results for the Second Quarter of Fiscal Year 2022",
            "description":"(marketscreener.com) ST. LOUIS, May 05, 2022 -- Post Holdings, Inc. , a consumer packaged goods holding company, today reported results for the second fiscal quarter ended March 31, 2022. Highlights: Second quarter net sales of $1.4 billionOperating profit of $100.0 million; net earnings from continuing operations of $525.6 million and Adjusted EBITDA of $229.7...https:\/\/www.marketscreener.com\/quote\/stock\/POST-HOLDINGS-INC-9971428\/news\/Post-Holdings-Reports-Results-for-the-Second-Quarter-of-Fiscal-Year-2022-40289433\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/POST-HOLDINGS-INC-9971428\/news\/Post-Holdings-Reports-Results-for-the-Second-Quarter-of-Fiscal-Year-2022-40289433\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T21:01:08+00:00"
        },
        {
            "author":null,
            "title":"Crew Energy Announces Q1 2022 Results Highlighted by Record Adjusted Funds Flow and Record Production",
            "description":"(marketscreener.com) CALGARY, Alberta, May 05, 2022 -- Crew Energy Inc. is a growth-oriented natural gas weighted producer operating exclusively in the world-class Montney play in northeast British Columbia . The Company is pleased to announce our operating and financial results for the three-month period ended March 31, 2022. Crew\u0026rsquo;s Financial...https:\/\/www.marketscreener.com\/quote\/stock\/CREW-ENERGY-INC-1409571\/news\/Crew-Energy-Announces-Q1-2022-Results-Highlighted-by-Record-Adjusted-Funds-Flow-and-Record-Producti-40289426\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/CREW-ENERGY-INC-1409571\/news\/Crew-Energy-Announces-Q1-2022-Results-Highlighted-by-Record-Adjusted-Funds-Flow-and-Record-Producti-40289426\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T21:01:05+00:00"
        },
        {
            "author":null,
            "title":"Baudax Bio Announces Date of Reconvened Annual Meeting of Shareholders",
            "description":"(marketscreener.com) MALVERN, Pa., May 05, 2022 -- Baudax Bio, Inc. , a pharmaceutical company focused on innovative products for acute care settings, today announced that it has adjourned its 2022 Annual Meeting of Shareholders , without any business being conducted, due to lack of shareholder participation resulting in a failure to reach required quorum....https:\/\/www.marketscreener.com\/quote\/stock\/BAUDAX-BIO-INC-76427032\/news\/Baudax-Bio-Announces-Date-of-Reconvened-Annual-Meeting-of-Shareholders-40289422\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/BAUDAX-BIO-INC-76427032\/news\/Baudax-Bio-Announces-Date-of-Reconvened-Annual-Meeting-of-Shareholders-40289422\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T21:01:02+00:00"
        },
        {
            "author":null,
            "title":"IBI Group Inc. Announces Strong Q1 2022 Results, Supporting\u00a03.5% Increase to 2022 Net Revenue Guidance",
            "description":"(marketscreener.com) 9.3% Organic growth11% Net revenue increase15.6% Adjusted EBITDA1 margin2022 net revenue guidance increased to $473 million TORONTO, May 05, 2022 -- IBI Group Inc. , a globally integrated design and technology firm, today announced its financial and operating results for the three months ended March 31, 2022. Select financial and...https:\/\/www.marketscreener.com\/quote\/stock\/IBI-GROUP-INC-1410399\/news\/IBI-Group-Inc-Announces-Strong-Q1-2022-Results-Supporting-3-5-Increase-to-2022-Net-Revenue-Guidan-40289413\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/IBI-GROUP-INC-1410399\/news\/IBI-Group-Inc-Announces-Strong-Q1-2022-Results-Supporting-3-5-Increase-to-2022-Net-Revenue-Guidan-40289413\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T21:01:01+00:00"
        },
        {
            "author":null,
            "title":"Westport Fuel Systems Publishes 2022 Annual and Special Meeting of Shareholders Results",
            "description":"(marketscreener.com) VANCOUVER, British Columbia, May 05, 2022 -- Westport Fuel Systems Inc. today held its Annual and Special Meeting of Shareholders in a virtual format. Shareholders approved all resolutions presented at the meeting including the election of all nominated directors, the appointment of KPMG LLP as the Company\u0026rsquo;s auditors, an advisory...https:\/\/www.marketscreener.com\/quote\/stock\/WESTPORT-FUEL-SYSTEMS-INC-1412231\/news\/Westport-Fuel-Systems-Publishes-2022-Annual-and-Special-Meeting-of-Shareholders-Results-40289411\/?utm_medium=RSS\u0026utm_content=20220505",
            "url":"https:\/\/www.marketscreener.com\/quote\/stock\/WESTPORT-FUEL-SYSTEMS-INC-1412231\/news\/Westport-Fuel-Systems-Publishes-2022-Annual-and-Special-Meeting-of-Shareholders-Results-40289411\/?utm_medium=RSS\u0026utm_content=20220505",
            "source":"4-traders",
            "image":null,
            "category":"general",
            "language":"en",
            "country":"us",
            "published_at":"2022-05-05T21:01:01+00:00"
        }
    ]
}
```

```
{
   "pagination":{
      "limit":25,
      "offset":0,
      "count":25,
      "total":10000
   },
   "data":[
      {
         "author":"ICT Business",
         "title":"\u00ab\u0633\u0644\u0643\u062a\u00bb \u062a\u0648\u0642\u0639 \u0627\u062a\u0641\u0627\u0642\u064a\u0629 \u062a\u0639\u0627\u0648\u0646 \u0645\u0639 \u00ab\u0641\u0631\u064a\u0634 \u0625\u0644\u064a\u0643\u062a\u0631\u064a\u0643\u00bb \u0644\u062a\u0632\u0648\u064a\u062f \u0627\u0644\u0639\u0645\u0644\u0627\u0621 \u0628\u0627\u0644\u0623\u062c\u0647\u0632\u0629 \u0627\u0644\u0623\u0643\u062b\u0631 \u0627\u0628\u062a\u0643\u0627\u0631\u0627 - ICT Business Magazine - \u0623\u064a \u0633\u064a \u062a\u064a \u0628\u064a\u0632\u0646\u0633",
         "description":"\u0623\u0639\u0644\u0646\u062a \u0634\u0631\u0643\u0629 \u0633\u0644\u0643\u062a \u0644\u062a\u0643\u0646\u0648\u0644\u0648\u062c\u064a\u0627 \u0627\u0644\u0627\u062a\u0635\u0627\u0644\u0627\u062a \u0648\u0627\u0644\u0645\u0639\u0644\u0648\u0645\u0627\u062a\u060c \u0627\u0644\u0645\u062a\u062e\u0635\u0635\u0629 \u0641\u064a \u0623\u062c\u0647\u0632\u0629 \u0627\u0644\u0645\u062d\u0645\u0648\u0644 \u0648\u0627\u0644\u0625\u0644\u0643\u062a\u0631\u0648\u0646\u064a\u0627\u062a\u060c \u062a\u0648\u0642\u0639\u064a\u0647\u0627 \u0628\u0631",
         "url":"http:\/\/thinakhbarak.local\/articles\/44017193--%D8%B3%D9%84%D9%83%D8%AA-%D8%AA%D9%88%D9%82%D8%B9-%D8%A7%D8%AA%D9%81%D8%A7%D9%82%D9%8A%D8%A9-%D8%AA%D8%B9%D8%A7%D9%88%D9%86-%D9%85%D8%B9-%D9%81%D8%B1%D9%8A%D8%B4",
         "source":"Akhbarak.net",
         "image":"https:\/\/akhbarak.net\/photos\/articles-photos\/2022\/5\/11\/44017193\/44017193-large.jpg?1652257238",
         "category":"general",
         "language":"ar",
         "country":"eg",
         "published_at":"2022-05-11T08:20:33+00:00"
      },
      {
         "author":null,
         "title":"\u0622\u0644\u0627\u0641 \u0627\u0644\u0645\u0634\u062c\u0639\u064a\u0646 \u064a\u062a\u062f\u0641\u0642\u0648\u0646 \u0625\u0644\u0649 \u0627\u0644\u062d\u064a \u0627\u0644\u062b\u0642\u0627\u0641\u064a \u0026quot;\u0643\u062a\u0627\u0631\u0627\u0026quot; \u0628\u0627\u0644\u062f\u0648\u062d\u0629 \u0644\u0645\u0634\u0627\u0647\u062f\u0629 \u0026quot;\u0627\u0644\u0643\u0623\u0633 \u0627\u0644\u0623\u0635\u0644\u064a\u0629\u0026quot; \u0644\u0644\u0645\u0648\u0646\u062f\u064a\u0627\u0644",
         "description":"\u062a\u0648\u0627\u0641\u062f \u0645\u0633\u0627\u0621 \u0623\u0645\u0633 \u0627\u0644\u062b\u0644\u0627\u062b\u0627\u0621 \u0627\u0644\u0622\u0644\u0627\u0641 \u0645\u0646 \u0645\u0634\u062c\u0639\u064a \u0643\u0631\u0629 \u0627\u0644\u0642\u062f\u0645 \u0639\u0644\u0649 \u0627\u0644\u062d\u064a \u0627\u0644\u062b\u0642\u0627\u0641\u064a \u0643\u062a\u0627\u0631\u0627 \u0628\u0627\u0644\u0639\u0627\u0635\u0645\u0629 \u0627\u0644\u0642\u0637\u0631\u064a\u0629 \u0627\u0644\u062f\u0648\u062d\u0629\u060c \u0644\u062d\u0636\u0648\u0631 \u0627\u0644\u062d\u0641\u0644 \u0627\u0644\u062e\u062a\u0627\u0645\u064a \u0644\u0644\u0643\u0623\u0633 \u0627\u0644\u0623\u0635\u0644\u064a\u0629 \u0644\u0628\u0637\u0648\u0644\u0629 \u0643\u0623\u0633 \u0627\u0644\u0639\u0627\u0644\u0645\u060c \u0648\u0627\u0644\u0630\u064a \u062c\u0627\u0621 \u0641\u064a \u0623\u0639\u0642\u0627\u0628 \u0627\u0644\u062c\u0648\u0644\u0629 \u0627\u0644\u062a\u0631\u0648\u064a\u062c\u064a\u0629 \u0627\u0644\u062a\u064a \u0628\u062f\u0623\u062a \u0641\u064a",
         "url":"http:\/\/www.elbotola.com\/article\/2022-05-10-23-09-154.html",
         "source":"Elbotola.com",
         "image":null,
         "category":"general",
         "language":"ar",
         "country":"ma",
         "published_at":"2022-05-11T08:25:27+00:00"
      },
      {
         "author":"\u0625\u0639\u0644\u0627\u0645",
         "title":"\u062e\u0627\u064a\u0641 \u0627\u0644\u0634\u0628\u0627\u0628 \u064a\u0643\u0641\u0640\u0631 \u0628\u0627\u0644\u0632\u0648\u0627\u062c.. \u0627\u0644\u0633\u064a\u0633\u064a \u064a\u062f\u0639\u0648 \u0644\u0625\u0639\u062f\u0627\u062f \u0642\u0627\u0646\u0648\u0646 \u0623\u062d\u0648\u0627\u0644 \u0634\u062e\u0635\u064a\u0629 \u0645\u062a\u0632\u0646 - E3lam.Com",
         "description":"\u0639\u0644\u0642 \u0627\u0644\u0631\u0626\u064a\u0633 \u0639\u0628\u062f \u0627\u0644\u0641\u062a\u0627\u062d \u0627\u0644\u0633\u064a\u0633\u064a \u0639\u0644\u0649 \u062a\u0646\u0627\u0648\u0644 \u0642\u0636\u064a\u0629 \u0642\u0627\u0646\u0648\u0646 \u0627\u0644\u0623\u062d\u0648\u0627\u0644 \u0627\u0644\u0634\u062e\u0635\u064a\u0629 \u0645\u0646 \u0642\u0628\u0644 \u0627\u0644\u0645\u0633\u062a\u0634\u0627\u0631 \u0639\u0628\u062f \u0627\u0644\u0644\u0647 \u0627\u0644\u0628\u0627\u062c\u0627 \u0631\u0626\u064a\u0633 \u0645\u062d\u0643\u0645\u0629 \u0627\u0644\u0623\u0633\u0631\u0629 \u0627\u0644\u0633\u0627\u0628\u0642\u060c \u0648\u0642\u0627\u0644 \u0627\u0644\u0631\u0626\u064a\u0633",
         "url":"http:\/\/thinakhbarak.local\/articles\/44015523-%D8%AE%D8%A7%D9%8A%D9%81-%D8%A7%D9%84%D8%B4%D8%A8%D8%A7%D8%A8-%D9%8A%D9%83%D9%81%D9%80%D8%B1-%D8%A8%D8%A7%D9%84%D8%B2%D9%88%D8%A7%D8%AC-%D8%A7%D9%84%D8%B3%D9%8A%D8%B3%D9%8A-%D9%8A%D8%AF%D8%B9%D9%88",
         "source":"Akhbarak.net",
         "image":"https:\/\/akhbarak.net\/photos\/articles-photos\/2022\/5\/11\/44015523\/44015523-large.jpg?1652225820",
         "category":"general",
         "language":"ar",
         "country":"eg",
         "published_at":"2022-05-10T23:36:42+00:00"
      },
      {
         "author":"\u0625\u0639\u0644\u0627\u0645",
         "title":"\u0646\u0634\u0648\u0649 \u0645\u0635\u0637\u0641\u0649: \u062d\u0627\u0631\u0628\u062a \u0639\u0634\u0627\u0646 \u0623\u0643\u0648\u0646 \u0645\u0645\u062b\u0644\u0629 - E3lam.Com",
         "description":"\u062a\u062d\u062f\u062b\u062a \u0627\u0644\u0641\u0646\u0627\u0646\u0629 \u0646\u0634\u0648\u0649 \u0645\u0635\u0637\u0641\u0649 \u0639\u0646 \u062a\u0641\u0627\u0635\u064a\u0644 \u062f\u062e\u0648\u0644\u0647\u0627 \u0645\u062c\u0627\u0644 \u0627\u0644\u0641\u0646\u060c \u0648\u062d\u0628\u0647\u0627 \u0644\u0644\u062a\u0645\u062b\u064a\u0644 \u0645\u0646\u0630 \u0637\u0641\u0648\u0644\u062a\u0647\u0627 \u0648\u062d\u0644\u0645\u0647\u0627 \u0628\u0623\u0646 \u062a\u0635\u0628\u062d \u0645\u0645\u062b\u0644\u0629 \u0648\u0630\u0644\u0643 \u0645\u0646 \u062e\u0644\u0627\u0644 \u062d\u0633\u0627\u0628\u0647\u0627 \u0627\u0644\u0631\u0633\u0645\u064a",
         "url":"http:\/\/thinakhbarak.local\/articles\/44018343-%D9%86%D8%B4%D9%88%D9%89-%D9%85%D8%B5%D8%B7%D9%81%D9%89-%D8%AD%D8%A7%D8%B1%D8%A8%D8%AA-%D8%B9%D8%B4%D8%A7%D9%86-%D8%A3%D9%83%D9%88%D9%86-%D9%85%D9%85%D8%AB%D9%84%D8%A9---E3lam-Com",
         "source":"Akhbarak.net",
         "image":"https:\/\/akhbarak.net\/photos\/articles-photos\/2022\/5\/11\/44018343\/44018343-large.jpg?1652270782",
         "category":"general",
         "language":"ar",
         "country":"eg",
         "published_at":"2022-05-11T12:06:20+00:00"
      },
      {
         "author":"monjed jado",
         "title":"Shireen Abu Akleh: Al Jazeera journalist shot dead bi IOF in West Bank",
         "description":"Bethlehem\/PNN\/ Israeli occupation forces have shot dead Al Jazeera\u2019s journalist Shireen Abu Akleh in the occupied West Bank, according to the Palestinian health ministry. She was hit by a live bullet on Wednesday while covering Israeli raids in the city of Jenin and was rushed to the hospital in critical condition, according to the ministry \u0026#8230;\u0627\u0644\u062a\u062f\u0648\u064a\u0646\u0629 Shireen Abu Akleh: Al Jazeera journalist shot dead bi IOF in West Bank \u0638\u0647\u0631\u062a \u0623\u0648\u0644\u0627\u064b \u0639\u0644\u0649 PNN.",
         "url":"http:\/\/english.pnn.ps\/2022\/05\/11\/shireen-abu-akleh-al-jazeera-journalist-shot-dead-in-west-bank\/",
         "source":"english",
         "image":null,
         "category":"general",
         "language":"ar",
         "country":"ps",
         "published_at":"2022-05-11T07:04:18+00:00"
      },
      {
         "author":"monjed jado",
         "title":"Palestinian officials slam Israel\u2019s killing of Al-Jazeera correspondent",
         "description":"Ramallah\/PNN\/ Palestinian officials today strongly condemned the Israeli killing of the Palestinian journalist Shireen Abu Akleh, a correspondent with Al-Jazeera, who was shot dead this morning by the Israeli occupation forces in Jenin refugee camp. The Palestinian Presidency today condemned what it described as \u201cthe crime of execution\u201d by the Israeli occupation forces of Palestinian \u0026#8230;\u0627\u0644\u062a\u062f\u0648\u064a\u0646\u0629 Palestinian officials slam Israel\u2019s killing of Al-Jazeera correspondent \u0638\u0647\u0631\u062a \u0623\u0648\u0644\u0627\u064b \u0639\u0644\u0649 PNN.",
         "url":"http:\/\/english.pnn.ps\/2022\/05\/11\/palestinian-officials-slam-israels-killing-of-al-jazeera-correspondent\/",
         "source":"english",
         "image":null,
         "category":"general",
         "language":"ar",
         "country":"ps",
         "published_at":"2022-05-11T07:33:17+00:00"
      },
      {
         "author":"\u0627\u0644\u0633\u064a\u0646\u0645\u0627",
         "title":"\u0022Doctor Strange in the Multiverse of Madness\u0022 \u064a\u062a\u062c\u0627\u0648\u0632 \u0627\u0644450 \u0645\u0644\u064a\u0648\u0646 \u062f\u0648\u0644\u0627\u0631 \u0641\u064a \u062b\u0644\u0627\u062b\u0629 \u0623\u064a\u0627\u0645 \u0639\u0631\u0636",
         "description":"\u0022Doctor Strange in the Multiverse of Madness\u0022 \u064a\u062a\u062c\u0627\u0648\u0632 \u0627\u0644450 \u0645\u0644\u064a\u0648\u0646 \u062f\u0648\u0644\u0627\u0631 \u0641\u064a \u062b\u0644\u0627\u062b\u0629 \u0623\u064a\u0627\u0645 \u0639\u0631\u0636",
         "url":"http:\/\/thinakhbarak.local\/articles\/44016314--quot-Doctor-Strange-in-the-Multiverse-of",
         "source":"Akhbarak.net",
         "image":"https:\/\/akhbarak.net\/photos\/articles-photos\/2022\/5\/11\/44016314\/44016314-large.jpg?1652235694",
         "category":"general",
         "language":"ar",
         "country":"eg",
         "published_at":"2022-05-11T02:21:22+00:00"
      },
      {
         "author":null,
         "title":"L\u2019ONU salue la contribution \u00abessentielle\u00bb du Maroc dans la pr\u00e9servation de l\u0027arganier",
         "description":"Les Nations unies ont mis en avant, mardi, les efforts et la contribution \u00abessentielle\u00bb du Maroc en mati\u00e8re de sauvegarde et de pr\u00e9servation de l\u2019arganier, \u00abune source d\u2019inspiration pour la r\u00e9alisation des objectifs de d\u00e9veloppement durable\u00bb.",
         "url":"https:\/\/www.yabiladi.com\/articles\/details\/127326\/l-onu-salue-contribution-essentielle-maroc.html",
         "source":"yabiladi.com",
         "image":"https:\/\/static.yabiladi.com\/files\/articles\/d747d545cd1b744a1404e2945ef4df4120220511112624150.jpg",
         "category":"general",
         "language":"ar",
         "country":"ma",
         "published_at":"2022-05-11T09:28:00+00:00"
      },
      {
         "author":null,
         "title":"\u0026quot;\u0633\u064a\u0627\u0631\u0629 \u0627\u0644\u0625\u0633\u0639\u0627\u0641\u0026quot; \u062a\u0646\u0632\u0644 \u0625\u0644\u0649 \u0026quot;\u0643\u0627\u0645\u0628 \u0646\u0648\u0026quot; \u0644\u0646\u0642\u0644 \u0623\u0631\u0627\u0648\u062e\u0648 \u0628\u0639\u062f \u0633\u0642\u0648\u0637\u0647 \u0026quot;\u0627\u0644\u0645\u0631\u0639\u0628\u0026quot; \u0636\u062f \u0633\u064a\u0644\u062a\u0627 \u0641\u064a\u063a\u0648",
         "description":"\u062a\u0639\u0631\u0636 \u0645\u064f\u062f\u0627\u0641\u0639 \u0646\u0627\u062f\u064a \u0628\u0631\u0634\u0644\u0648\u0646\u0629 \u0022\u0631\u0648\u0646\u0627\u0644\u062f \u0623\u0631\u0627\u0648\u062e\u0648\u0022 \u0644\u0625\u0635\u0627\u0628\u0629 \u0642\u0648\u064a\u0629 \u0639\u0644\u0649 \u0645\u0633\u062a\u0648\u0649 \u0627\u0644\u0631\u0623\u0633\u060c \u062e\u0644\u0627\u0644 \u0645\u0634\u0627\u0631\u0643\u062a\u0647 \u0641\u064a \u0645\u0628\u0627\u0631\u0627\u0629 \u0641\u0631\u064a\u0642\u0647 \u0636\u062f \u0633\u064a\u0644\u062a\u0627 \u0641\u064a\u063a\u0648\u060c \u0648\u0646\u062a\u062c\u062a \u0627\u0644\u0625\u0635\u0627\u0628\u0629 \u0645\u0646 \u0627\u0631\u062a\u0637\u0627\u0645 \u0628\u0627\u0644\u0631\u0623\u0633 \u0628\u064a\u0646 \u0627\u0644\u0644\u0627\u0639\u0628 \u0627\u0644\u0623\u0648\u0631\u062c\u0648\u064a\u0627\u0646\u064a \u0648\u0632\u0645\u064a\u0644\u0647 \u0641\u064a \u0627\u0644\u0628\u0627\u0631\u0633\u0627 \u0022\u062c\u0627\u0641\u064a\u0022\u060c \u0633\u0642\u0637 \u0639\u0644",
         "url":"http:\/\/www.elbotola.com\/article\/2022-05-10-21-25-720.html",
         "source":"Elbotola.com",
         "image":null,
         "category":"general",
         "language":"ar",
         "country":"ma",
         "published_at":"2022-05-10T21:30:32+00:00"
      },
      {
         "author":null,
         "title":"\u0627\u0644\u062f\u0648\u0644\u064a \u0627\u0644\u0633\u0627\u0628\u0642 \u0026quot;\u0645\u064a\u062f\u0648\u0026quot; \u064a\u0647\u0627\u062c\u0645 \u0645\u0648\u0642\u0639 \u0026quot;\u0627\u0644\u0628\u0637\u0648\u0644\u0629\u0026quot; \u0648\u064a\u0631\u0645\u064a \u0026quot;\u0627\u0644\u0643\u0627\u0641\u0026quot; \u0648\u0627\u0644\u062c\u0627\u0645\u0639\u0629 \u0628\u0627\u0644\u0627\u062a\u0647\u0627\u0645\u0627\u062a!",
         "description":"\u0648\u062c\u0647 \u0627\u0644\u062f\u0648\u0644\u064a \u0627\u0644\u0645\u0635\u0631\u064a \u0623\u062d\u0645\u062f \u062d\u0633\u0627\u0645 \u0645\u064a\u062f\u0648\u060c \u0627\u0644\u0639\u062f\u064a\u062f \u0645\u0646 \u0627\u0644\u0627\u062a\u0647\u0627\u0645\u0627\u062a \u0644\u0644\u062c\u0627\u0645\u0639\u0629 \u0627\u0644\u0645\u0644\u0643\u064a\u0629 \u0627\u0644\u0645\u063a\u0631\u0628\u064a\u0629 \u0644\u0643\u0631\u0629 \u0627\u0644\u0642\u062f\u0645 \u0648\u0022\u0627\u0644\u0643\u0627\u0641\u0022\u060c \u0639\u0628\u0631 \u062a\u0633\u0644\u064a\u0637\u0647 \u0627\u0644\u0636\u0648\u0621 \u0639\u0644\u0649 \u0645\u0627\u062f\u0629 \u0633\u0627\u0628\u0642\u0629 \u0644\u0635\u062d\u064a\u0641\u0629 \u0022\u0627\u0644\u0628\u0637\u0648\u0644\u0629\u0022.\u0648\u0627\u0633\u062a\u0639\u0631\u0636 \u0627\u0644\u0644\u0627\u0639\u0628 \u0627\u0644\u0633\u0627\u0628\u0642 \u0644\u0644\u0632\u0645\u0627\u0644\u0643 \u0627\u0644\u0645\u0635\u0631\u064a\u060c \u0635\u0648\u0631\u0629 \u0644\u0645\u0642\u0627\u0644 \u0646\u0634",
         "url":"http:\/\/www.elbotola.com\/article\/2022-05-10-17-22-690.html",
         "source":"Elbotola.com",
         "image":null,
         "category":"general",
         "language":"ar",
         "country":"ma",
         "published_at":"2022-05-10T17:25:31+00:00"
      },
      {
         "author":"\u0625\u0639\u0644\u0627\u0645",
         "title":"\u0022\u0648\u0627\u062d\u062f \u062a\u0627\u0646\u064a\u0022 \u0641\u064a\u0644\u0645 \u062e\u062a\u0627\u0645 \u0645\u0647\u0631\u062c\u0627\u0646 \u0631\u0648\u062a\u0631\u062f\u0627\u0645 \u0627\u0644\u0633\u064a\u0646\u0645\u0627\u0626\u064a \u0627\u0644\u062f\u0648\u0644\u064a - E3lam.Com",
         "description":"\u0627\u062e\u062a\u0627\u0631\u062a \u0625\u062f\u0631\u0627\u0629 \u0645\u0647\u0631\u062c\u0627\u0646 \u0631\u0648\u062a\u0631\u062f\u0627\u0645 \u0627\u0644\u0633\u064a\u0646\u0645\u0627\u0626\u064a \u0627\u0644\u062f\u0648\u0644\u064a\u060c \u0627\u0644\u0641\u064a\u0644\u0645 \u0627\u0644\u0645\u0635\u0631\u064a \u0648\u0627\u062d\u062f \u062a\u0627\u0646\u064a \u0644\u0644\u0641\u0646\u0627\u0646 \u0623\u062d\u0645\u062f \u062d\u0644\u0645\u064a\u060c \u0648\u0627\u0644\u0630\u064a \u0639\u0631\u0636 \u0641\u064a \u0639\u064a\u062f \u0627\u0644\u0641\u0637\u0631\u060c \u0648\u062a\u0635\u062f\u0631 \u0627\u0644\u0625\u064a\u0631\u0627\u062f\u0627\u062a \u0644\u0644\u0623\u0633\u0628\u0648\u0639",
         "url":"http:\/\/thinakhbarak.local\/articles\/44098108--quot-%D9%88%D8%A7%D8%AD%D8%AF-%D8%AA%D8%A7%D9%86%D9%8A-quot-%D9%81%D9%8A%D9%84%D9%85-%D8%AE%D8%AA%D8%A7%D9%85-%D9%85%D9%87%D8%B1%D8%AC%D8%A7%D9%86-%D8%B1%D9%88%D8%AA%D8%B1%D8%AF%D8%A7%D9%85",
         "source":"Akhbarak.net",
         "image":"https:\/\/akhbarak.net\/photos\/articles-photos\/2022\/5\/26\/44098108\/44098108-large.jpg?1653570445",
         "category":"general",
         "language":"ar",
         "country":"eg",
         "published_at":"2022-05-26T13:07:18+00:00"
      },
      {
         "author":"\u0625\u0639\u0644\u0627\u0645",
         "title":"\u0645\u062a\u0639\u0629.. \u0627\u0644\u0625\u0639\u0644\u0627\u0645\u064a\u0629 \u062d\u0646\u0627\u0646 \u0627\u0644\u0628\u0647\u064a \u062a\u0643\u0634\u0641 \u062a\u0641\u0627\u0635\u064a\u0644 \u0639\u0645\u0644\u0647\u0627 \u0628\u063a\u0633\u0644 \u0627\u0644\u0645\u0648\u062a\u0649 - E3lam.Com",
         "description":"\u062a\u062d\u062f\u062b\u062a \u0627\u0644\u0625\u0639\u0644\u0627\u0645\u064a\u0629 \u062d\u0646\u0627\u0646 \u0627\u0644\u0628\u0647\u064a\u060c \u0639\u0646 \u062a\u0639\u0644\u0645\u0647\u0627 \u0627\u0644\u063a\u0633\u0644 \u0648\u0627\u062a\u062c\u0627\u0647\u0647\u0627 \u0644\u0644\u062a\u0637\u0648\u0639 \u0644\u063a\u0633\u0644 \u0627\u0644\u0645\u062a\u0648\u0641\u064a\u0627\u062a \u0645\u0646 \u0627\u0644\u0646\u0633\u0627\u0621 \u0648\u0627\u0644\u0641\u062a\u064a\u0627\u062a\u060c \u0643\u0646\u0648\u0639 \u0645\u0646 \u0623\u0646\u0648\u0627\u0639 \u0627\u0644\u0639\u0645\u0644 \u0627\u0644\u0635\u0627\u0644\u062d.",
         "url":"http:\/\/thinakhbarak.local\/articles\/44098482-%D9%85%D8%AA%D8%B9%D8%A9-%D8%A7%D9%84%D8%A5%D8%B9%D9%84%D8%A7%D9%85%D9%8A%D8%A9-%D8%AD%D9%86%D8%A7%D9%86-%D8%A7%D9%84%D8%A8%D9%87%D9%8A-%D8%AA%D9%83%D8%B4%D9%81-%D8%AA%D9%81%D8%A7%D8%B5%D9%8A%D9%84",
         "source":"Akhbarak.net",
         "image":"https:\/\/akhbarak.net\/photos\/articles-photos\/2022\/5\/26\/44098482\/44098482-large.jpg?1653574360",
         "category":"general",
         "language":"ar",
         "country":"eg",
         "published_at":"2022-05-26T14:12:37+00:00"
      },
      {
         "author":null,
         "title":"Baitas : Le Maroc a pris les mesures n\u00e9cessaires pour faire face \u00e0 la variole du singe",
         "description":"Le gouvernement suit de mani\u00e8re proactive la variole du singe (monkeypox) et a pris les mesures n\u00e9cessaires pour faire face \u00e0 ses \u00e9ventuels d\u00e9veloppements, a assur\u00e9, jeudi \u00e0 Rabat, le ministre d\u00e9l\u00e9gu\u00e9 charg\u00e9 des Relations avec le Parlement, porte-parole du gouvernement, Mustapha Baitas. \u00abLe minist\u00e8re de la Sant\u00e9 a travaill\u00e9 de mani\u00e8re proactive sur la question et a pris un ensemble de mesures n\u00e9cessaires pour suivre l\u00e9volution de cette maladie, dans le respect des normes sanitaires internationales\u00bb, a-t-il soulign\u00e9.",
         "url":"https:\/\/www.yabiladi.com\/articles\/details\/127930\/baitas-maroc-pris-mesures-necessaires.html",
         "source":"yabiladi.com",
         "image":"https:\/\/static.yabiladi.com\/files\/articles\/a86307e46745ee81b09eaebb64bc55e520220526185241150.jpg",
         "category":"general",
         "language":"ar",
         "country":"ma",
         "published_at":"2022-05-26T16:58:00+00:00"
      },
      {
         "author":"\u0625\u0639\u0644\u0627\u0645",
         "title":"\u062a\u062d\u0631\u0643 \u0642\u0627\u0646\u0648\u0646\u064a \u0644\u0640 beIN \u0636\u062f \u0642\u0631\u0635\u0646\u0629 \u0627\u0644\u0645\u062d\u062a\u0648\u0649 \u0627\u0644\u0631\u064a\u0627\u0636\u064a \u0641\u064a \u0645\u0635\u0631 - E3lam.Com",
         "description":"\u0623\u0639\u0644\u0646\u062a \u0645\u062c\u0645\u0648\u0639\u0629 beIN \u0627\u0644\u0625\u0639\u0644\u0627\u0645\u064a\u0629\u060c \u0648\u0647\u064a \u0627\u0644\u0645\u062c\u0645\u0648\u0639\u0629 \u0627\u0644\u0625\u0639\u0644\u0627\u0645\u064a\u0629 \u0627\u0644\u0631\u0627\u0626\u062f\u0629 \u0636\u0645\u0646 \u0642\u0637\u0627\u0639 \u0627\u0644\u0631\u064a\u0627\u0636\u0629 \u0648\u0627\u0644\u0625\u0639\u0644\u0627\u0645 \u0648\u0627\u0644\u062a\u0631\u0641\u064a\u0647\u060c \u0648\u0634\u0631\u064a\u0643\u0647\u0627 \u0627\u0644\u0631\u0633\u0645\u064a \u0641\u064a \u0645\u0635\u0631\u060c \u0627\u0644\u0634\u0631\u0643\u0629 \u0627\u0644\u0645\u0635\u0631\u064a\u0629 \u0644\u0644\u0642\u0646\u0648",
         "url":"http:\/\/thinakhbarak.local\/articles\/44097692-%D8%AA%D8%AD%D8%B1%D9%83-%D9%82%D8%A7%D9%86%D9%88%D9%86%D9%8A-%D9%84%D9%80-beIN-%D8%B6%D8%AF-%D9%82%D8%B1%D8%B5%D9%86%D8%A9-%D8%A7%D9%84%D9%85%D8%AD%D8%AA%D9%88%D9%89",
         "source":"Akhbarak.net",
         "image":"https:\/\/akhbarak.net\/photos\/articles-photos\/2022\/5\/26\/44097692\/44097692-large.jpg?1653567684",
         "category":"general",
         "language":"ar",
         "country":"eg",
         "published_at":"2022-05-26T12:21:14+00:00"
      },
      {
         "author":null,
         "title":"Covid-19 au Maroc : Prolongement de l\u0027\u00e9tat d\u2019urgence sanitaire jusqu\u2019au 30 juin",
         "description":"Le Conseil de gouvernement, r\u00e9uni ce jeudi sous la pr\u00e9sidence du Chef du gouvernement Aziz Akhannouch, a d\u00e9cid\u00e9 de proroger la dur\u00e9e de validit\u00e9 de l\u00e9tat durgence sanitaire sur lensemble du territoire national jusquau 30 juin 2022. La mesure a \u00e9t\u00e9 prise pour continuer \u00e0 assurer lefficacit\u00e9 et lefficience des mesures prises par les autorit\u00e9s publiques afin de lutter contre la propagation de la pand\u00e9mie de Covid-19, indique-t-on.",
         "url":"https:\/\/www.yabiladi.com\/articles\/details\/127915\/covid-19-maroc-prolongement-l-etat-d-urgence.html",
         "source":"yabiladi.com",
         "image":"https:\/\/static.yabiladi.com\/files\/articles\/3a4669198664914c2268ac8b2e16655320220526151417150.jpg",
         "category":"general",
         "language":"ar",
         "country":"ma",
         "published_at":"2022-05-26T13:16:00+00:00"
      },
      {
         "author":null,
         "title":"\u0627\u0644\u0633\u0646\u063a\u0627\u0644\u064a \u0645\u0646\u062f\u064a \u0639\u0646 \u0628\u0644\u0648\u063a \u0627\u0644\u0645\u0648\u0646\u062f\u064a\u0627\u0644 \u0639\u0644\u0649 \u062d\u0633\u0627\u0628 \u0645\u0635\u0631: \u0026quot;\u0627\u0644\u0640\u0026#x27;VAR\u0026#x27; \u0644\u0645 \u064a\u0639\u0645\u0644 \u0641\u064a \u0644\u0642\u0627\u0621 \u0627\u0644\u0630\u0647\u0627\u0628 \u0628\u0627\u0644\u0642\u0627\u0647\u0631\u0629 \u0648\u0634\u0639\u0631\u0646\u0627 \u0642\u0644\u064a\u0644\u064b\u0627 \u0628\u0623\u0646\u0646\u0627 \u062a\u0639\u0631\u0636\u0646\u0627 \u0644\u0644\u0633\u0631\u0642\u0629\u0026quot;",
         "description":"\u064a\u0631\u0649 \u062d\u0627\u0631\u0633 \u0627\u0644\u0645\u0631\u0645\u0649 \u0627\u0644\u0633\u0646\u063a\u0627\u0644\u064a\u060c \u0625\u062f\u0648\u0627\u0631\u062f \u0645\u0646\u062f\u064a\u060c \u0623\u0646 \u0645\u0646\u062a\u062e\u0628 \u0628\u0644\u0627\u062f\u0647 \u062a\u0623\u0647\u0644 \u0625\u0644\u0649 \u0643\u0623\u0633 \u0627\u0644\u0639\u0627\u0644\u0645 \u0022\u0642\u0637\u0631 2022\u0022 \u0639\u0646 \u062c\u062f\u0627\u0631\u0629 \u0648\u0627\u0633\u062a\u062d\u0642\u0627\u0642\u060c \u0628\u0639\u062f \u062a\u0641\u0648\u0642\u0647 \u0639\u0644\u0649 \u0646\u0638\u064a\u0631\u0647 \u0627\u0644\u0645\u0635\u0631\u064a\u060c \u0645\u0624\u0643\u062f\u064b\u0627 \u0623\u0646 \u0631\u0641\u0627\u0642\u0647 \u0022\u062a\u063a\u0644\u0628\u0648\u0627 \u0639\u0644\u0649 \u0643\u0644 \u0627\u0644\u0639\u0631\u0627\u0642\u064a\u0644\u0022\u060c \u0628\u0645\u0627 \u0641\u064a \u0630\u0644\u0643 \u0022\u0639\u062f\u0645 \u0627\u0634\u062a\u063a\u0627\u0644 \u062a\u0642\u0646",
         "url":"http:\/\/www.elbotola.com\/article\/2022-05-26-17-09-802.html",
         "source":"Elbotola.com",
         "image":null,
         "category":"general",
         "language":"ar",
         "country":"ma",
         "published_at":"2022-05-26T17:35:29+00:00"
      },
      {
         "author":null,
         "title":"Les r\u00e9serves de sang au Maroc couvrent \u00e0 peine quatre jours",
         "description":"Les r\u00e9serves de sang disponibles s\u00e9l\u00e8vent \u00e0 lheure actuelle \u00e0 seulement 4 200 poches. Ce stock garantit la couverture de quatre jours seulement, a d\u00e9plor\u00e9, jeudi \u00e0 Rabat, le ministre d\u00e9l\u00e9gu\u00e9 charg\u00e9 des Relations avec le Parlement, porte-parole du gouvernement, Mustapha Baitas.",
         "url":"https:\/\/www.yabiladi.com\/articles\/details\/127957\/reserves-sang-maroc-couvrent-peine.html",
         "source":"yabiladi.com",
         "image":"https:\/\/static.yabiladi.com\/files\/articles\/73202c94480acc551c8c7367d83120ea20220527140640150.jpg",
         "category":"general",
         "language":"ar",
         "country":"ma",
         "published_at":"2022-05-27T12:09:00+00:00"
      },
      {
         "author":"Fatemeh Salari",
         "title":"Baladna increases ownership in Egypt\u2019s Juhayna to 10%",
         "description":"Baladna now owns 95.4 million QAR of Juhayna\u0026#8217;s total shares. Qatar\u0026#8217;s leading and largest dairy producer Baladna Company has increased its ownership stake in Egypt\u0026#8217;s Juhayna Food Industries to 10.1\u0026#8230;(The post Baladna increases ownership in Egypt\u0026#8217;s Juhayna to 10% is from Doha News | Qatar.)",
         "url":"https:\/\/dohanews.co\/baladna-increases-ownership-in-egypts-juhayna-to-10\/",
         "source":"Doha News",
         "image":null,
         "category":"general",
         "language":"ar",
         "country":"qa",
         "published_at":"2022-05-26T15:38:38+00:00"
      },
      {
         "author":null,
         "title":"\u0026quot;\u0643\u0627\u062f\u064a\u0646\u0627 \u0633\u064a\u0631\u0026quot;: \u0026quot;\u0643\u0631\u0648\u064a\u0641 \u0648\u0623\u0644\u064a\u0645\u0627\u0646\u064a \u0627\u062c\u062a\u0645\u0639\u0627 \u0628\u0648\u0643\u064a\u0644 \u0645\u0648\u0647\u0628\u0629 \u0623\u0633\u062a\u0648\u0646 \u0641\u064a\u0644\u0627 \u062a\u0634\u0648\u0643\u0648\u064a\u0645\u064a\u0643\u0627\u0026quot;",
         "description":"\u064a\u0631\u062a\u0628\u0637 \u0646\u0627\u062f\u064a \u0628\u0631\u0634\u0644\u0648\u0646\u0629 \u0628\u0639\u062f\u062f \u0644\u0627 \u0628\u0623\u0633 \u0628\u0647 \u0645\u0646 \u0627\u0644\u0623\u0633\u0645\u0627\u0621\u060c \u062e\u0644\u0627\u0644 \u0633\u0648\u0642 \u0627\u0644\u0627\u0646\u062a\u0642\u0627\u0644\u0627\u062a \u0627\u0644\u0635\u064a\u0641\u064a \u0627\u0644\u0645\u064f\u0642\u0628\u0644\u060c \u0648\u0645\u0646 \u0636\u0645\u0646 \u062a\u0644\u0643 \u0627\u0644\u0623\u0633\u0645\u0627\u0621 \u0645\u0648\u0647\u0628\u0629 \u0648\u0633\u0637 \u0645\u064a\u062f\u0627\u0646 \u0623\u0633\u062a\u0648\u0646 \u0641\u064a\u0644\u0627 \u0022\u0643\u0627\u0631\u0646\u064a \u062a\u0634\u0648\u0643\u0648\u064a\u0645\u064a\u0643\u0627\u0022.\u0648\u0648\u0641\u0642\u064b\u0627 \u0644\u0625\u0630\u0627\u0639\u0629 \u0022\u0643\u0627\u062f\u064a\u0646\u0627 \u0633\u064a\u0631\u0022\u060c \u0627\u0644\u062a\u0642\u0649 \u0627\u0644\u0645\u064f\u062f\u064a\u0631\u0627\u0646 \u0022\u0645\u0627\u062a\u064a\u0648 \u0623",
         "url":"http:\/\/www.elbotola.com\/article\/2022-05-25-19-52-390.html",
         "source":"Elbotola.com",
         "image":null,
         "category":"general",
         "language":"ar",
         "country":"ma",
         "published_at":"2022-05-25T19:55:28+00:00"
      },
      {
         "author":"\u0625\u0639\u0644\u0627\u0645",
         "title":"\u062d\u0633\u0646 \u0641\u0624\u0627\u062f \u064a\u0631\u0648\u064a \u0630\u0643\u0631\u064a\u0627\u062a\u0647 \u0645\u0639 \u0647\u062f\u0649 \u0633\u0644\u0637\u0627\u0646 \u0641\u064a \u0022\u0627\u0644\u0648\u062a\u062f\u0022 - E3lam.Com",
         "description":"\u062a\u062d\u062f\u062b \u0627\u0644\u0645\u0637\u0631\u0628 \u062d\u0633\u0646 \u0641\u0624\u0627\u062f \u0639\u0646 \u0630\u0643\u0631\u064a\u0627\u062a\u0647 \u062e\u0644\u0627\u0644 \u0639\u0645\u0644\u0647 \u0641\u064a \u0645\u0633\u0644\u0633\u0644 \u0627\u0644\u0648\u062a\u062f\u060c \u0627\u0644\u0630\u064a \u0639\u0631\u0636 \u0641\u064a \u0627\u0644\u062a\u0633\u0639\u064a\u0646\u064a\u0627\u062a \u0648\u062d\u0642\u0642 \u0646\u062c\u0627\u062d\u0627 \u0643\u0628\u064a\u0631\u0627.\u0623\u0648\u0636\u062d \u0641\u0624\u0627\u062f \u062e\u0644\u0627\u0644 \u062d\u0648\u0627\u0631\u0647 \u0625\u0644\u0649 \u0628\u0631\u0646\u0627\u0645\u062c \u0022\u0645\u0646 \u0645\u0635\u0631\u0022",
         "url":"http:\/\/thinakhbarak.local\/articles\/44173346-%D8%AD%D8%B3%D9%86-%D9%81%D8%A4%D8%A7%D8%AF-%D9%8A%D8%B1%D9%88%D9%8A-%D8%B0%D9%83%D8%B1%D9%8A%D8%A7%D8%AA%D9%87-%D9%85%D8%B9-%D9%87%D8%AF%D9%89-%D8%B3%D9%84%D8%B7%D8%A7%D9%86-%D9%81%D9%8A",
         "source":"Akhbarak.net",
         "image":"https:\/\/akhbarak.net\/photos\/articles-photos\/2022\/6\/8\/44173346\/44173346-large.jpg?1654689461",
         "category":"general",
         "language":"ar",
         "country":"eg",
         "published_at":"2022-06-08T11:57:38+00:00"
      },
      {
         "author":"\u0625\u0639\u0644\u0627\u0645",
         "title":"\u0645\u062d\u0645\u062f \u062f\u064a\u0627\u0628 \u0639\u0646 \u0022Moon Knight\u0022: \u0634\u0639\u0648\u0631 \u0631\u0627\u0626\u0639 \u0623\u0646 \u064a\u0646\u0627\u0644 \u0639\u0645\u0644\u0643 \u0625\u0639\u062c\u0627\u0628 \u0637\u0641\u0644 \u0645\u0646 \u0627\u0644\u0647\u0646\u062f \u0648\u0622\u062e\u0631 \u0645\u0646 \u0623\u0633\u062a\u0631\u0627\u0644\u064a\u0627 - E3lam.Com",
         "description":"\u0627\u0633\u062a\u0636\u0627\u0641 \u0627\u0644\u0645\u0624\u062a\u0645\u0631 \u0627\u0644\u0635\u062d\u0641\u064a \u0627\u0644\u062e\u0627\u0635 \u0628\u0625\u0637\u0644\u0627\u0642 \u0022\u062f\u064a\u0632\u0646\u0649 \u0628\u0644\u0633\u0022\u060c \u0627\u0644\u0630\u064a \u0639\u064f\u0642\u062f \u0628\u0623\u0648\u0628\u0631\u0627 \u062f\u0628\u064a \u0628\u0627\u0644\u0625\u0645\u0627\u0631\u0627\u062a \u0627\u0644\u0639\u0631\u0628\u064a\u0629 \u0627\u0644\u0645\u062a\u062d\u062f\u0629\u060c \u0627\u0644\u0645\u062e\u0631\u062c \u0627\u0644\u0645\u0635\u0631\u064a \u0645\u062d\u0645\u062f \u062f\u064a\u0627\u0628 \u0648\u0632\u0648\u062c\u062a\u0647 \u0633\u0627\u0631\u0629 \u062c\u0648\u0647\u0631\u060c \u0628",
         "url":"http:\/\/thinakhbarak.local\/articles\/44173349-%D9%85%D8%AD%D9%85%D8%AF-%D8%AF%D9%8A%D8%A7%D8%A8-%D8%B9%D9%86-quot-Moon-Knight-quot-%D8%B4%D8%B9%D9%88%D8%B1-%D8%B1%D8%A7%D8%A6%D8%B9-%D8%A3%D9%86",
         "source":"Akhbarak.net",
         "image":"https:\/\/akhbarak.net\/photos\/articles-photos\/2022\/6\/8\/44173349\/44173349-large.jpg?1654689467",
         "category":"general",
         "language":"ar",
         "country":"eg",
         "published_at":"2022-06-08T11:57:44+00:00"
      },
      {
         "author":"\u0625\u0639\u0644\u0627\u0645",
         "title":"\u062a\u0639\u0644\u064a\u0642 \u0645\u0628\u0631\u0648\u0643 \u0639\u0637\u064a\u0629 \u0639\u0644\u0649 \u062a\u0635\u0648\u064a\u0631 \u0641\u062a\u064a\u0627\u062a \u062f\u0627\u062e\u0644 \u062d\u0645\u0627\u0645 \u0645\u0637\u0639\u0645 \u0628\u0627\u0644\u0633\u0627\u062d\u0644 - E3lam.Com",
         "description":"\u062a\u0635\u0648\u064a\u0631 \u0641\u062a\u064a\u0627\u062a \u062f\u0627\u062e\u0644 \u062d\u0645\u0627\u0645 \u0645\u0637\u0639\u0645 \u0628\u0627\u0644\u0633\u0627\u062d\u0644 \u0639\u0644\u0642 \u062f. \u0645\u0628\u0631\u0648\u0643 \u0639\u0637\u064a\u0629 \u0639\u0644\u0649 \u0648\u0627\u0642\u0639\u0629 \u0627\u062a\u0647\u0627\u0645 \u0623\u062d\u062f \u0627\u0644\u0639\u0627\u0645\u0644\u064a\u0646 \u0628\u0645\u0637\u0639\u0645 \u0645\u0627\u0643\u062f\u0648\u0646\u0627\u0644\u062f\u0632 \u0641\u064a \u0645\u062f\u064a\u0646\u0629 \u0627\u0644\u0639\u0644\u0645\u064a\u0646\u060c \u0628\u062a\u0635\u0648\u064a\u0631 \u0627\u0644\u0632\u0628\u0627\u0626\u0646",
         "url":"http:\/\/thinakhbarak.local\/articles\/44174356-%D8%AA%D8%B9%D9%84%D9%8A%D9%82-%D9%85%D8%A8%D8%B1%D9%88%D9%83-%D8%B9%D8%B7%D9%8A%D8%A9-%D8%B9%D9%84%D9%89-%D8%AA%D8%B5%D9%88%D9%8A%D8%B1-%D9%81%D8%AA%D9%8A%D8%A7%D8%AA-%D8%AF%D8%A7%D8%AE%D9%84-%D8%AD%D9%85%D8%A7%D9%85",
         "source":"Akhbarak.net",
         "image":"https:\/\/akhbarak.net\/photos\/articles-photos\/2022\/6\/8\/44174356\/44174356-large.jpg?1654699572",
         "category":"general",
         "language":"ar",
         "country":"eg",
         "published_at":"2022-06-08T14:46:10+00:00"
      },
      {
         "author":null,
         "title":"Akhannouch appelle \u00e0 acc\u00e9l\u00e9rer la mise en \u0153uvre de la g\u00e9n\u00e9ralisation de la protection sociale",
         "description":"Le chef du gouvernement, Aziz Akhannouch, a appel\u00e9, mardi \u00e0 Rabat, lensemble des d\u00e9partements minist\u00e9riels \u00e0 intensifier les efforts et acc\u00e9l\u00e9rer la mise en \u0153uvre du chantier de g\u00e9n\u00e9ralisation de la protection sociale, tel que voulu par le roi Mohammed VI. Selon un communiqu\u00e9 du D\u00e9partement du Chef du gouvernement, M. Akhannouch, qui pr\u00e9sidait une r\u00e9union sur la g\u00e9n\u00e9ralisation de la protection sociale, a soulign\u00e9 que la mise en \u0153uvre de ce chantier soci\u00e9tal aura un impact direct et tangible en mati\u00e8re dam\u00e9lioration des conditions de vie des Marocains et la pr\u00e9servation de...",
         "url":"https:\/\/www.yabiladi.com\/articles\/details\/128390\/akhannouch-appelle-accelerer-mise-oeuvre.html",
         "source":"yabiladi.com",
         "image":"https:\/\/static.yabiladi.com\/files\/articles\/cd471f904fcd363fb5345fc65ac5405d20220608114359150.jpg",
         "category":"general",
         "language":"ar",
         "country":"ma",
         "published_at":"2022-06-08T09:50:00+00:00"
      },
      {
         "author":null,
         "title":"Lions de l\u2019Atlas : Ces 6 matchs qui ont marqu\u00e9 l\u2019histoire de l\u2019\u00e9quipe du Maroc",
         "description":"Depuis sa premi\u00e8re rencontre officielle en tant que pays ind\u00e9pendant le 19 octobre 1957 face \u00e0 l\u2019Irak (3-3), le parcours des l\u2019\u00e9quipe nationale du Maroc a \u00e9t\u00e9 mouvement\u00e9.\u00a0Les Lions de l\u2019Atlas ont connu de longues travers\u00e9es du d\u00e9sert, mais aussi leurs ann\u00e9es de gloire. Retour sur les six rencontres qui ont marqu\u00e9 l\u2019histoire du football national.",
         "url":"https:\/\/www.yabiladi.com\/articles\/details\/20984\/lions-l-atlas-matchs-marque-l-histoire.html",
         "source":"yabiladi.com",
         "image":"https:\/\/static.yabiladi.com\/files\/articles\/b742de944914fc93b09610b8a611522b150.jpg",
         "category":"general",
         "language":"ar",
         "country":"ma",
         "published_at":"2022-06-08T18:00:00+00:00"
      },
      {
         "author":"Kristian Coates Ulrichsen",
         "title":"\ufffc\ufffcHow Qatar has secured a \u2018critical\u2019 seat at global decision-making table",
         "description":"Qatar\u0026#8217;s role in international diplomacy and global security was highlighted in a meeting\u0026#160;between the country\u0026#8217;s Foreign Minister Sheikh Mohammed bin Abdulrahman Al Thani, and the US Secretary of State Antony\u0026#8230;(The post \ufffc\ufffcHow Qatar has secured a \u2018critical\u2019 seat at global decision-making table is from Doha News | Qatar.)",
         "url":"https:\/\/dohanews.co\/%ef%bf%bc%ef%bf%bchow-qatar-has-secured-a-critical-seat-at-global-decision-making-table\/",
         "source":"Doha News",
         "image":null,
         "category":"general",
         "language":"ar",
         "country":"qa",
         "published_at":"2022-06-08T10:58:04+00:00"
      }
   ]
}
```
400 RESPONSE
Bad Request

404 RESPONSE
Not found

416 RESPONSE
Range not satisfiable

500 RESPONSE
Internal server error

### Example API Response Objects:

| Response Object                      | Description                                                   |
|--------------------------------------|---------------------------------------------------------------|
| `pagination > limit`                 | `Returns your pagination limit value.`                        |
| `pagination > offset`                | `Returns your pagination offset value.`                       |
| `pagination > count`                 | `Returns the results count on the current page.`              |
| `pagination > total`                 | `Returns the total count of results available.`               |
