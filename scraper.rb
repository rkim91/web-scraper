require 'httparty'
require 'nokogiri'
require 'byebug'


def scraper
  url = "https://blockwork.cc"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  job_listings = parsed_page.css('div.listingCard') #50 jobs
  per_page = job_listings.count #50
  total = 2293 

  jobs = []

  job_listings.each do |job_listing|
    job = {
      title: job_listing.css('span.job-title').text,
      company: job_listing.css('span.company').text,
      location: job_listing.css('span.location').text,
      url: "https://blockwork.cc" + job_listing.css('a')[0].attributes["href"].value
    }

    jobs << job
  end
  byebug
end

scraper
