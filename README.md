# Project 5 - *SportLights*

**SportLights** is a basic sports highlights app to displays the video of the highlights of the teams last game

Time spent:**X** hours spent in total

## User Stories

The following **required** functionality is completed:
- [ ] User sees app icon in home screen and styled launch screen.
- [ ] User can use a search bar to choose a team 
- [ ] User can pick a sport from the list
- [ ] User sees a list of teams to pick from
- [ ] User can pull to refresh. 
- [ ] Using AutoLayout, the sports cell should adjust it's layout for iPhone 8, Plus and SE device sizes as well as accommodate device rotation. 

The following **stretch** features are implemented:
- [ ] User can sign in 
- [ ] User can Logout. 
- [ ] User can save highlights videos to their playlist
- [ ] User can save their favorite teams.
- [ ] User can view their top favorite team highlights when application opens.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1.
2.

## Wireframe
![Wire Frame](https://github.com/CSUMB-CST495-GROUP10/SportLights/blob/master/wireframePic.png)

## Considerations
* What is your product pitch?
    * Have you ever wanted to find awesome highlights of your favorite sports teams but end up on a manual YouTube search for the hours?
    * Welcome to SportLights, where you can view a variety of your teams highlights from the palm of your hand!
    * Other Apps such as ESPN on offer news reports and small pieces about a teams activity, and will only show you minimal or top 5/10 highlights
    * Along with a plethora of videos, one csn choose a team to recieve videos for and catelog them to their account.
    
* Who are the key stakeholders for this app?
   * The key stakeholders for this app are sports enthusiast who would like to relive their teams highlights 
   of their last game played or for those who were unable to watch it live. 
   
* What are the core flows?
   * The key functions for SportLights is the ability to search any team, from any sport, and view the highlights 
   of their last game played. The user will user four screens: home page, login, sign up, search/video, 
   and their profile screen.
   
* What will your final demo look like?
   * The flow of the final demo will first greet the user with a launch screen of the SportLights logo. Followed by 
   the home page that will ask the user to either sign up, login, or search for a team. To demostrate that the user 
   can easily search for a team without being logged in, we will press the search button and search for any team
   and view their highlights. After the video is displayed, we will demonstrate how to sign up to SportLights and show 
   how they can login. Finally, demonstrating the user's profile once logged in.
   
* What mobile features do you leverage?
   * The two mobile-oriented features SportLights will leverage are media video player and user location.
   
* What are your technical concerns?
   * Some technical concerns are finding the perfect API, displaying the correct highlights, and containing
   the users list of favorite teams.

## Business Models

* User
   * first_name, last_name, username, profile_image, created_on

* Highlight
   * teams_involved, date, video_source, video_format

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://i.imgur.com/abc.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [SportsDataAPI](https://www.mysportsfeeds.com/data-feeds/api-docs/) - main data source

## License

    Copyright [2018] [Group 10]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
