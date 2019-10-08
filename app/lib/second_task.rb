# frozen_string_literal: true

# Post has many Comments
# Comment has one Author
# Author#username is a string
#
# What problems has this code?

class CommentsController < ApplicationController
  def users_comments
    posts = Post.all
    comments = posts.map(&:comments).flatten
    @user_comments = comments.select do |comment|
      comment.author.username == params[:username]
    end
  end

  # my solution

  def user_comments
    Comment.where(author_id: Author.where(username: params[:username]))
    # first solution (bad)
    # Comment.includes(:author).select { |c| c.author.username == params[:username] }
  end
end
