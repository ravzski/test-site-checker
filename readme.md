## Prerequisites

Before running the script, ensure you have the following installed:
- Ruby (version 3.0 or higher, im using ruby 3.2.2)
- Bundler
- Firefox Browser
- [Geckodriver](https://github.com/mozilla/geckodriver/releases) (for Selenium WebDriver to interact with Firefox)

## Installation

1. Navigate to the script's directory in your terminal.
2. Install the required Ruby gems by running:

```
bundle install
```

3. Setp SMTP

Edit the SMTP_SETTINGS in the script to match your SMTP server details:

```
SMTP_SETTINGS = {
  address: 'smtp.your-domain.com',
  port: 587,
  domain: 'your-domain.com',
  user_name: 'YOUR_USERNAME',
  password: 'YOUR_PASSWORD'
}
```

## Usage
run

```ruby watcher.rb```

## Notes

## Pros:

1. **I kept it simple**: This makes my script easy for anyone to grasp and use, regardless of their technical background.
2. **Ease of use is key**: I made sure it's straightforward to set up and execute, ideal for quick functionality checks.
3. **Quick fixes in mind**: Given its simplicity, I can swiftly identify and resolve any issues that arise.
4. **Built for adaptability**: Modifying or expanding the script is a breeze thanks to its straightforward nature.

## Cons:

But with simplicity, there are a few compromises:

1. **Scaling up**: As the scope of testing expands, I might need to make significant updates to the script.
2. **Surface-level testing**: My approach might overlook more complex scenarios that require a deeper dive.
3. **Error insights**: The script might fall short in providing the detailed error analysis necessary for thorough troubleshooting.
4. **Integration with complex tools**: Merging it with more advanced testing frameworks or tools could prove to be a challenge.
