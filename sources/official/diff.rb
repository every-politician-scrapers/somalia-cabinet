#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/comparison'

# Not listed on the site
SKIP = [
  ['---', 'Mohamed Hussein Roble', 'Prime Minister of Somalia']
].freeze


diff = EveryPoliticianScraper::DecoratedComparison.new('wikidata.csv', 'scraped.csv').diff
                                         .reject { |row| SKIP.include? row }
puts diff.sort_by { |r| [r.first, r[1].to_s] }.reverse.map(&:to_csv)
