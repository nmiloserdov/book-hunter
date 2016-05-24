#!/usr/bin/env ruby

require 'telegram/bot'
require 'byebug'

require_relative "../lib/book_hunter/messages.rb"
require_relative "../lib/book_hunter/searcher.rb"
require_relative "../lib/book_hunter/categories.rb"
require_relative "../lib/book_hunter.rb"

BookHunter.start
