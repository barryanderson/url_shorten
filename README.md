> URL Shortener Service

[![Travis Build Status](https://travis-ci.org/barryanderson/url_shorten.svg?branch=master)](https://travis-ci.org/barryanderson/url_shorten)
[![Coverage Status](https://coveralls.io/repos/github/barryanderson/url_shorten/badge.svg?branch=master)](https://coveralls.io/github/barryanderson/url_shorten?branch=master)

# URL Shortener Service

A fast URL shortener implemented with the [Phoenix Framework](https://phoenixframework.org) and [Vue.js](https://vuejs.org/).

The purpose of this project is to provide a simple problem domain for leaning how to develop, test, deploy and maintain Phoenix and Elixir applications.  The application is currently deployed to Heroku at [https://shorten-url-ba.herokuapp.com/](https://shorten-url-ba.herokuapp.com/).

## Running

To start the Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
