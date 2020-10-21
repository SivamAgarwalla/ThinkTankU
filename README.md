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
- **Mobile:** This app would be primary developed using Swift for iOS but then could be later ported to support Android as well. In theory, a web application
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

* User can log in and see feed customized based on their selections/filters
* User can pick which startups to follow based on industry
* Register your startup and add members/description
* Profile pages for user and startups
* Settings (can be appended to user page)


**Optional Nice-to-have Stories**

* Messaging feature to allow students to communicate directly on the app
* Random Company profile finder for exploration
* App theme changes based on university


### 2. Screen Archetypes

* Log in Screen
   * User that has an account registered can enter their username and password to sign into the application.
   * If the user does not have an account, there will be a Sign Up button on the button of screen where they can join.
* Sign Up Screen
   * User can enter their Name, Email, Password, School Name, Current Year, Startup Name (Optional) to create an account.
* Home Screen
   * This screen will serve as the main news feed and will contain posts regarding sharing startup ideas, open discussion about the viability of certain ideas, and      posts where either students are looking to work for a startup or startups are looking for students with specific skill sets.
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

* [fill out your first tab]
* [fill out your second tab]
* [fill out your third tab]

**Flow Navigation** (Screen to Screen)

* [list first screen here]
   * [list screen navigation here]
   * ...
* [list second screen here]
   * [list screen navigation here]
   * ...

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
