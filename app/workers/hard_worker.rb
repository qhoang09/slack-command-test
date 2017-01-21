class HardWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
  end
end

class CommandWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(params)
    weather = Weather.new(params[:text])

    message = {
    "attachments": [
        {
            "title": "Weather for Sandpoint, ID",
            "title_link": "http://www.wunderground.com/US/ID/Sandpoint.html",
            "text": "Optional text that appears within the attachment",
            "fields": [
                {
                    "title": "Temp",
                    "value": "68F",
                    "short": false
                },
        {
          "title": "Wind",
          "value": "16mph",
          "short": false
        }
            ],
            "image_url": "http://icons.wxug.com/i/c/k/clear.gif"
        }
    ]
}

    HTTParty.post(params[:response_url], { body: message.to_json, headers: {
        "Content-Type" => "application/json"
      }
    })

  end
end