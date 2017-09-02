#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'csv'

class Parser
  def initialize
    @found_values =      []
    @index =             1
    @record_collection = []
  end

  def result
    get_file

    get_the_required_values
    write_in_csv
  end

  private

  attr_reader :found_values, :index, :values, :quantity_positions

  def get_file
    @values = Nokogiri::HTML(open("#{ARGV[0]}"))
  end

  def get_the_required_values
    values.xpath(".//div//h1/text()[2]", ".//div//ul//span[@class='attribute_name']", ".//div//ul//span[@class='attribute_price']", ".//div//span[@id='view_full_size']/img/@src" ).each do |link|
      @found_values << link.content
    end
  end

  def write_in_csv
    get_quantity_positions

    CSV.open("#{ARGV[1]}.csv", 'wb') do |writer|
      while index <= quantity_positions
        writer << ["#{found_values[0]} - #{found_values[index]}", "#{found_values[index + quantity_positions]}", "#{found_values.last}"]

        @index += 1
      end
    end
  end

  def get_quantity_positions
    @quantity_positions = (found_values.size - 2)/2
  end
end

parser = Parser.new
parser.result
