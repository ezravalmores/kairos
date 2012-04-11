class PeopleController < ApplicationController
  before_filter :authorize
  
  def index
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end
  
  def new  
    @person = Person.new
    
    respond_to do |format|
      format.html { } # new.html.erb
      format.xml  { render :xml => @person }
    end
  end
  
  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
    respond_to do |format|
      format.html { } # edit.html.erb
    end
  end
 
  
  def show
    @person = current_user
  end
  
  
  # POST /people
  # POST /people.xml
  def create
    @person = Person.new(params[:person])
    respond_to do |format|
      if @person.save
        #Kairos.welcome_message(@person).deliver
        flash[:notice] = 'Person was successfully created.'
        format.html { redirect_to(people_url) }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        flash[:warning] = 'Please check every information that you are entering and fill the required fields.'
        format.html { render :new }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end 
  
  # PUT /people/1
   # PUT /people/1.xml
   def update
     @person = Person.find(params[:id])

     respond_to do |format|
       if @person.update_attributes(params[:person])
         flash[:notice] = 'Person was successfully updated.'
         format.html { redirect_to people_url }
         format.xml  { head :ok }
       else
         flash[:warning] = 'Please check every information that you are entering and fill the required fields.'
         format.html { render :edit }
         format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
       end
     end
   end 
   
   def welcome_message
     person = Person.find(params[:id])
     Kairos1Mailer.welcome_message(person).deliver
     flash[:notice] = "Email has been sent the user"
     redirect_to :back
   end   
end
