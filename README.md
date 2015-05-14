# ASBot

This is the source code for the IRC bot on SynIRC's #capasb channel, accessible [here](irc://irc.synirc.net/capasb).

## Installation

    $ bundle install
Afterwards, you need to set a few environment variables on your system. These are `botircnick`, `botircpass`, `githubnick`, `githubpass`, `googledrivelogin`, `googledrivepass`, `smogon_username`, `quotes_url`, and `smogon_password`.

The data which these variables refer to should be easy to guess, but it is important to note that quotes_url should be a valid link to a Github Gist with a file named `quotes.rb` created by the user whose username is in `githubnick`.
## Usage

    $ ruby bot.rb

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request.

## [License](https://github.com/Sarkynin/ASBot/blob/master/LICENSE)
