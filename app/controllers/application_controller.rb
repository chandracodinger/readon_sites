class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  ActsAsTaggableOn.remove_unused_tags = true
  ActsAsTaggableOn.delimiter = ' '
  before_action :tag_cloud
  before_action :right_sidebar
  before_action :query_accordion  
	
  before_action :instantiateAdmin

  def instantiateAdmin
    @admin = Admin.new
  end
  def query
    @q = Article.ransack(params[:q])
    @articles = @q.result.order(:cached_votes_score => :desc).includes(:readonuser,:category).page(params[:page]).per(10)
    @categories =Category.all
	end

  def comments_per_user
    @comments=Comment.joins(:article => :readonuser).where(:readonusers=>{:id => current_readonuser.id})
  end

  def article_per_user
    @article_user=Article.where(readonusers_id: current_readonuser.id)
  end

  def query_tag
    @q = Article.ransack(params[:q])
    @articles = @q.result.order(:cached_votes_score => :desc).includes(:readonuser,:category).tagged_with(params[:tag]).page(params[:page]).per(20)
    @categories =Category.all
  end

  def query_carousel
    @c=Article.order(:cached_votes_up).includes(:readonuser,:category).limit(5)
  end

  def right_sidebar
    @right_sidebar=Article.order("RANDOM()").limit(7)
  end


  def query_accordion
    @accordion=Article.all.order(:cached_votes_up=>:desc).limit(3)
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me,:avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end


  def tag_cloud
    @tags = Article.tag_counts_on(:tags)
  end


end
