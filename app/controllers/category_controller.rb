class CategoryController < ApplicationController
  def index
  	@q = Article.ransack(params[:q])
  	@articles=@q.result.order(:cached_votes_score => :desc).joins(:category,:readonuser).where(:categories=>{name: params[:id]} ).page(params[:page]).per(20)
  	@categories =Category.all
  	@breadcrumb = [ 
          {:name => 'Home', :link => root_path },
          {:name => 'Articles', :link => articles_path },
          {:name => params[:id], :link => category_article_path(params[:id]) },
    ]
  end

end
