require 'yaml'
require 'byebug'
require 'book_hunter'

namespace :books do
  desc "Clean db"
  task clean_db: :environment do
    Book.all.destroy_all
    Country.all.destroy_all
    Category.all.destroy_all
  end
  desc "Load books from yml file"
  task load_books: :environment do
    books = YAML.load_file("#{BookHunter.root}/tmp/books.yml") 
    books.each do |book|
      create_category(book.last)
      create_country(book.last)
      create_book(book.last)
    end
  puts "Categories count #{Category.all.count}"
  puts "Books count #{Book.all.count}"
  puts "Countries count #{Country.all.count}"
  end

  desc "Print category and books"
  task print_category: :environment do
    category = Category.all
    category.each do |c|
      puts "'#{c.name}' count: #{c.books.count}"
    end
  end

  desc "Print country and books"
  task print_country: :environment do
    country = Country.all
    country.each do |c|
      puts "'#{c.name}' count: #{c.books.count}"
    end
  end
end

def create_category(book)
  category = Category.find_by(name: book.dig(:category))
  unless category.present?
    Category.create(name: book.dig(:category))
  end
end

def create_country(book)
  country = Country.find_by(name: book.dig(:country))
  unless country.present?
    Country.create(name: book.dig(:country))
  end
end

def create_book(book)
  new_book = Book.new(author: book.dig(:author), 
    title: book.dig(:title), origin_name: book.dig(:origin))
  return if Category.find_by(name: book.dig(:category)).nil?
  puts "erorr" if Country.find_by(name: book.dig(:country)).nil?
  return       if Country.find_by(name: book.dig(:country)).nil?

  new_book.categories.push Category.find_by(name: book.dig(:category))
  new_book.countries.push  Country.find_by(name: book.dig(:country))
  new_book.save
end
