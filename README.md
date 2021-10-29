# SW-Lab-U01_W03_D11-Timer
Fourth App that times the cooking time of both al dente and normal pasta 

## Topics
1. Auto Layout
2. The static function `Timer.scheduledTimer`
3. The mechanism **Target-Action**
4. Interact with **Objective-C selectors** from Swift with the keyword `@objc`
5. Progress Views
6. Operations with float numbers
7. Play sound with the framework `AVFoundation`
8. Unwrapping optionals with `guard let` rather than `if let`
9. Introduction to **error handling**


## Description
1. Build the fourth Bootcamp App. 
2. In **Timer**, the user selects to boil pasta al dente or normal. In the first choice the timer is shorter than the latter.
3. When the time is up, the user is notified with the sound of an alarm and a message on the screen indicating that he/she can remove the pasta from the heat.

## Deadline 
Monday 18th October 12:00 midday



# Timer:

- Here is the man screen of timer app: (asking user to choose between timers)
<img width="1440" alt="mainScreen" src="https://user-images.githubusercontent.com/91871449/137641525-b80001a4-e367-46c9-b129-70c539ddb695.png">


- This screen shows that al dente timer has been selected :
(progress bar will inform the user about time that will be taken to complete the task)

<img width="1440" alt="aldenteTimer" src="https://user-images.githubusercontent.com/91871449/137641682-cee9d106-a9f3-48ce-ba57-3456b3bae80e.png">


- This screen shows that normal timer has been selected : (progress bar will inform the user about time that will be taken to complete the task)

<img width="1440" alt="normalTimer" src="https://user-images.githubusercontent.com/91871449/137641827-5ae8f616-74f5-472b-b9c0-818c18a35c61.png">


- This screen shows a message that inform the user when the timer finished:

<img width="1440" alt="timerFinished" src="https://user-images.githubusercontent.com/91871449/137642153-d1cba480-4cce-416c-81f8-8a16718c3417.png">
