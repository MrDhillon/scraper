require_relative './post'
require_relative './comment'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'colorize'

def operation(rurl)

  include Nokogiri
  doc = Nokogiri::HTML(open(rurl),nil,"UTF-8")

  def find_title(doc)
    doc.search('.title a').map { |span| span.inner_text}
  end

  def find_points(doc)
    doc.search('.subtext > span:first-child').map {|span| span.inner_text}
  end

  def find_ID(doc)
    doc.search('.subtext > a:nth-child(3)').map {|link| link['href'].match(/\d+/) }
  end

  def comments_all(doc)
    comments_arr = []
    doc.search('.comment > span:first-child').map do|span|
        comments_arr << span.inner_text
    end
    comments_arr
  end

title = find_title(doc).join("")
points = find_points(doc).join("")
url = rurl
item_id = find_ID(doc).join("")

com_arr = comments_all(doc)

post1 = Post.new(title: title,points: points,url: url,item_id: item_id)
count = post1.comments(com_arr).count
puts "Post title: #{post1.title}".colorize(:green)
puts "Number of Comments: #{count}".colorize(:blue)
puts "points: #{post1.points}".colorize(:light_blue)
puts "Post ID: #{post1.item_id}".colorize(:green)
end



url = ARGV[0]

operation(url)

