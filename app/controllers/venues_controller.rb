class VenuesController < ApplicationController
  # GET /venues
  # GET /venues.xml
  def index
#    @events = Event.all(:order => 'venue', :group => "venue")
    if (params[:all])
      @events = Event.all(:order => 'venue', :select => "distinct(venue)")
    else
      cool_venues = ['Bottom of the Hill', 'Cafe Du Nord', 'Fillmore', 'Great American Music Hall', 'Independent' , "Slim's", 'Warfield']
      @events = Event.all(:order => 'venue', :group => "venue", :select => "distinct(venue)", :conditions => {:venue => cool_venues})
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /venues
  # GET /venues.xml
  def all
    @events = Event.all(:order => 'venue', :group => "venue")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end
end
