Axlsx-Rails &mdash; Axlsx templates for Rails views
===================================================

[![Build Status](https://secure.travis-ci.org/straydogstudio/axlsx_rails.png?branch=master)](http://travis-ci.org/straydogstudio/axlsx_rails)
[![Dependency Status](https://gemnasium.com/straydogstudio/axlsx_rails.png?branch=master)](https://gemnasium.com/straydogstudio/axlsx_rails)

##Installation

In your Gemfile:

```ruby
gem 'axlsx_rails'
```

##Requirements

* Rails 3.1, but it has only been tested on 3.2.6+

##Usage

Axlsx-Rails provides a renderer and a template handler. It adds the :xlsx format and parses .xlsx.axslx templates.

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

Use the .xlsx.axlsx extension (sorry if your lysdexic!) In the template, use xlsx_package variable, which is set with Axlsx::Package.new:

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

##Dependencies

- [Axlsx](https://github.com/randym/axlsx)

##Authors

* [Noel Peden](https://github.com/straydogstudio)

##Change log

- **December 6, 2012**: 0.1.3 release
  - Fix for absolute template paths

- **July 25, 2012**: 0.1.2 release
	- Partials tested

- **July 19, 2012**: 0.1.1 release
	- Travis-ci added (thanks [randym](https://github.com/randym))
	- render statements and filename tests fixes (thanks [engwan](https://github.com/engwan))

- **July 17, 2012**: 0.1.0 release
	- Tests completed
	- Acts_as_xlsx tested, example in docs

- **July 12, 2012**: 0.0.1 release
	- Initial posting.
	- It works, but there are no tests! Bad programmer!
