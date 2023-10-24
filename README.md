# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructionsl

rails generate migration CreateUsers name:string photo:string bio:text posts_counter:integer
rails generate migration CreatePosts title:string text:text likes_counter:integer comments_counter:integer author:references

rails db:migrate