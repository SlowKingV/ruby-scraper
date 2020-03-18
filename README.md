# Ruby Capstone Project: Build your own scraper

> Capstone projects are solo projects at the end of the each of the Microverse Main Technical Curriculum sections.

**This is my ruby web scraper for Ruby Curse of Microverse.**
One of the current problems I constantly have is searching for *Open Source* projects to contribute, that's why I created my web scraper to extract data from [CodeTriage](https://www.codetriage.com) which is a web page to search projects that need contribution. It will return all the entries from the first page of the specified language you are searching for (*All Languages* by default). The current version of this project can only be controlled through the executable file `<main.rb>` inside `bin/`, however, the program retrieves and stores the data to different files managed by the user, so this can be easly implemented within bots or email services to notify about new entries.

*And that might be the future of this project...*

![screenshot](./screenshot.png)

### Project Requirements

- A scraper developed in Ruby
  - We recommend to use [Nokogiri gem](https://github.com/sparklemotion/nokogiri)
- You choose the website that you want to scrap the info from
- The README must include instructions on how to use the scraper and code examples

Developing the project, you should follow the best practices that you already learned in the previous projects, like setting-up a code linter, using Github flow, testing your business logic, writing good commit messages and a good README.

This program will try to fetch the most recent Open Source repositories searching for contributions from the website [www.codetriage.com](https://www.codetriage.com). You can also specify the language to search for.

## Built With

- [Ruby](https://www.ruby-lang.org),
- [Nokogiri](https://github.com/sparklemotion/nokogiri), [RSpec](https://rspec.info/),
- [VSCode](https://code.visualstudio.com/), [Rubocop](https://docs.rubocop.org/en/stable/), [Stickler-CI](https://stickler-ci.com/)

## Getting Started

**You just need to clone the repo and put the files anywhere. To run the program write in the terminal** `$ bin/main.rb` **within the repo directory**

To get a local copy up and running follow these simple example steps.

### Prerequisites

You need to have ***Ruby*** installed on your machine ([Check this out](https://www.ruby-lang.org/en/documentation/installation/) for instructions on installing ruby)

You need [Nokogiri gem](https://github.com/sparklemotion/nokogiri) for this to work. You can either run `$ bundle` to install it from the `Gemfile` or install it by yourself by runing `$ gem install nokogiri` from the command line (if you have trouble installing Nokogiri [check this page](https://nokogiri.org/tutorials/installing_nokogiri.html)).

**[Optional]** If you want to run tests you'll have to install [RSpec](https://rspec.info/).

### Usage

When the program starts there will be one storage file already opened and selected. It will be shown below the title.
After that you'll see the next five different options:
1. Update selected file: Select this to fetch the most recent data from the web and update the current file.
2. Inspect selected file: This option will print all the contents of the current file. For now this will only print the raw data to `$stdout`. It is recomended to open the file in any text editor though.
3. Select a different file: If you want to select another existing file choose this. It will show you all the repo files (*.xml) inside repo/ folder.
4. Create a new file: This will ask you for a name and a language to search for, and then create a new file with your preferences. It will be automatically updated but not selected until you explicitly do it (with option **3**).
0. Exit: This will finish and close the program.

All the new files will be created inside `repo\` folder. You can edit them manually since the program will fetch the data from them at the start (included `config.json`).

### Run tests

Once you have installed **RSpec** just run `$ rspec` from the command line. If you want to add/edit tests, you can do so inside the `spec/` folder (make sure your files are sufixed with `_spec` in the name).



## Author

👤 ***Diego Luna Granados***

- Github: [@SlowKingV](https://github.com/SlowKingV)
- Twitter: [@SlowKingVI](https://twitter.com/SlowKingVI)
- Linkedin: [Diego Luna Granados](https://www.linkedin.com/in/diego-luna-granados-64007b197/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/SlowKingV/ruby-scraper/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Thanks to #Team-73-the-corgis and Microverse for their support!
- Thanks to @sparklemotion for create the awesome [Nokogiri gem](https://github.com/sparklemotion/nokogiri).
- Thanks to [CodeTriage](https://www.codetriage.com) where all the data is gathered from.

## 📝 License

This project is [MIT](LICENSE) licensed.
