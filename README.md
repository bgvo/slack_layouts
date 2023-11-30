# SlackLayout

A ruby gem that makes building Slack's BlockKit layouts easy while keeping everything organized.

It leverages [Slack::BlockKit](https://github.com/CGA1123/slack-ruby-block-kit) by providing an inheritance pattern that makes building new layouts convenient and fast.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_layout'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install slack_layout

## Usage
To create a new layout create a new class that inherits from `SlackLayout`. For example:

```ruby
class MyCustomSlackLayout < SlackLayout
  attr_reader :param1, :param2

  def initialize(param1, param2)
    @param1 = param1
    @param2 = param2
    super()
  end

  def blocks
    section do |section|
      section.mrkdwn_field text: param1
    end

    actions do |actions|
      actions.button(
        text: "Archive Now!",
        style: "danger",
        value: param2,
        action_id: "archive_now",
        emoji: true,
      )

      actions.button(
        text: "Snooze 14 days",
        style: "primary",
        value: param2,
        action_id: "archive_snooze",
        emoji: true,
      )
    end
  end
end
```
Then you can use it anywhere in your code:

```ruby
param1 = "22"
param2 = "Anything you want to use in your layout"
layout = MyCustomSlackLayout.new(param1, param2)
```

Now, you can access the layout json that Slack needs to be sent by calling `as_json` on the layout:

```ruby
layout.as_json
```

Which will produce the following json:

```json
[
  {
    "type": "section",
    "fields": [
      {
        "type": "mrkdwn",
        "text": "The message for a custom layout"
      }
    ]
  },
  {
    "type": "actions",
    "elements": [
      {
        "type": "button",
        "text": {
          "type": "plain_text",
          "text": "Archive Now!",
          "emoji": true
        },
        "action_id": "archive_now",
        "value": "22",
        "style": "danger"
      },
      {
        "type": "button",
        "text": {
          "type": "plain_text",
          "text": "Snooze 14 days",
          "emoji": true
        },
        "action_id": "archive_snooze",
        "value": "22",
        "style": "primary"
      }
    ]
  }
]
```

Then, use it anywhere in Slack. For example, you could use it to extend the functionality of a message in one of your Slack channels.

```ruby
# Assuming $slack is an already initialized Slack ruby client
$slack.chat_postMessage(channel: channel_id, blocks: layout.as_json)
```

For a complete guide on building with Block Kit, please visit https://api.slack.com/block-kit.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome at https://github.com/bgvo/slack_layout.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
