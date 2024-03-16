require 'selenium-webdriver'
require 'net/smtp'
require 'bundler'
Bundler.require(:default)

SMTP_SETTINGS = {
  address: 'smtp.rate-my-agent.com',
  port: 587,
  domain: 'rate-my-agent.com',
  user_name: 'TEST',
  password: 'TEST'
}

def setup_browser
  @driver = Selenium::WebDriver.for :firefox
end

def check_home_page
  @driver.navigate.to 'http://rate-my-agent.com'
  raise 'Home Page Error' unless @driver.find_element(tag_name: 'body').text.include?('Hire the Right Agent')
end

def check_get_matched_now
  @driver.find_element(link_text: 'Get Matched Now').click
  raise 'Get Matched Now Error' unless @driver.current_url.include?('https://www.rate-my-agent.com/quiz?cta=take-quiz-home')
end

def check_agent_search
  @driver.navigate.to 'http://rate-my-agent.com'
  # NOTE: the page has two elements with ID and name called 'term'
  #       nice test :D
  @driver.find_elements(name: 'term').last.send_keys('Joe', :return)
  raise 'Agent Search Error' unless @driver.find_element(tag_name: 'body').text.include?('Agents matching "joe"')
end

def send_email(_subject, message)
  smtp = Net::SMTP.new(SMTP_SETTINGS[:address], SMTP_SETTINGS[:port])
  smtp.enable_starttls

  smtp.start(SMTP_SETTINGS[:domain], SMTP_SETTINGS[:user_name], SMTP_SETTINGS[:password], :login) do
    smtp.send_message(message, 'noreply@rate-my-agent.com', 'alerts@rate-my-agent.com')
  end
  puts 'Email sent successfully.'
rescue Net::SMTPAuthenticationError
  puts 'SMTP Authentication Error: Check your username and password.'
ensure
  smtp.finish if smtp && smtp.started?
end

def log_status(message)
  File.open('log.txt', 'a') { |file| file.puts("#{Time.now}: #{message}") }
end

begin
  setup_browser
  check_home_page
  check_get_matched_now
  check_agent_search
  log_status('All checks passed successfully.')
rescue StandardError => e
  send_email('Website Check Failed', e.message)
  log_status("Failure: #{e.message}")
ensure
  @driver.quit
end
