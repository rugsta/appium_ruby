def recentSearchCheck(recentSearchEntered)
  recentSearchPageArray = $driver.find_elements(:class, "UIACollectionCell")
  
  recentSearchPageArray.each_with_index  do |item, index|
    expect(item[:name]).to match(recentSearchEntered[index])
  end
end


def pdsSavePropertyCheck
  star = $driver.find_element(:id, "bookmark")
  star.click
  expect(star.attribute(:value)).to eq(1), "failed: expected property to be saved."
end


def pdsMortgageCalculatorView
  $driver.find_element(:id, "Mortgage Calculator").click
  waitWebView
  elements = $driver.find_elements(:class, "UIAStaticText")
  expect(findExists(elements, "Calculate Mortgage Repayments")).to be true
  buttonClick("Close")
end


def pdsHomeLoanBuilderView
  elements = $driver.find_elements(:class, "UIAScrollView")
  elementToScroll = elements[1]
  directionToScroll = "down"
  scrollWindow(directionToScroll, elementToScroll)
  
  $driver.find_element(:id, "afg-logo").click
  waitWebView
  elements = $driver.find_elements(:class, "UIAButton")
  expect(findExists(elements, "Get in touch with a broker")).to be true
  buttonClick("Cancel")
end


def pdsSchoolsView
  $driver.find_element(:id, "Show all nearby schools").click
  elements = $driver.find_elements(:class, "UIAButton")
  expect(findExists(elements, "All" )).to be true
  buttonClick("Cancel")
end


def pdsEmailAgentView
  $driver.find_element(:id, "Email agent").click
  elements = $driver.find_elements(:id, "Send")
  expect(findExists(elements, "Send" )).to be true
  buttonClick("Cancel")
end


def pdsSwipeImageScroller
  $driver.find_element(:id, "Property photo").click
  statusBarArray = $driver.find_elements(:class, "UIAStaticText")
  if statusBarArray.last.name != "1 of 1"
    swipeIt = Appium::TouchAction.new
    swipeIt.press(x: 225, y: 300).move_to(x: -225, y: 0).release.perform
    
    statusBarArray = $driver.find_elements(:class, "UIAStaticText")
    expect(statusBarArray.last[:name][0]).to match("2")
    
    binding.pry
    buttonClick("Cancel")
  end
end


def pdsRequestLoginCheck
  $driver.find_element(:id, "add note").click
  elements = $driver.find_elements(:id, "To save this property and add notes, please sign in")
  expect(findExists(elements, "To save this property and add notes, please sign in" )).to be true
end


def searchRequest(channel, location)
  channel.upcase
  $driver.find_element(:id, channel).click
  
  findVisibleSearch = $driver.find_elements(:id, "Search suburbs")
  
  #weird channel element swap when user tries to search twice.
  if(findVisibleSearch.size<2)
    findVisibleSearch.first.click
    else
    findVisibleSearch.last.click
  end
  
  $driver.find_element(:id, "Done").send_keys(location)
  $driver.find_element(:id, location).click
  $driver.find_elements(:id, "Done").last.click
end


def getResultsAndClick(searchResultNumber)
  sleep(3)
  searchResults = $driver.find_elements(:xpath, "//UIAApplication[1]/UIAWindow[1]/UIACollectionView[1]/UIACollectionCell")
  searchResults[searchResultNumber].click
end