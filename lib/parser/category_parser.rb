module Parser
  class CategoryParser
    def initialize
      @found_links =                []
      @collection_quantity_pages =  []
      @all_products =               []
      @index =                      1
    end

    def print
      get_quantity_pages
      get_all_links_to_products
      create_collection_products
      write_in_csv
    end

    private

    attr_reader :page, :found_links, :number_pages, :collection_quantity_pages, :index, :all_products

    def get_page(link)
      @page = Nokogiri::HTML(open("#{link}"))
    end

    def get_quantity_pages
      get_page(ARGV[0])

      page.xpath(".//div//div[@id='pagination_bottom']//ul//li[last()-1]/a/span").each do |link|
        collection_quantity_pages << link.content
      end

      @number_pages = collection_quantity_pages[0].to_i
    end

    def get_all_links_to_products
      if number_pages == 0
        get_links_to_products
      else
        while index <= number_pages
          get_page("#{ARGV[0]}?p=#{index}")
          get_links_to_products

          @index += 1
        end
      end

      found_links
    end

    def get_links_to_products
      page.xpath(".//div//a[@class='product_img_link']/@href").each do |link|
        @found_links << link.content
      end

      @found_links << ARGV[0] if found_links.size == 0
    end

    def create_collection_products
      found_links.each do |link|
        parser = PageParser.new(link)
        @all_products << parser.result
      end

      all_products
    end

    def write_in_csv
      CSV.open("#{ARGV[1]}.csv", 'wb') do |writer|
        all_products.each do |data|
          data.each do |data_inside|
            writer << ["#{data_inside[0]}", "#{data_inside[1]}", "#{data_inside[2]}"]
          end
        end
      end
    end
  end
end
