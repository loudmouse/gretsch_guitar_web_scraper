#instructions here: https://web.archive.org/web/20151030001313/https://www.distilled.net/resources/web-scraping-with-ruby-and-nokogiri-for-beginners/

require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'Pry'
require 'csv'


#request the page we want to scrape
page = HTTParty.get('https://chicago.craigslist.org/search/msa?query=gretsch+guitar')

#transform the http response into a nokogiri object
parse_page = Nokogiri::HTML(page)

# an empty array where we'll store all the gretsch guitars we find in our craigslist search
guitars_array = []

# this is where we parse the data
parse_page.css('.content').css('.rows').css('.result-row').css('.result-info').css('.result-title').map do |a|
  post_name = a.text
  guitars_array.push(post_name)
end

# this pushes the array of gretsch guitars into the csv file
CSV.open('gretsch_guitars.csv', 'w') do |csv|
   csv << guitars_array
end

# Pry.start(binding)
