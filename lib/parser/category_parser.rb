module Parser
  class CategoryParser
    def initialize
      @found_links =                []
      @collection_quantity_pages =  []
    end

    def print
      get_quantity_pages
      get_all_links_to_products
      create_collection_products

      print_result
    end

    private

    attr_reader :page, :found_links, :number_pages, :collection_quantity_pages, :all_products

    QUANTITY_PAGES_SEARCH = ".//div//div[@id='pagination_bottom']//ul//li[last()-1]/a/span"
    LINK_PRODUCT_SEARCH = ".//div//a[@class='product_img_link']/@href"

    def get_page(link)
      @page = Nokogiri::HTML(open("#{link}"))
    end

    def get_quantity_pages
      get_page(ARGV[0])

      page.xpath(QUANTITY_PAGES_SEARCH).each do |link|
        collection_quantity_pages << link.content
      end

      @number_pages = collection_quantity_pages[0].to_i
    end

    def get_all_links_to_products
      if number_pages == 0
        get_links_to_products
      else
        index = 1
        while index <= number_pages
          get_page("#{ARGV[0]}?p=#{index}")
          get_links_to_products

          index += 1
        end
      end

      found_links
    end

    def get_links_to_products
      page.xpath(LINK_PRODUCT_SEARCH).each do |link|
        @found_links << link.content
      end

      @found_links << ARGV[0] if found_links.size == 0
    end

    def create_collection_products
      @all_products ||= found_links.map do |link|
        PageParser.new(link).result
      end
    end

    def print_result
      printer = Printer.new

      printer.print_in_file(all_products)
    end
  end
end
