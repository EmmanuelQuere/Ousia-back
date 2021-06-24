# Ousia -- Admin application

## About

Ousia reinvents the way cocktails are enjoyed, offering sophisticated non-alcoholic alternatives. Inspired by classics or pure creations, each of the cocktails in the range is designed to be a complex and nuanced alternative to an alcoholic equivalent. Find out more about the brand [here](https://www.facebook.com/ousiadrinks/)

### The app

This web application serves as a back-end for the Ousia client application, as well as an admin interface providing Ousia teams with a 360 vision on their customers.
On the app, a connected administrator can:
* Visualize, create, edit and delete data related to products, customers, orders, current carts as well as store locations.
* Update product pictures
* Indicate if a store location is a retail sales point or a bar or a restaurant where Ousia drinks can be consumed

Find the client app in production on Heroku [here](https://ousia-front.herokuapp.com/) and the admin interface [here](https://ousia-back.herokuapp.com/)!

### Technical specs

This Ruby on Rails app acts as a back-end server for a Next.js front-end app available [here](https://github.com/EmmanuelQuere/Ousia-front/). It was built with Ruby 2.7.1 and Rails 6.1.3 in API mode, with a PostGreSQL database.

It provides an authentication system with the following gems:
* gem "devise"
* gem "devise-jwt"
* gem "rack-cors"

It initiates mailing deliveries when creating an account or an order through the following gems:
* gem 'mailjet'
* gem 'letter_opener'

Other gems employed:
* gem "dotenv" and gem "dotenv-rails" for global variable management
* gem "faker" for database seeding
* gem "aws-sdk-s3" for image uploading and management through Active Storage and Amazon AWS3 storage service
* gem "stripe" for payment activation in the store
* gem "rails_admin" for generating the admin interface

## How to run locally

After cloning this repository (or downloading and unzipping it), run `bundle install` in the CLI to install necessary gems, and `rails db:create db:migrate db:seed` to set up the database. Create a `.env` file at the root of the directory and add a randomly generated DEVISE_JWT_SECRET_KEY secret key, which you can obtain by running `rake secret` in the CLI. The `.env` file will also need Stripe, Mailjet and a redirect URL towards the front-end website in order to work properly.

Run `rails server` to start the server on local port 3000.

## Team

* [Ariane](https://github.com/arejl)
* [Caroline](https://github.com/Caro407)
* [Emmanuel](https://github.com/EmmanuelQuere)
* [Erwann](https://github.com/erwannlenoach)
