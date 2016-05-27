#!/usr/bin/env ruby
ENV['APP_ENV'] ||= ARGV.first # use `bin/console test` to run in test env

require "rubygems"
require "bundler/setup"
require "book_hunter"
require "byebug"
require "pry"

BookHunter.db_connect
Pry.start BookHunter
