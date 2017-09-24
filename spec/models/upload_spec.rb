require 'rails_helper'

RSpec.describe Upload do

	#let(:upload) (Upload.new)
	subject {Upload.new}
	
	it "is not valid without a title" do
		expect(subject).not_to be_valid
	end

	it "is not valid with a title longer then 100 symbols" do
		subject.title = 'a' * 101
		expect(subject).not_to be_valid
	end

	it "is valid with proper data" do
		subject.title = 'a' * 50
		expect(subject).to be_valid
	end
end
