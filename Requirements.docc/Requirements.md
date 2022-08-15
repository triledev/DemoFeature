# ``Requirements``

## Narrative #1
> As an online customer  
I want the app to automatically load my latest image feed  
So I can always enjoy the newest images of my friends  

### Scenarios (Acceptance criteria)
Given __the__ customer has connectivity  
When __the__ customer request *to* see __the__ feed  
Then __the__ app should display __the__ latest feed *from* remote  
  And *replace* __the__ cache __with the__ *new* feed  

## Narrative #2
> As an offline customer  
I want the app to show the latest saved version of my image feed  
So I can always enjoy images of my friends  

### Scenarios (Acceptance criteria)
Given the customer doesn't have connectivity  
When the customer request to see the feed  
Then the app should display the latest feed saved  

Given the customer desn't have connectivity  
And the cache is empty  
When the customer request to see the feed  
Then the app should display an error message  


