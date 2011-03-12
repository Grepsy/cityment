require 'nokogiri'
require 'open-uri'
require 'date'

URL = 'http://api.at5.nl/v1/news.xml'
TOKEN = 'appsadam_1'
ENV['STATDIR'] = ENV['APP_ROOT'] + '/static'
ENV['EDITOR'] = 'mate'
#CATEGORIES = %w{sport, 112, kort, stad, cultuur, zakelijk, gossip, verkeer}

class Request 
  attr_reader :url, :params, :request
  
  def initialize params = {}, url = URL, token = TOKEN
    @url = url
    @params = params
    self.params[:token] = token
  end
  
  def compile
    @request = url + '?token=' + params[:token]
    params.each_pair do |key, value|
      param = '&' + key.to_s + '=' + value.to_s
      @request += param unless key == :token
    end
    @request
  end
  
  def result
    doc = Nokogiri::XML(open(compile))
    doc.extend Response
  end
  
  def bulk_result
    @params[:num] = 200
    now = Date.today
    docs = []
    12.times do
      @params[:laterthen] = now.prev_month.to_s
      doc = result
      puts "fetched #{now.prev_month.to_s}"
      docs << doc
      now = now.prev_month
    end
    return docs
  end
  
  def to_s
    request
  end
end

module Response
  attr_reader :path
  
  def save name = 'tmp.xml'
    @path = ENV['STATDIR'] + '/' + name
    File.open(@path, 'w') do |f|
      f.puts self.to_xml
    end
  end 
  
  def view
    self.save
    system "mate #{path}"
  end
  
  def first_date
    self.xpath('//item/created_at/text()').to_a.last.to_s
  end

  def items
    self.xpath('/result/items/item')
  end

end

class Array
  def save name = 'month'
    self.each_with_index do |e,i| 
      e.save "#{name}_#{i}.xml" 
    end
  end
end


