## Usecase

### Boundary conditions (Randbedingungen)

- For an user like a student that needs a time schedule plan
- 

### Expected results
- The input is displayed

### Evidence that it was tested
- screenshot


- The app is used for having an overview about events that are upcoming on a day
- It's like a school schedule


## Test case
- [x] 2+ test cases showing the correct function of the app

### test 1: save a new event
- create a new event with title, color, start and end time
- > **Excpected:** The new event is shown in the list inside the app

### test 2: test the persistence of the data
- after saving an event close the app and then also quit it from app switcher (if on iOS)
- > **Excpected:** The events are still there when the app is openend

### test 3: delete events
- try deleting an event by either tap the edit button in the top left or swipe to left on the event
- > **Excpected:** The event is deleted and gone
