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

* Rails 3.1, tested on 3.1, 3.2, and 4.0

##Usage

Axlsx-Rails provides a renderer and a template handler. It adds the :xlsx format and parses .xlsx.axslx templates. This lets you take all the [Axlsx](https://github.com/randym/axlsx) code out of your controller or model and place it inside the template, where view code belongs! **See [this blog post](http://axlsx.blog.randym.net/2012/08/excel-on-rails-like-pro-with-axlsxrails.html) for a more complete walkthrough.**

###Controller

You can either use the typical format:

```ruby
respond_to do |format|
  format.xlsx
end
```

or call render directly:

```ruby
render xlsx: "foobar", filename: "the_latest_foobar", disposition: 'inline'
```

If you merely want to specify a file name, you can do it one of two ways:

```ruby
format.xlsx {
	response.headers['Content-Disposition'] = 'attachment; filename="my_new_filename.xlsx"'
}
```

Or:

```ruby
format.xlsx {
  render xlsx: "action_or_template", disposition: "attachment", filename: "my_new_filename.xlsx"
}
```

> NOTE: Someday it would be nice to merely say something like:
	render :filename 'blah.xlsx"

###Template

This is where you place all your [Axlsx](https://github.com/randym/axlsx) specific markup. Add worksheets, fill content, merge cells, add styles. See the [Axlsx examples](https://github.com/randym/axlsx/tree/master/examples/example.rb) page to see what you can do. 

Use the .xlsx.axlsx extension ([watch out for typos!](#troubleshooting)) In the template, use xlsx_package variable, which is set with Axlsx::Package.new:

```ruby
wb = xlsx_package.workbook
style_shout = wb.styles.add_style sz: 16, b: true, alignment: { horizontal: :center }
wb.add_worksheet(name: "Foobar") do |sheet|
  sheet.add_row ['Bad', 'spellers', 'of', 'the', 'world', '...']
  sheet.add_row ['Untie!']
  sheet.merge_cells("B1:B6")
  sheet["B1"].style = style_shout
end
```

If you use [acts_as_xlsx](https://github.com/randym/acts_as_xlsx), configure the active record normally, but specify the package in the template:

```ruby
User.to_xlsx package: xlsx_package, (other options)
```

To set the author attribute upon Axlsx::Package.new, insert the following in application.rb:

```ruby
config.axlsx_author = "Elmer Fudd"
```

> NOTE: We really ought to allow the author to be set in each call

####Partials

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

####Mailers

To use an xlsx template to render a mail attachment, use the following syntax:

```ruby
class UserMailer < ActionMailer::Base
  def export(users)
    xlsx = render handlers: [:axlsx], template: "users/export", locals: {users: users}
    attachments["Users.xlsx"] = {mime_type: Mime::XLSX, content: xlsx}
    ...
  end
end
```

If the template (`users/export`) can refer to only one file (the xlsx.axlsx template), you do not need to specify `handlers`.

##Troubleshooting
### Mispellings
It is easy to get the spelling wrong in the extension name, the format.xlsx statement, or in a render call. If you get the following error in particular: 

```ruby
  uninitialized constant Mime::XSLX
```

it means you have used `format.xslx` instead of `format.xlsx`, or something similar.

##Dependencies

- [Axlsx](https://github.com/randym/axlsx)

##Authors

* [Noel Peden](https://github.com/straydogstudio)

##Contributors

* [randym](https://github.com/randym)
* [sugi](https://github.com/sugi)
* [envek](https://github.com/envek)
* [engwan](https://github.com/engwan)
* [maxd](https://github.com/maxd)

##Change log

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
