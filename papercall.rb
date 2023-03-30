require 'watir'
require 'webdrivers'
require 'io/console'
#Gets your Google login info
def get_creds()
    print "Google Username: "
    username = gets.chomp
    #Different from regular gets to make sure passwords stay obfuscated :)
    password = IO::console.getpass "Google Password: "
    return username, password
end
#Locators for the google authentication stuff
google_signin = "/html/body/div[1]/div/div/ul[1]/li[1]/a/span"
username = "//*[@id='identifierNext']/div/button"
password = "//*[@id='passwordNext']/div/button"
#Gets creds
creds = get_creds()
#Initialises the browser
b = Watir::Browser.new :edge
#Takes us to the CFP
b.goto("https://www.papercall.io/cfps/5435/submissions/new")
#Does the google auth stuff
b.element(xpath: google_signin).click
b.text_field(:type => "email").set creds[0]
b.button(xpath: username).click
b.text_field(:type => "password").set creds[1]
b.button(xpath: password).click
#Works through the form, making the relevant submissions for each field
b.text_field(:id => "submission_talk_attributes_title").set "Web Browser Automation: How to be more robot, easily!"
b.element(:id => "submission_talk_attributes_abstract").set "Who isn’t trying to get lazier? In this talk, I’m going to show you how easy it is to build scripts to automate practically anything you could want to do in a web browser. We’ll create a ‘my first login’ script, weaponise it, then learn how to build web scrapers, shopping bots and other fun stuff."
b.select_list(id: "submission_talk_attributes_talk_format_id").options[1].select
b.element(:id => "submission_talk_attributes_description").set "Web applications are inescapable. We use them for work, we use them for leisure, we use them for everything between. As front-ends get sharper, sleeker and more user friendly, back-ends become deeper, more intricate and complex.

Scripting can be a great way to speed up your interactions with applications and improve your productivity, but these increasingly more convoluted back-ends are making it harder and harder to use the internet like a robot - here’s where browser automation shines and sparkles (and not only that, but it’s also unbelievably straightforward!).

In this talk, we’ll look at how automating clicks and keystrokes on the front-end gets the browser to do most of the heavy lifting for you, meaning you can swerve messy back-ends and quickly develop scripts to optimise your workflow or generate proof-of-concepts for attacks.

We’ll start with a basic anatomy lesson on application front-ends, then look at how easy it is to digest that information into a simple authentication script, before considering how that could be further developed and weaponised. After this, we’ll branch out into things like page scrapers, shopping bots and other fun little tools that would be a nightmare to build through conventional web scripting."
b.element(:id => "submission_talk_attributes_notes").set "I've been testing applications and building bots for around three years now, but I've had a lifelong obsession with the never-ending pursuit of laziness. In fact, I wrote a browser automation script to submit this CFP, which can be found here: https://github.com/NaClGOAT/b5b1491d-cd9c-448b-aa65-dfc6ed98545b

In addition, I've been involved with presentations, training and workshops for over 10 years and pride myself on my ability to translate complexity into plain English.

The technical requirements for this talk are low  - just a screen for the slides."
b.element(:xpath => "//*[@id='new_submission']/div[1]/div/div/div[4]/div/div/input").set "red team,scripting,ruby,web,browser,automation,appsec"
b.element(:id => "submission_profile_attributes_name").set "Dan"
b.element(:id => "submission_profile_attributes_twitter").set "NaClGOAT"
b.element(:id => "submission_profile_attributes_company").set "Pen Test Partners"
b.select_list(id: "submission_profile_attributes_shirt_size").options[3].select
b.element(:id => "submission_profile_attributes_bio").set "After 6 years of working in gigs and events with no professional IT experience, I decided I wanted to work in cyber security. Fast forward 11 months and I had my OSCP in hand and I got my first job as a pentester.

3 and a bit years on and I'm still chasing laziness, but now I use scripts and bots instead of podgers and drum key drill bits."
b.element(:id => "submission_additional_info").set "Thanks for taking the time to review my submission!"
#Submits the form :)
b.element(:xpath => "//*[@id='new_submission']/div[5]/button").click