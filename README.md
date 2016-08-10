# PerfAlert
_A tool to receive Rigor Optimization alerts for every build of your website_

[![Code Climate](https://codeclimate.com/github/Rigor/PerfAlert/badges/gpa.svg)](https://codeclimate.com/github/Rigor/PerfAlert) [![Build Status](https://travis-ci.org/Rigor/PerfAlert.svg?branch=master)](https://travis-ci.org/Rigor/PerfAlert)

PerfAlert is a free and open-source tool that can alert you if a specific build of your website increases or decreases
the total number of defects it has by leveraging Rigor Optimization scans.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Setup

* Deploy the app to Heroku with the deploy button above or the host of your choice.
* Set the environment variables:
```
# Username you want for authentication
PERFUSER

# Password you want for authentication
PERFPASS

# API key for your Rigor Optimization account
OPTIMIZATION_API_KEY

# ID of the Rigor Optimization test to trigger snapshots for
OPTIMIZATION_TEST_ID

# Slack webhook URL to notify when a snapshot is triggered
SLACK_WEBHOOK_URL
```
* Set up your CI's post deploy webhook endpoint to the url of your app (e.g https://PERFUSER:PERFPASS@your-app.herokuapp.com)

## Dependencies

PerfAlert runs on Ruby version `2.3.1` and Rails version `5.0.0`.

It uses PostgreSQL version `9.5.2` as its DBMS.

Sidekiq version `4.1.2` is used for jobs queing.

## Configuration

### Heroku

To change your heroku deployment configuration, edit the `app.json` file in the root directory. More information on how
to use this file can be found [here](https://devcenter.heroku.com/articles/app-json-schema).

You'll need to install the Heroku Redis add-on in order for Sidekiq to be able to enqueue jobs.
You will also need to install the Heroku Postgres add-on.

Once you have them installed, run `heroku pg:reset DATABASE_URL`. `DATABASE_URL` will have already been configured for you with the
installation of the Heroku Postgres add-on. Once the database is reset, you can run migrations using `heroku run rails db:migrate`.

All that's left is to restart the app with `heroku restart -a app_name`, and you're all set!
### CI

Right now, PerfAlert only supports webhooks sent from Semaphore CI. We plan to add support for more CI webhooks.

### Notifications

Right now, PerfAlert only supports Slack notifications. We plan to add support for more messaging services.

If you wish to change what information is sent to Slack or how it is presented, you will need to change the `slack_worker.rb`
file located in the `app/workers` directory. More information on how to configure the payload sent to Slack can be found [here](https://api.slack.com/incoming-webhooks).
