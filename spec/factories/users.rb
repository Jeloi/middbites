FactoryGirl.define	do
	
  factory User do
    name "Jason Bourne" 
    first_name "Jason"
    last_name "Bourne"
    provider "facebook"
  end
end