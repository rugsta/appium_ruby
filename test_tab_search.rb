require_relative 'methods_general'
require_relative 'methods_search'


describe 'Search and pds functionality checks' do
  
  before(:each) do
    setup
  end
  
  
    it 'searches and checks PDS page options', js: true do
      navBarClick("Search")
  
      searchRequest("buy", "Suburb, VIC 3889")
      getResultsAndClick(2)
  
      pdsMortgageCalculatorView
  
      pdsHomeLoanBuilderView
      
      pdsSchoolsView
  
      pdsEmailAgentView
      
      quit
    end
  
  
    it 'searches and checks buy, rent, sold recent searches', js: true do
      navBarClick("Search")
 
      searchRequest("Buy", "Suburb, VIC 3889")
      buttonClick("Back")
 
      searchRequest("Rent", "Mentone, VIC 3194")
      buttonClick("Back")
 
      searchRequest("Sold", "Newport, VIC 3015")
      buttonClick("Back")
 
      recentSearchEntered = ["Newport, VIC, filtered by Sold, $ Any", "Mentone, VIC, filtered by Rent, $ Any", "Suburb, VIC, filtered by Buy, $ Any"]
      recentSearchCheck(recentSearchEntered)
 
      quit
    end
  
  
    it 'searches and saves a property', js: true do
      navBarClick("Search")
  
      searchRequest("buy", "Suburb, VIC 3889")
      getResultsAndClick(2)
  
      pdsRequestLoginCheck
      userLogin("sandy.cook@rea-group.com", "section2")
  
      pdsSavePropertyCheck
  
      quit
    end
    
  
    it 'searches scrolls a window scroller', js: true do
      navBarClick("Search")
    
      searchRequest("buy", "Mentone, VIC 3194")
      getResultsAndClick(2)
    
      pdsSwipeImageScroller
  
      quit
    end
  
end
