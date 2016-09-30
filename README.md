
####To run locally:  
gem install sinatra  
gem install minitest  
gem install minitest-rg    
gem install json         
gem install sinatra sinatra-contrib
- go to (http://localhost:4567/) in your browser.  

###Technologies and Design Principles:   
As the test is for a Ruby developer position, I have decided to use Ruby & Sinatra 

It was built using TDD approach. The gem used for unit testing is miniTest.  

To make the web page responsive I have used bootstrap.
I have decided to use bootstrap because there is only one function written in Javascript and the function is written using jQuery. 

###Notes

As the endpoint specified in the requirements was broken I have used as endpoint:
```
https://still-scrubland-9880.herokuapp.com/bill.json
```

# Bill unattended test

## Task

To display a customer's Sky bill

## Requirements

* Complete the task in a language of your choice using whatever tools or frameworks that you want.
* Must consume bill JSON from endpoint: 
```
http://safe-plains-5453.herokuapp.com/bill.json
```
* JSON must be consumed by a server acting as a proxy.
* Provide a README on how to run your app or, if you deploy it online, a URL to your app. 

## What we're looking for

* TDD/BDD
* Simple and eloquent code
* Knowledge of front end development
* Bill should be easy to understand (good user experience)