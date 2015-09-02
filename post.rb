# require 'nokogiri'
# require './comment'
require 'nokogiri'
require 'pry'

doc = Nokogiri::HTML(File.open('post.html'))

class Post

  @@comments_obj_list = []

  attr_reader :title, :url, :points, :item_id

  def initialize(title: nil,points: nil,url: nil,item_id: nil)
    @url = url
    @title = title
    @points = points
    @item_id = item_id
  end

  def comments(com_arr)
    com_arr.each do |comment|
    @@comments_obj_list << Comment.new(comment)
    end
  end

  def add_comment(obj)
    @@comments_obj_list << obj
  end

  def comment_list
    @@comments_obj_list
  end

end

