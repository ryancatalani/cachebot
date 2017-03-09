# Cachebot

Rich link previews can look great on Facebook. But sometimes those previews are outdated, or are missing text or images. [Cachebot](https://gocachebot.herokuapp.com/) updates those link previews. [Try it out on Facebook Messenger](https://m.me/gocachebot).

![Cachebot Preview](https://gocachebot.herokuapp.com/cachebot_preview.gif)

## How it works

Facebook may cache a web page's open graph tags for [30 days](https://developers.facebook.com/docs/sharing/opengraph/using-objects). Sometimes it doesn't fetch the open graph tags correctly the first time, so the rich link preview looks funny.

When a user messages a URL to Cachebot, Cachebot POSTs a request to `https://graph.facebook.com` with two params: `id` (the URL) and `scrape` (`true`). This forces Facebook to re-scrape the URL's open graph tags.

## Installation

[Create a new Facebook app](https://developers.facebook.com/) and page (if necessary). Generate a page access token; set that as the `ACCESS_TOKEN` environment variable. Create a random verify token and set that as the `VERIFY_TOKEN` environment variable.

Install the necessary gems via `bundle`. (You may use a `.env` file.)

Start a local server with `rackup` and open a tunnel with [ngrok](https://ngrok.com/). In your Facebook Developer dashboard, set up webhooks. Set the callback URL to your ngrok URL and set the verify token to whatever you created earlier.

If everything's working, you can deploy this to Heroku and update the callback URL.

If you want to use Google Analytics, set the `GA_TRACKING` environment variable to your Google Analytics tracking ID.

## License: MIT

Copyright 2017 Ryan Catalani

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
