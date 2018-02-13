class HomeController < ApplicationController
  def index
  	query
  	query_carousel
  	@breadcrumb = [	
					{:name => 'Home', :link => root_path }
				  ]
  end
end
