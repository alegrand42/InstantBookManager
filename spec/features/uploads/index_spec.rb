require 'rails_helper'

RSpec.feature 'Upload list' do 
	scenario 'unauthenticated user' do
		visit uploads_path
		within '#content' do
			expect(find('h1')).to have_content('New Book')	
		end	
	end
end
