module Parser
  class PageParser
    attr_reader :input_link

    def initialize(input_link)
      @input_link = input_link

      @all_products_from_page = []
    end

    def result
      get_file

      get_the_required_values
      get_collection_value
    end

    private

    attr_reader :found_values, :values, :quantity_positions, :all_products_from_page

    def get_file
      @values = Nokogiri::HTML(open("#{input_link}"))
    end

    def get_the_required_values
      @found_values ||= values.xpath(".//div//h1/text()[2]", ".//div//ul//span[@class='attribute_name']", ".//div//ul//span[@class='attribute_price']", ".//div//span[@id='view_full_size']/img/@src" ).map do |link|
        link.content
      end
    end

    def get_collection_value
      get_quantity_positions
      index = 1

      while index <= quantity_positions
        @all_products_from_page << ["#{found_values[0]} - #{found_values[index]}", "#{found_values[index + quantity_positions]}", "#{found_values.last}"]

        index += 1
      end

      all_products_from_page
    end

    def get_quantity_positions
      @quantity_positions = (found_values.size - 2)/2
    end
  end
end

