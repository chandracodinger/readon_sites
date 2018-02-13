class DashboardController < ApplicationController
before_action :authenticate_admin!, :except => [:index,:show]
before_action :authenticate_readonuser!, :except => [:admin]
  def index
  	breadcrumb
    article_per_user
    query
    comments_per_user
    @articles = @articles.where(readonuser_id: current_readonuser.id)
  end

  def show
    breadcrumb
    article_per_user
    query
    comments_per_user
    @articles = @articles.where(readonuser_id: current_readonuser.id)
  end

  def admin
  end

  private
  def breadcrumb
  	@breadcrumb = [	
					{:name => 'Dashboard', :link => dashboard_path }
				  ]
  end
end
