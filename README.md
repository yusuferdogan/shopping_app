This is a shopping list application that can help you to note your shopping list. 
With this this application you can list your shopping items with different categories. 


The application tested both android and iOS devices. 

## Run the application
    - flutter run -d <device>

## Test the application
    - flutter test test/service_test


Application uses the flutter bloc library to manage state management. 

Application connects to the Firestore rest api to get and post the data. 

models folder contains the data structure of the item
services folder contains the Client class that responsible for communication with Firestore Rest API
cubit folder contains cubit files that manage the state management



## How to use the appliation

The application starts with a wellcome page. When you press the Get Start button app starts to getting all data from the firestore. 
Existing items will be listed on that page. If you want to delete or mark as done swipe the item to the left. 

To add a new item press the + button and fill the text controls. If you do not specify the category item will be saved as uncategorized.

