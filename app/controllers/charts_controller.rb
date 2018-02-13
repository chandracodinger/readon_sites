class ChartsController < ApplicationController
  def index
  end
  def new_users
  	article_per_user
  	render json: @article_user.group_by_day(:created_at).count
  end
end
