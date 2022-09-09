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

### Load Feed From Cache Use Case

#### Primary course:
1. Execute "Load Image Feed" command with above data.
2. System retrieves feed data from cache.
3. System validates cache is less than seven days old.
4. System creates image feed from cached data.
5. System delivers image feed.

#### Retrieval error course (sad path):
1. System deletes cache.
2. System delivers error.

#### Expired cache course (sad path):
1. System deletes cache.
2. System delivers no feed images.

#### Empty cache course (sad path):
1. System delivers no feed images.

- Insert
    - To empty cache works
    - To non-empty cache overrides previous value
    - Error (if possible to simulate, e.g., no write permission)

- Retrieve
    - Empty cache works (before something is inserted)
    - Non-empty cache returns data
    - Non-empty cache twice returns same data (retrieve should have no side-effects)
    - Error (if possible to simulate, e.g., invalid data)

- Delete
    - Empty cache does nothing (cache stays empty and does not fail)
    - Inserted data leaves cache empty
    - Error (if possible to simulate, e.g., no write permission)

- Side-effects must run serially to avoid race-conditions (deleting the wrong cache... overriding the latest data...)
---
Documentation: https://mediastack.com/documentation

GET * http://api.mediastack.com/v1/news?access_key=YOUR_ACCESS_KEY *

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
