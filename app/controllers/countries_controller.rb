class CountriesController < ApplicationController
	before_filter :set_active_item

  # GET /countries
  # GET /countries.xml
  def index
    @countries = Country.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.xml
  def show
    @country = Country.find(params[:id])
    @visit = (@country.visits & @user.visits).first

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @country }
    end
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
	  @visit = (@country.visits & @user.visits).first
  end

  # POST /countries
  # POST /countries.xml
  def create
    @country = Country.new(params[:country])

    respond_to do |format|
      if @country.save
        format.html { redirect_to(@country, :notice => 'Country was successfully created.') }
        format.xml  { render :xml => @country, :status => :created, :location => @country }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /countries/1
  # PUT /countries/1.xml
  def update
    @country = Country.find(params[:id])

    respond_to do |format|
      if
        case
	         when params[:visited]
		         unless @user.countries.include?(@country)
			         @user.countries << @country
		         end
		         visit = (@user.visits & @country.visits).first
		         visit.visit_date = params[:visit_date].strip.empty? ? Date.today : params[:visit_date]
		         visit.save!
	        else
		        @user.countries.delete(@country) if @user.countries.include?(@country)
        end
        format.html { redirect_to(@country, :notice => 'Country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { redirect_to({:action => :edit, :code => @country.code}, :notice => 'Country was not successfully updated')}
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

	def update_list
		if request.post?
			selected_countries = Country.find(:all, :conditions => {:code => params[:visited].to_a})
			Country.all.each do |country|
				if @user.countries.include?(country)
					@user.countries.delete(country) if !selected_countries.include?(country)
				else
					if selected_countries.include?(country)
						@user.countries << country
						visit = (@user.visits & country.visits).first
						visit.visit_date = Date.today
						visit.save!
					end
				end
			end
		end
		
	end

	private

	def set_active_item
		@active_tab = :countries
	end

end

