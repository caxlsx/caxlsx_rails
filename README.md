Axlsx-Rails &mdash; Axlsx templates for Rails views
===================================================

[![Gem
Version](https://badge.fury.io/rb/axlsx_rails.png)](http://badge.fury.io/rb/axlsx_rails)
[![Build Status](https://secure.travis-ci.org/straydogstudio/axlsx_rails.png?branch=master)](http://travis-ci.org/straydogstudio/axlsx_rails)
[![Dependency Status](https://gemnasium.com/straydogstudio/axlsx_rails.png?branch=master)](https://gemnasium.com/straydogstudio/axlsx_rails)
[![Coverage
Status](https://coveralls.io/repos/straydogstudio/axlsx_rails/badge.png)](https://coveralls.io/r/straydogstudio/axlsx_rails)

##Installation

In your Gemfile:

```ruby
gem 'axlsx_rails'
```

##Requirements

* Rails 3.1, tested on 3.1, 3.2, 4.1, and 4.2.0.beta1
* **As of 0.2.0 requires Axlsx 2.0.1, which requires rubyzip 1.0.0**
* As of Rails 4.1 you must use `render_to_string` to render a mail attachment.

##Usage

Axlsx-Rails provides a renderer and a template handler. It adds the `:xlsx` format and parses `.xlsx.axlsx` templates. This lets you take all the [Axlsx](https://github.com/randym/axlsx) code out of your controller or model and place it inside the template, where view code belongs! **See [this blog post](http://axlsx.blog.randym.net/2012/08/excel-on-rails-like-pro-with-axlsxrails.html) for a more complete walkthrough.**

###Controller

To use Axlsx-Rails set your instance variables in your controller and configure the response if needed:

```ruby
class ButtonController < ApplicationController
  def action_name
    @buttons = Button.all
    respond_to do |format|
      format.xlsx
    end
  end
end
```

###Template

Create the template with the `.xlsx.axlsx` extension (`action_name.xlsx.axlsx` for example.) [**Watch out for typos!**](#troubleshooting) In the template, use xlsx_package variable to create your spreadsheet:

```ruby
wb = xlsx_package.workbook
wb.add_worksheet(name: "Buttons") do |sheet|
  @buttons.each do |button|
    sheet.add_row [button.name, button.category, button.price]
  end
end
```

This is where you place all your [Axlsx](https://github.com/randym/axlsx) specific markup. Add worksheets, fill content, merge cells, add styles. See the [Axlsx examples](https://github.com/randym/axlsx/tree/master/examples/example.rb) page to see what you can do.

That's it. Call your action and your spreadsheet will be delivered.

###Rendering Options

You can call render in any of the following ways:

```ruby
# rendered, no disposition/filename header
render 'buttons'
# rendered from another controller, no disposition/filename header
render 'featured/latest'
# template and filename of 'buttons'
render xlsx: 'buttons'
# template from featured controller, filename of 'latest'
render xlsx: 'featured/latest'
# template from another controller, filename of 'latest_buttons'
render xlsx: 'latest_buttons', template: 'featured/latest'
```

###Disposition

To specify a disposition (such as `inline` so the spreadsheet is opened inside the browser), use the `disposition` option:

```ruby
render xlsx: "buttons", disposition: 'inline'
```

If `render xlsx:` is called, the disposition defaults to `attachment`.

###File name

If Rails calls Axlsx through default channels (because you use `format.xlsx {}` for example) you must set the filename using the response header:

```ruby
format.xlsx {
  response.headers['Content-Disposition'] = 'attachment; filename="my_new_filename.xlsx"'
}
```

If you use `render xlsx:` the gem will try to guess the file name: 

```ruby
# filename of 'buttons'
render xlsx: 'buttons'
# filename of 'latest_buttons'
render xlsx: 'latest_buttons', template: 'featured/latest'
```

If that fails, pass the `:filename` parameter:

```ruby
render xlsx: "action_or_template", filename: "my_new_filename.xlsx"
```

###Acts As Xlsx

If you use [acts_as_xlsx](https://github.com/randym/acts_as_xlsx), configure the active record normally, but specify the package in the template:

```ruby
User.to_xlsx package: xlsx_package, (other options)
```

**Note:** As of 4/1/2014 Acts As Xlsx is not compatible with Rails 4.1, and generates a warning on 4.0. You may use [my patched fork](https://github.com/straydogstudio/acts_as_xlsx) until it is remedied.

###Axlsx Package Options

Axlsx provides three options for initializing a spreadsheet:

- **:author** (String) - The author of the document
- **:created_at** (Time) - Timestamp in the document properties (defaults to current time)
- **:use_shared_strings** (Boolean) - This is passed to the workbook to specify that shared strings should be used when serializing the package.

To pass these to the new package, prefix them with `xlsx_` and pass them to `render :xlsx` _or_ pass them as local variables.

For example, to set the author name, pass the `:xlsx_author` parameter to `render :xlsx` _or_ as a local variable:

```ruby
render xlsx: "index", xlsx_author: "Elmer Fudd"
render "index", locals: {xlsx_author: "Elmer Fudd"}
```

Other examples:

```ruby
render xlsx: "index", xlsx_created_at: 3.days.ago
render "index", locals: {xlsx_use_shared_strings: true}
```

###Partials

Partials work as expected:

```ruby
wb = xlsx_package.workbook
render :partial => 'cover_sheet', :locals => {:wb => wb}
wb.add_worksheet(name: "Content") do |sheet|
  sheet.add_row ['Content']
end
```

With the partial simply using the passed variables:

```ruby
wb.add_worksheet(name: "Cover Sheet") do |sheet|
  sheet.add_row ['Cover', 'Sheet']
end
```

###Mailers

To use an xlsx template to render a mail attachment, use the following syntax:

```ruby
class UserMailer < ActionMailer::Base
  def export(users)
    xlsx = render_to_string handlers: [:axlsx], formats: [:xlsx], template: "users/export", locals: {users: users}
    attachments["Users.xlsx"] = {mime_type: Mime::XLSX, content: xlsx}
    ...
  end
end
```

* If the route specifies or suggests the `:xlsx` format you do not need to specify `formats` or `handlers`. 
* If the template (`users/export`) can refer to only one file (the xlsx.axlsx template), you do not need to specify `handlers`, provided the `formats` includes `:xlsx`.

###Scripts

To generate a template within a script, you need to instantiate an ActionView context. Here are two gists showing how to perform this:

* [Using rails runner](https://gist.github.com/straydogstudio/323139591f2cc5d48fbc)
* [Without rails runner](https://gist.github.com/straydogstudio/dceb775ead81470cea70)

##Troubleshooting

###Mispellings

**It is easy to get the spelling wrong in the extension name, the format.xlsx statement, or in a render call.** Here are some possibilities:

* If it says your template is missing, check that its extension is `.xlsx.axlsx`.
* If you get the error `uninitialized constant Mime::XSLX` you have used `format.xslx` instead of `format.xlsx`, or something similar.

### Rails 4.2

In Rails 4.2, if you have a controller action that sometimes calls `render xlsx:` with a view from another controller, and at other times a view from the calling controller, you may have to specify full paths for each. 

For example, suppose you have the following code:

```ruby
class HomeController < ApplicationController
  def index
    if params[:some_condition]
      render xlsx: "users/index"
    else
      render xlsx: "index"
    end
  end
end
```

In this case, for 4.2 you would need to change the second call to "home/index"

Rails uses an array of strings, called `prefixes`, which contains the names of subdirectories to look inside when resolving a template. E.g. an action inside a Users controller would typically have `["users","application"]` as its prefix array. `axlsx_rails` adds to the prefixes array when you pass in a string with a slash so Rails  can find your template. Rails 4.2.0.beta1 appears to cache the prefixes array between requests, so in the above example the `index` render is found inside the `users` folder instead of the `home` folder. To solve this, use absolute paths for each render call.

When Rails 4.2 is released I will address this issue and come up with a solution.

###What to do

If you are having problems, try to isolate the issue. Use the console or a script to make sure your data is good. Then create the spreadsheet line by line without Axlsx-Rails to see if you are having Axlsx problems. If you can manually create the spreadsheet, create an issue and we will work it out.

##Dependencies

- [Rails](https://github.com/rails/rails)
- [Axlsx](https://github.com/randym/axlsx)

##Authors

* [Noel Peden](https://github.com/straydogstudio)

##Contributors

Many thanks to [contributors](https://github.com/straydogstudio/axlsx_rails/graphs/contributors):

* [randym](https://github.com/randym)
* [sugi](https://github.com/sugi)
* [envek](https://github.com/envek)
* [engwan](https://github.com/engwan)
* [maxd](https://github.com/maxd)
* [firien](https://github.com/firien)


##Change log

**September 4, 2014**: 0.2.1 release

- Rails 4.2.beta1 no longer includes responder. This release checks for the existence of responder before configuring a default responder.
- Rails 4.2 testing, though not yet on Travis CI
- Author, created_at, and use_shared_strings parameters for Axlsx::Package.new

**April 9, 2014**: 0.2.0 release

- Require Axlsx 2.0.1, which requires rubyzip 1.0.0
- Better render handling and testing, which might break former usage
- Rails 4.1 testing
- Mailer example update (**use render_to_string not render**)

**October 11, 2013**

- Handle (and test) respond_to override

**October 4, 2013**

- Added coveralls
- Raised testing to axlsx 2.0.1, roo 1.12.2, and rubyzip 1.0.0

**July 25, 2013**

- Documentation improved
- Testing for generating partial in mailer

**January 18, 2013**: 0.1.4 release

- Now supports Rails 4 (thanks [Envek](https://github.com/Envek))
- If you call render :xlsx on a request without :xlsx format, it should force the :xlsx format. Works on Rails 3.2+.

**December 6, 2012**: 0.1.3 release

- Fix for absolute template paths

**July 25, 2012**: 0.1.2 release

- Partials tested

**July 19, 2012**: 0.1.1 release

- Travis-ci added (thanks [randym](https://github.com/randym))
- render statements and filename tests fixes (thanks [engwan](https://github.com/engwan))

**July 17, 2012**: 0.1.0 release

- Tests completed
- Acts_as_xlsx tested, example in docs		

**July 12, 2012**: 0.0.1 release

- Initial posting.
- It works, but there are no tests! Bad programmer!
