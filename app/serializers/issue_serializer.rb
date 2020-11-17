class IssueSerializer < ActiveModel::Serializer
  attributes :id, :author, :subject, :description, :project_id, :user_id,:comments_count

  has_many :comments, if: -> { should_show_comments }

  def should_show_comments
    @instance_options[:show_comments]
  end

  def author
    object.user.name
  end

  def comments_count
    object.comments.size
  end
=begin
  def comments
    comments = []
    object.comments.each do |comment|
       comments[:author] = comment.user.name
       comments[:details] = comment.body
       comments[:created_at] = comment.created_at
    end
    comments
  end
=end
end
