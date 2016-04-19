require 'rails_helper'

describe Contact do 

	it "has a valid factory" do
		expect(FactoryGirl.build(:contact)).to be_valid
	end

	it "has three phone numbers" do
		expect(create(:contact).phones.count).to eq 3
	end

	it "is valid with a firstname, lastname and email" do
		contact = Contact.new(
			firstname: 'Aaron',
			lastname: 'Summer',
			email: 'test@email.com')
		expect(contact).to be_valid
	end

	# it "is invalid without a firstname" do
	# 	#contact = Contact.new(firstname: "Aaron")
	# 	contact = FactoryGirl.build(:contact, firstname: nil) #using factory girl
	# 	contact.valid?
	# 	expect(contact.errors[:firstname]).to_not include("can't be blank")
	# end

	# it "is invalid without a lastname" do
	# 	#contact = Contact.new(lastname: "Summer")
	# 	contact = FactoryGirl.build(:contact, lastname: nil) #using factory girl
	# 	contact.valid?
	# 	expect(contact.errors[:lastname]).to_not include("can't be left blank")
	# end

	# it "is invalid wihtout an email address" do
	# 	contact = FactoryGirl.build(:contact, email: nil)
	# 	contact.valid?
	# 	expect(contact.errors[:email]).to include("has already been taken")
	# end

	# it "returns a contact's full name as a string" do
	# 	contact = FactoryGirl.build(:contact, 
	# 		firstname: "Jane",
	# 		lastname: "Smith"
	# 		) 
	# 	expect(contact.name).to eq 'Jane Smith'
	# end

	# it "is invalid with a duplicate email address" do
	# 	FactoryGirl.create(:contact, email: 'aaron@email.com')
	# 	contact = FactoryGirl.build(:contact, email: 'aaron@email.com')
	# 	contact.valid?
	# 	expect(contact.errors[:email]).to include('has already been taken')
	# end


	it "returns a sorted array of results that match" do
		smith = Contact.create(
			firstname: 'John',
			lastname: 'Smith',
			email: 'test@email.com'
			)
		jones = Contact.create(
			firstname: 'Bill',
			lastname: 'Jones',
			email: 'test@email.com'
			)
		johnson = Contact.create(
			firstname: 'Adam',
			lastname: 'Johnson',
			email: 'test@email.com'
			)
		expect(Contact.by_letter("J")).to_not eq("Smith")
	end

	describe "filter last name by letter" do
		before :each do
			@smith = Contact.create(
				firstname: 'John',
				lastname: 'Smith',
				email: 'jsmith@mail.com'
				)
			@jones = Contact.create(
				firstname: 'Tim',
				lastname: 'Jones',
				email: 'jones@mail.com'
				)
			@johnson = Contact.create(
				firstname: 'John',
				lastname: 'Johnson',
				email: 'johnson@mail.com'
				)
		end

		context "non-mathcing letters" do
			it "returns a sorted array of results that match" do
				expect(Contact.by_letter("J")).to eq [@johnson, @jones]
			end
		end

		context "with non-mathcing letters" do
			it "omits results that do not match" do
				expect(Contact.by_letter("J")).not_to include @smith
			end
		end
	end
end
