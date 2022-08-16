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

GET * http://api.mediastack.com/v1/news?access_key=YOUR_ACCESS_KEY *

200 RESPONSE

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
