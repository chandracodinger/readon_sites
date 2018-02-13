class TagsController < ApplicationController
  def index
  	query_tag
  	@breadcrumb = [	
					{:name => 'Home', :link => root_path },
          {:name => params[:tag], :link => tag_path }
				  ]
  end
  def show
  	query_tag
  	@breadcrumb = [	
					{:name => 'Home', :link => root_path }
				  ]
  end
end
