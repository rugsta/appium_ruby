require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'selenium/client'
require 'pry'
require 'touch_action'
require 'appium_lib'

def setup
  server_url = "http://127.0.0.1:4723/wd/hub/"
  
  capabilities =
  {
    :newCommandTimeout => 1000,
    :platformName => "ios",
    :platformVersion => "9.3",
    :deviceName => "iPhone Simulator",
    :app => "/Users/sandy.cook/Library/Developer/Xcode/DerivedData/mobile-core-ios-cnrmrivcaoaajxgdumqyiezbierq/Build/Products/Debug-iphonesimulator/RESI-Internal.app",
    :autoAcceptAlerts => true
  }
  
  Appium::Driver.new(caps: capabilities).start_driver
  Appium.promote_appium_methods Object
  
  application = $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[1]")
end


def quit
  $driver_quit
end


def scrollWindow(directionToScroll, elementToScroll)
  touch_action = Appium::TouchAction.new
  $driver.execute_script "mobile: scroll", direction: directionToScroll, element: elementToScroll.ref
end


def findExists(elements, valueToFind)
  puts "Looking for #{valueToFind} in #{elements.count} elements found"
  elements.each do |x|
    #puts "name    = #{x[:name]}"
    #puts "matches = #{x[:name] == valueToFind}"
    
    if x[:name] == valueToFind
      return true
    end
  end
  return false
end


def navBarClick(selection)
  nav = $driver.find_element(:class, "UIATabBar")
  select = nav.find_element(:id, selection)
  select.click
  expect(select.attribute(:value)).to eq(1), "failed: not on the expected page."
end


def userLogin(username, login)
  $driver.find_element(:id, "Sign In").click
  $driver.find_element(:id, "Email Address").send_keys(username)
  $driver.find_element(:id, "Password").send_keys(login)
  $driver.find_element(:id, "Go").click
end


def buttonClick(buttonName)
  $driver.find_element(:id, buttonName).click
end


def waitWebView
  sleep(3)
end