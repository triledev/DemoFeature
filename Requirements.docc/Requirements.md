# ``Feed Loader``

## Image Feed Feature Specs

### Story: Customer requests to see their image feed

### Narrative #1
```
As an online customer  
I want the app to automatically load my latest image feed  
So I can always enjoy the newest images of my friends
```

#### Scenarios (Acceptance criteria)
>
Given __the__ customer has connectivity  
When __the__ customer request *to* see __the__ feed  
Then __the__ app should display __the__ latest feed *from* remote  
  And *replace* __the__ cache __with the__ *new* feed


### Narrative #2
```
As an offline customer  
I want the app to show the latest saved version of my image feed  
So I can always enjoy images of my friends
```

#### Scenarios (Acceptance criteria)
>
Given the customer doesn't have connectivity  
__When__ the customer request __to__ see the feed  
__Then__ the app should display the latest feed saved

>
Given the customer desn't have connectivity  
__And__ the cache __is__ empty  
__When__ the customer request __to__ see the feed  
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

GET * http://api.mediastack.com/v1/news?access_key=bc6aff46b7ed7e0b2e29c421ffc9fcfd *

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

400 RESPONSE
Bad Request

404 RESPONSE
Not found

416 RESPONSE
Range not satisfiable

500 RESPONSE
Internal server error

---

200 RESPONSE
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
