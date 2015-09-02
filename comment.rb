class Comment < Post

  attr_reader :content

  def initialize(content)
    @content = content
  end

end