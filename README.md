## Inspiration
As a group of college students, we have all experienced the frustration of having unused meal swipes that go to waste. Not only is it a financial loss, but it also contributes to the larger issue of food waste on campus. We wanted to create a solution that would allow students to exchange their unused meal swipes with each other, reduce food waste, and create a sense of community on campus. This idea inspired us to build RU SwipeShare, a mobile application for Rutgers students to exchange unused meal swipes.

## What it does
RU SwipeShare is a mobile application that enables Rutgers students to exchange unused meal swipes. The app allows students to post their available swipes, view available swipes from other students, and coordinate exchanges using real-time messaging. Users can also offer predetermined items or services in exchange for meal swipes, which are processed securely through the Stripe payment gateway.

## How we built it
To build RU SwipeShare, we used Flutter for the front-end development, Firebase for the back-end database and authentication, and Stripe for payment processing. Josh and Nate were responsible for the UI/UX design of the application, while Hitesh and Ashish were responsible for Firebase and Stripe integration.

For the front-end development, Josh and Nate created a responsive UI that allows users to view available meal swipes, post their own available swipes, and request to use other users' swipes. They used the Flutter package "http" to communicate with the Flask server and fetch or post data as needed.

For the back-end database and authentication, Hitesh and Ashish used Firebase to authenticate users with their Rutgers email addresses and store and retrieve user data. They also used Firebase messaging to enable real-time messaging between users to coordinate exchanges.

To enable payment processing, Hitesh and Ashish integrated the Stripe API into the app. When a user requests to use a meal swipe, they pay the amount that the seller is willing to sell it for in exchange, and the transaction is processed securely through Stripe.

## Challenges we ran into
The main challenge we faced during the development process was integrating the various technologies and frameworks to work seamlessly together (especially Stripe). This required a lot of experimentation and testing to ensure that all components were working correctly and securely. 

## Accomplishments that we're proud of
We are proud of building a functional and efficient app that has the potential to make a real impact in reducing food waste on Rutgers' campus. We are also proud of successfully integrating multiple technologies and frameworks to build a cohesive and seamless user experience.

## What we learned
Through building RU SwipeShare, we learned how to use Flutter for front-end development, Firebase for back-end database and authentication, and Stripe for payment processing. We also gained experience in real-time messaging, API integration, and user authentication.

## What's next for RU SwipeShare
We plan to continue improving RU SwipeShare by incorporating user feedback and adding additional features, such as user ratings and reviews, group exchanges, and a rewards program. We also plan to expand the app to other universities and institutions with similar meal swipe systems.
