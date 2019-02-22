# FriendFramework Test task for Upwork company

__Friend Framework__ is a small framework for web testing using Page Object pattern.  

ver.: 0.9

Created by v.n.zubarev@gmail.com on 19/02/19

***********************************************************************************************
__Preinstall:__

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
- [Selenium WebDriver](https://docs.seleniumhq.org/download/)

***********************************************************************************************

__How To:__

1). First, clone this repo to your laptop or computer using terminal (command line): 
- `$ git clone https://github.com/VovkaZy/FriendFramework.git`

2). After this, change the directory to that, which contain framework files: 
- `$ cd your_dirpath/`

3). Run bundle to install required gems : 
- `$ bundle install`

4). Run test: 
- `$ ruby find_freelancers_with_keyword.rb`
 
5). If you want to change keyword or browser:
- Just change it in test file find_freelancers_with_keyword.rb
  
  Friend is smart enough to get it direct from input.

***********************************************************************************************
__P.S:__ 

- You can use lib/constants/constants.rb, if you want to build more tests in the future:)

__Hack To:__

- If you don't want to download it, you can just try it on my DigitalOcean droplet using ssh (don't forget to ask me 
for credentials in Hangouts)

```
  $ ssh upworkqa@188.166.103.213
  enter credentials
  $ cd /home/upworkqa/FriendFramework/tests
  $ ruby find_freelancers_with_keyword.rb
``` 



