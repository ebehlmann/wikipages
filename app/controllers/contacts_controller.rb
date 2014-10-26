class ContactsController < ApplicationController
	def index
		@contacts = Contact.all
	end

	def create
		@contact = Contact.new(params[:contact])
		if @contact.save
			@phone = Phone.new(:number => @contact.phone,
											:contact_id => @contact.id)
			@phone.save
			flash[:notice] = "Your contact was saved to Wikipages."
			redirect_to contact_path(@contact)
		else
			render 'new'
		end
	end

	def new
		@contact = Contact.new
	end

	def show
		@contact = Contact.find(params[:id])
		render('contacts/show.html.erb')
	end

	def edit
		@contact = Contact.find(params[:id])
	end

	def update
		@contact = Contact.find(params[:id])
		if @contact.update(params[:contact])
			redirect_to contact_path(@contact)
		else
			render 'edit'
		end
	end

	def destroy
		@contact = Contact.find(params[:id])
		@contact.destroy
		redirect_to contacts_path
	end
end