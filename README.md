# ASBot

This is the source code for the IRC bot on SynIRC's #capasb channel, accessible [here](irc://irc.synirc.net/capasb).

## Installation

Heroku usage is assumed. Why, you might ask? Because I have no dedicated server, so I built this bot around being run on a heroku dyno (including the various workarounds for some of the engine's, let's say, *interesting* quirks). Shouldn't be too hard to modify the relevant parts if you're running this at home, though.

    $ bundle install
Afterwards, you need to set a few environment variables on your system. These are `botircnick`, 
`botircpass`, `githubnick`, `githubpass`, `googledrivelogin` `p12pass`, `smogon_username`, `quotes_url`, and `smogon_password`.

quotes_url should be a valid link to a Github Gist with a file named `quotes.rb` created by the user whose username is in `githubnick`.

googledrivelogin should be the email for your oauth service account credentials.

p12pass should be the password for your oauth p12 credentials.

You also need to put a "google_key.p12" file in the utils/ folder, which should be the credentials for the app on google developers console.

## Usage

    $ ruby bot.rb

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request.

## [License](https://github.com/Sarkynin/ASBot/blob/master/LICENSE)
