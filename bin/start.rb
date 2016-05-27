#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
require 'telegram/bot'
require 'book_hunter'
require 'pg'
require 'byebug'

BookHunter.db_connect
BookHunter.start



