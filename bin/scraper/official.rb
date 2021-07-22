#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'open-uri/cached'
require 'pry'

class MemberList
  # details for an individual member
  class Member < Scraped::HTML
    field :name do
      tds.last.text.tidy
    end

    field :position do
      "Minister of #{tds.first.text.tidy}"
    end

    private

    def tds
      noko.css('td')
    end
  end

  # The page listing all the members
  class Members < Scraped::HTML
    field :members do
      member_container.map { |member| fragment(member => Member).to_h }
    end

    private

    def member_container
      noko.css('.hentry').xpath('.//tr[td]')
    end
  end
end

url = 'https://opm.gov.so/en/cabinet'
puts EveryPoliticianScraper::ScraperData.new(url).csv
