## About persistent-task-status

A node.js module, utilizing mongoose, that allows you to persist sequential task information for potentially long running, faulty tasks.

Ok, now that we have that one liner out of the way let me explain the ratio behind this: We have some background processes that must be run in certain intervals in a certain fashion. One of those processes checks the iTunes EPF server hourly to find out if new files have been posted. If so, it needs to perform a couple steps, some in sequential order, some in parallel. The tasks are very heavy, involving gigabytes of data being shuffled around, and there is always something failing. So for this to work we need some persistent store that lets us keep track of what is going on with the tasks, and also get an insight into the current state (percentage complete). This is somewhat different from your typical message queue, which is why I created this module.

The module uses mongodb because that is our primary database. Also there are two DaaS (Database as as Service) providers in the wild that offer a free plan: http://mongohq.com and http://mongolab.com.

This module was written in Coffeescript, not because we don't understand Javascript but because we are significantly more productive in Coffeescript. Haters gonna hate :)

[![Build Status](https://secure.travis-ci.org/freshfugu/persistent-task-status.png])](http://travis-ci.org/freshfugu/persistent-task-status)

Please note that travis, at this point in time, does not test this correctly due to lack of mongodb. Working on that.

## Usage


### Coffeescript

    
### Javascript


## Advertising :)

Check out http://freshfugu.com and http://scottyapp.com

## Trivia

Listened to lots of Dum Dum Girls while writing this.

## Release Notes

### 0.0.1
* First version

## Internal Stuff

* npm run-script watch
* npm link
* npm adduser
* npm publish

## Contributing to persistent-task-status
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the package.json, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Martin Wawrusch. See LICENSE for
further details.


