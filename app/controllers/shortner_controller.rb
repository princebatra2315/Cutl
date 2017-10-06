class ShortnerController < ApplicationController
	
	def index
		@link=Link.new
	end

	def generate
		if(params[:link][:value].blank?)
			link=Link.find_by_url(params[:link][:url])
			if(link!=nil)
				@value=link.value
			else
				@value=SecureRandom.hex.first(6)
				params[:link][:value]=@value
				params[:link][:hits]=0
				Link.create(params_link)
			end
		else
			@value=params[:link][:value]
			link=Link.find_by_value(@value)
			if(link==nil)
				params[:link][:value]=@value
				params[:link][:hits]=0
				Link.create(params_link)
			else
				flash[:success]="Custom Url Already Taken"	
				redirect_to action: 'index'
				return	
			end
		end
		flash[:notice]="localhost:3000/#{@value}"
		redirect_to action: 'index'
	end

	def redirect
		@value=params[:value]
		link=Link.find_by_value(@value)
		@url=link.url
		redirect_to (@url)
	end

	protected
	def params_link
		params.require(:link).permit(:url,:value,:hits)
	end

end
