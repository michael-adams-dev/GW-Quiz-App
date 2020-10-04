# T1A3 - The Good Weekend Quiz Terminal Application

#### Link to GitHub repository

[GW Quiz App](https://github.com/michael-adams-dev/GW-Quiz-App)



### Installation and Setup

To be able to run this application you will need to install some dependencies. Follow the instructions below to do this. 

Please note, to run this application, you will need a computer that runs Linux or macOS. The Windows operating system won't work.

1. First install asdf via [this guide](https://asdf-vm.com/#/core-manage-asdf)
2. Now install the asdf-ruby plugin using [this guide](https://github.com/asdf-vm/asdf-ruby)
3. Now in your command line terminal, enter:

```
asdf install ruby
```

4. Now you need to install git. Head to [this page](https://git-scm.com/downloads) and download git for whichever operating system your computer uses.
5. Once downloaded, begin the installation and follow the guide to install git on your computer.
6. Git clone the app into your home directory by running the command below in your terminal.

```
git clone https://github.com/michael-adams-dev/GW-Quiz-App.git ~/GW_Quiz_App
```

7. Run the set up file to install the app Ruby gems required by the app by entering the command below into your terminal.

```
~/GW_Quiz_App/bin/setup
```

- The list of required gems is:

```ruby
gem "open-uri", "~> 0.1.0"

gem "nokogiri", "~> 1.10"

gem "tty-prompt", "~> 0.22.0"

gem "down", "~> 5.2"

gem "rtesseract", "~> 3.1"

gem "byebug", "~> 11.1"

gem "terminal-table", "~> 1.8"

gem "rubocop", "~> 0.92.0"

gem "json", "~> 2.3"
```

8. Open either your .bash_profile or your bashrc file by entering one of the commands below into your terminal.

```
code ~/.bash_profile # recommended for macOS users

code ~/.bashrc # recommended for Linux users
```

9. In the whichever file you opened, add this line at the end:

```
export PATH=$PATH:$HOME/GW_Quiz_App/bin
```





### Software Development Plan

#### Statement of Purpose and Scope

The app is designed to be able to find, download and run the Good Weekend (GW) quiz, which comes in the weekly addition of the good weekend magazine. The app works by searching through images from the GW quiz Instagram page (through another site called [Picuki](https://www.picuki.com/profile/goodweekendquiz)) until it finds either the last or the second last full quiz image that's been posted, depending on the user's selection.

It will then:

1. Find the URL of this post.
2. Go to that page.
3. Find the URLs of the questions and answers images.
4. Download these files.
5. Convert the text on these images to strings.
6. Manipulate the strings into hashes each with 25 keys (integers 1 - 25) and either 25 questions or answers.

Once it has the data in this form it will run the quiz by printing each question to the screen and allowing the user to either skip or answer now (by typing and hitting enter/return). Skipped answers can be answered at the end, otherwise the user can enter nothing.

Once all of the questions are finished, answers will be run by printing the question again along with the user's answer, followed by the actual answer. The user has the opportunity to award themselves points here if they got  some or all of the question correct. A maximum of one point per question is allowed and the overall score will be printed at the end. Once the quiz is finished it is stored in a quiz database written to a json file.

The app creates a simple but interactive way to enjoy the quiz from the terminal. Its ability to find the quiz data and turn it into something that works with minimal input or effort from the user is a core function. The app was made because the GW quiz is something I've bene doing weekly with my mum and siblings over video call. Normally my sister will screenshot the questions and answers, send them to me and I'll run the quiz. However, with the app, I'll have access to these questions and answers in a nice format that allows us to easily track how we go.

The target audience is my family or anyone else who likes doing the quiz or might like to start doing it. We do it as a team and I think that's how most people do this quiz. It's designed as a cooperative quiz rather than a competitive one.

It would be used by one or more people getting together (could be over a call), generating their selected quiz and then running it. Normally you would get the question, have a bit of a discussion about what you think it is, come to a consensus and either answer or pass. Once you've done a quiz you can re-do it if you want from the quiz DB but it's not really designed for that.



### Features

#### 1. Web Scraping

The app has the ability to search through the [Picuki page](https://www.picuki.com/profile/goodweekendquiz) for the last or second last quiz image. It will ignore the images that only have a single question on them, while looking for the proper quiz images.

Once it finds the right image, it get the URL for that post and goes to that URL next. Then it finds the question and answers images while ignoring the others and downloads the image files.

It performs the web scraping using the `Nokogiri` Ruby gem and finds the correct URLs and images using a combination of CSS selectors and  XPath.



#### 2. Image to String Conversion

Once it has the image files downloaded, the app can convert the text in these images to strings. It does this with the `RTesseract` gem by turning the downloaded image files into `RTesseract` objects and then calling the `to_s` method on these objects. Questions and answers are returned as strings. 

This process is the biggest factor in the relatively slow speed of the app. It normally takes about 15-30 seconds to go from the user choosing which quiz to download to the quiz being ready to go.



#### 3. String Manipulation

After questions and answers have been converted into strings, they're manipulated into hashes as an attribute of a quiz object. There are a number of steps to this manipulation but the overall aim is to:

1. Remove unnecessary words and characters.
2. Find patterns in the string so they can be separated into individual questions and answers.
3. Sort the questions and answers into the right order.
4. Convert them to hashes and return a questions hash and and answers hash.

The question and answer strings have slight differences so they mostly require their own methods for this manipulation to work.



#### 4. Menus

The app has a few menus generated with the `tty-prompt` Ruby gem. It has a main menu allowing the user to make their quiz selection. At this stage they can only download a quiz from the previous two weeks as it's assumed that (a): you either do the quiz every week or two or (b): if you don't, you're more likely to want to do a current quiz than one from more than a few weeks ago.

Other than these selections, the user can also look up the quiz DB to see previous quizzes as well as checking their score. 

There are a couple of sub menus in the quiz allowing the user to answer now or skip a question, as well as choosing the go back to main menu after quiz is downloaded instead of running it.




#### 5. Quiz

The quiz feature will display the quiz questions sequentially and allow the user to either type in their answer or skip and come back to the question at the end. It's a fairly simple process of looping through the questions hash, printing the question and then storing the response in a new hash. Questions that have been skipped by the user can be answered after the initial run through of questions.

After this, the user is shown the questions, their answer, and the actual answer. They then have the opportunity to give themselves a score for each question. The user will receive an error message if they enter a fraction or a number above one. They will then be prompted to retry. 

At the end, they score tallied for and presented to the user along with a message that depends on how they went.



#### 6. Quiz DB

Once quizzes are downloaded, a new quiz object is created which is stored in a quiz database object. When the app beings, the quiz DB will read a json file with previous quizzes on it so that the user can see past quizzes and scores. Users have the ability to look up these quizzes, see their scores and run any quiz that has been downloaded and store.

When the app closes, it writes everything in the quiz DB back to the json file so all new and old quizzes are maintained.



### User Interaction

#### Menu

When the app begins running, the user will receive a greeting and then be presented with the main menu. Above the menu will be a message letting the user know that they can download a quiz from the last two weeks, or select from a prior quiz. 

They will then see the menu options below which can be navigated with the up/down arrow keys on a keyboard and selected using the enter/return key. `Tty-prompt` instructs them how to do this and menu options are worded so there is no ambiguous options.



#### Quiz

When the quiz is downloaded, users are given the option to being the quiz or return to main menu. Again, `tty-prompt` is utilised to facilitate their selection.

If they choose to begin the quiz, a message is printed to the screen informing the user how the quiz will work (i.e. question printed, user types response and hit enter/return to submit answers, questions can be skipped and returned to). They're then prompted to hit enter/return to begin.

After all questions have been display initially, the user receives a new message telling them they can now answer any questions that were skipped. If they can think of any answer, they can just hit enter/return to pass.

Now the screen is cleared and the user gets a new message that tells them they will now go through the answers. The message says after the actual answers are displayed, they will receive an opportunity to award themselves points which can't be fractions or greater than one. 

If they enter a number that's greater than one or a fraction, they will receive a message that their input was invalid and and they are then given the opportunity re-enter their score.



#### Quiz DB

The user can reach the quiz DB from the main menu and it will be displayed in table form. Each quiz will have an ID as an identifier, a date and a score out of 25. If they quiz hasn't been completed yet, the score will display -/25 to indicate it hasn't been attempted.

A message will be displayed above the table letting the user know they can navigate through the table using the arrow keys with options to run any of the quizzes there by hitting enter/return. They will also have their high score, low score, and average score display above the table.



#### Web scraping, image to string conversion, data manipulation

These features all have minimal user interaction as they're design to initialise the quiz after the user makes their quiz selection from the main menu. However, they're still vital to the user experience as without them, the user couldn't access any new quizzes.

The user will initiate this process with either the first or second option on the main menu. They will then need to wait while the quiz is initiated. As these steps are performed, messages are printed to the screen when each new step in the process begins. This is done so the user knows that the initiation is working. A random fun fact is generated and printed to the screen during the image to string conversion step. This is to give the user something interesting to read while they wait for the final and longest step to completed.

If the user attempts to perform this download while not connected to the internet, they will be alerted that no internet connection is detected and that they need one to download the quiz. They're then redirected to the main menu so they can check their connection and try again.



### Diagrams

#### Data Flow Diagram

The DFD below shows the flow of data from when a user chooses to download a quiz to the completion of the quiz.

![Data Flow Diagram](docs\Data_Flow_Diagram.png)





### Implementation Plan

[Link to Trello board](https://trello.com/b/sLFCVhWQ/gw-quiz-app)



### Tests

Test are automatic and can be run with:

``` 
rspec spec
```





