class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy,:upvote,:downvote]
  before_action :authenticate_readonuser!, :except => [:index,:show]


  # GET /articles
  # GET /articles.json
  def search
    index
    @breadcrumb = [ 
                    {:name => 'Home', :link => root_path },
                    {:name => 'Search', :link => search_articles_path }
                  ]    
    render :index
  end

  def index
    @breadcrumb = [ 
                    {:name => 'Home', :link => root_path },
                    {:name => 'Articles', :link => articles_path }
                  ]
    query
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    index
    @breadcrumb = [ 
                    {:name => 'Home', :link => root_path },
                    {:name => 'Articles', :link => articles_path },
                    {:name => @article.title, :link => article_path(params[:id]) },
                  ]
  end

  # GET /articles/new
  def new
    index
    @breadcrumb = [ 
                    {:name => 'Home', :link => root_path },
                    {:name => 'Articles', :link => articles_path },
                    {:name => 'New Article', :link => new_article_path }
                  ]
    @article = current_readonuser.articles.build
  end

  # GET /articles/1/edit
  def edit
    index
  end

  # POST /articles
  # POST /articles.json
  def create
    index
    @article = current_readonuser.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def upvote
      @article.upvote_from current_readonuser
      redirect_to :root
  end

  def downvote
      @article.downvote_from current_readonuser
      redirect_to :root
  end 


  private


    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :category_id,:image, :tag_list)
    end
end
