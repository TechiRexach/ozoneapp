class HomeController < ApplicationController
  def index
   

    

  def zipcode
    @zip_query = params[:zipcode]
    if params[:zipcode] == ''
      @zip_query = 'You forgot to enter a zipcode'
    elsif params[:zipcode]
      # Do api search

      require 'net/http'
      require 'json'
      @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' +  @zip_query + '&distance=0&API_KEY=35BA38FE-9D87-488B-AAA7-1BB47AEB66C6'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)

      if @output.empty?
        @final_output = 'Error'
      elsif !@output
        @final_output = 'There is no information for this zip code'
      else
        @final_output = @output[0]['AQI']
      end
  
      if @final_output == 'Error'
        @api_color= 'gray'
        @api_message = ''
      elsif @final_output <= 50
        @api_color = 'green'
        @api_message = 'Good. Air quality is satisfactory, and air pollution poses little or no risk.'
      elsif @final_output >= 51 && @final_output <= 100
        @api_color = 'yellow'
        @api_message = 'Moderate. Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution.'
      elsif @final_output >=  101 && @final_output <= 150
        @api_color = 'orange'
        @api_message = 'Unhealthy for Sensitive Groups. Members of sensitive groups may experience health effects. The general public is less likely to be affected.'
      elsif @final_output >= 151 && @final_output <= 200
        @api_color = 'red'
        @api_message = 'Unhealthy. Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects'
      elsif @final_output >= 201 && @final_output <= 300
        @api_color = 'purple'
        @api_message = 'Very Unhealthy. Health alert: The risk of health effects is increased for everyone.'
      elsif @final_output >= 301 
        @api_color = 'brown'
        @api_message = 'Hazardous. Health warning of emergency conditions: everyone is more likely to be affected.'
      end
      
    end

    end
  end

end
