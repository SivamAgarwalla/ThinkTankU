Original App Design Project
===

# ThinkTankU

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
A college-specific social media platform for sharing student founded startups. This would allow students to learn about current active startups,
discuss potential ideas, get involved with other students, and even present their own unique ideas! Overall, it will foster an environment of
innovation and growth for all college campuses involved.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social Network / Entrepreneurship 
- **Mobile:** This app would be primarily developed using Swift for iOS but then could be later ported to support Android as well. In theory, a web application
              could be designed for it as well, but since the focus is quick connectivity and collaboration, a mobile platform is ideal.
- **Story:** A news feed style app which shares posts on current student startups, open discussions on potential ideas, and allows students to find startups
             that they would be interested in getting involved in. The user would see all these posts on the Home Screen and would be allowed to interact with
             the community and find students with similar passions to work with.
- **Market:** Any student in college could use this app, and to allow for more organization and less cluster, students would be grouped together based on what
              college they go to. This means that students would only be able to see startups and discussions posts by other students on their campus.
- **Habit:** This app could be used as often as the user desires. We expect that once the user becomes involved in a startup themselves they will be using
             the app much more often, as they will now be a part of the ecosystem. 
- **Scope:** While the app is starting off as a social network for sharing student based startups and fostering open discussion, it can transform to become a
             whole ecosystem. It can be extended to support campuses around the area, have chat features, organize hackathons, and host company presentations
             so startups can get their ideas out to a larger audience.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can log in and view home feed customized based on their selections/filters
* User can register an account
* User can pick which startups to follow based on industry and what post type to see on the sorting screen
* Students can register their startup and add members/description/images
* Users can create posts to promote/recruit for their startups, start open discussions, and post about themselves to get involved
* Profile pages for user and startups that can be customized
* Settings (can be appended to user page)


**Optional Nice-to-have Stories**

* Messaging feature to allow students to communicate directly on the app
* Random Company profile finder for exploration
* App theme changes based on university


### 2. Screen Archetypes

* Log in Screen
   * Users that have an account registered can enter their username and password to sign into the application.
   * If the user does not have an account, there will be a Sign Up button on the button of the screen where they can join.
* Sign Up Screen
   * Users can enter their Name, Email, Password, School Name, Current Year, Startup Name (Optional) to create an account.
* Home Screen
   * This screen will serve as the main news feed and will contain posts regarding sharing startup ideas, open discussion about the viability of certain ideas, and posts where either students are looking to work for a startup or startups are looking for students with specific skill sets.
* Sorting Screen
   * On this screen the user can set filters to customize the content that they will see on the HomeScreen. They can customize what companies they want to see
     posts/updates from and what types of posts they want to see in general.
* Create Post Screen
   * This will allow users to create a post about either their startup, an open discussion post, a post looking to join a startup, etc.
   * The fields on this screen will include the Title, Description, Relevant Image (Optional), and the type of post.
* Post Detail Screen
   * This page will be shown when the user clicks on a post on the home screen and will have more details regarding the post and a comment section.
* Profile Screen
   * This will be a custom profile screen for each user which will show their name, profile image, a short bio, skills, and links to relevant social media. 
     It will also show the posts that the user has posted. 
     

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Screen
* Sorting Screen
* Create Post Screen
* Profile Screen

Note that the other screens listed above will not be shown in the tab, but will rather be shown when the user takes an action on Home Screen.

**Flow Navigation** (Screen to Screen)

* Log In Screen
   * Lon In Screen -> Create Account Screen (if user is not registered)
   * Log In Screen -> Home Screen (if the user is already registered)
* Sign Up Screen
   * Sign Up Screen -> Log In Screen (once registration is successful)
* Home Screen
   * Home Screen -> Post Detail Screen (if user clicks on a post)
   * Home Screen -> Profile Screen (if the user clicks on the username of the post creator)
* Sorting Screen
   * Sorting Screen -> Home Screen (once the desired filters are applied)
* Create Post Screen
   * Create Post Screen -> Home Screen (once the post is created the user is taken back to the home screen)
* Post Detail Screen
   * Post Detail Screen -> Home Screen (once the user clicks the back button)
   * Post Detail Screen -> Profile Screen (if the user clicks on the username of the post creator)
* Profile Screen
   * Profile Screen -> Post Detail Screen (if the user clicks on any of their recent posts, which are shown on the profile page)



## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="Screen Shot 2020-10-22 at 10.37.13 PM.png" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models

**Users**
| Property                   | Type               | Description                             |
|----------------------------|--------------------|-----------------------------------------|
| objectID                   | String             | Unique ID for each user (default field) |
| Name                       | String             | User first and last name                |
| Email                      | String             | User’s email linked with the account    |
| Password (Hash)            | String             | Hashed value of the user’s password     |
| School                     | String             | The school that the user attends        |
| Startup (Optional)         | Pointer to Startup | The startup the user is associated with |
| Bio (Optional)             | String             | A short description of the user         |
| Profile Picture (Optional) | File               | A picture/avatar for the user           |

**Posts**
| Property           | Type                        | Description                                                                               |
|--------------------|-----------------------------|-------------------------------------------------------------------------------------------|
| objectID           | String                      | Unique ID for each post (default field)                                                   |
| Author             | Pointer to User             | The user that created the post                                                            |
| Image (Optional)   | File                        | Image associated with the post                                                            |
| Startup (Optional) | String                      | The startup that the post is related to                                                   |
| Post Type          | String                      | The type of post that is being created                                                    |
| Title              | String                      | Title associated with post                                                                |
| Description        | String                      | Description of the post                                                                   |
| Comments           | Array[Pointers to Comments] | Will contain references to all the comments associated with the post                      |
| Likes              | Array[Pointers to User]     | Will store all the likes for the post, no duplicate User IDs will be allowed in the array |

**Comments**
| Property | Types           | Description                                |
|----------|-----------------|--------------------------------------------|
| objectID | String          | Unique ID for each comment (default field) |
| Author   | Pointer to User | The user that created the comment          |
| Text     | String          | The content/text of the comment            |

### Networking
#### List of network requests by screen
   - Login Screen
      - (Read/GET) User Data (Verify email and password match one of the user records)
```swift
         let email = emailField.text!
let password = passwordField.text!
        
PFUser.logInWithUsername(inBackground: email, password: password) { (user, error) in
    if user != nil {
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    } else {
        print("Error: \(error?.localizedDescription ?? "There was an error logging in!")")
    }
}
```
   - Sign Up Screen
      - (Create/POST) Create/Register a new user object
   - Home Screen
      - (Read/GET) All posts in the database, will be sorted by time created (newest appears first)
      - (Update/PUT) Add a like to the Likes array for the specific post object
   - Create Post Screen
      - (Create/POST) Create a new post object
   - Post Detail Screen
      - (Read/GET) Query the specific post object for which to display additional details
      - (Create/POST) Create a new comment object for a specific post
      - (Update/PUT) Add a like to the Likes array or comment to the Comments Array for the specific post object
   - Profile Screen
      - (Read/GET) Query logged in user object
      - (Update/PUT) Update either the profile image or the bio associated with the user
