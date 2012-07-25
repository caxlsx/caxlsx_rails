Axlsx-Rails &mdash; Axlsx templates for Rails views
===================================================

[![Build Status](https://secure.travis-ci.org/straydogstudio/axlsx_rails.png?branch=master)](http://travis-ci.org/straydogstudio/axlsx_rails)

##Installation

In your Gemfile:

	gem 'axlsx_rails'

##Requirements

* Rails 3.1, but it has only been tested on 3.2.6

##Usage

Axlsx-Rails provides a renderer and a template handler. It adds the :xlsx format and parses .xlsx.axslx templates.

###Controller

You can either use the typical format:

	respond_to do |format|
		format.xlsx
	end

or call render directly:

	render xlsx: "foobar", filename: "the_latest_foobar", disposition: 'inline'

###Template

Use the .xlsx.axlsx extension (sorry if your lysdexic!) In the template, use xlsx_package variable, which is set with Axlsx::Package.new:

	wb = xlsx_package.workbook
	style_shout = wb.styles.add_style sz: 16, b: true, alignment: { horizontal: :center }
	wb.add_worksheet(name: "Foobar") do |sheet|
	  sheet.add_row ['Bad', 'spellers', 'of', 'the', 'world', '...']
	  sheet.add_row ['Untie!']
	  sheet.merge_cells("B1:B6")
	  sheet["B1"].style = style_shout
	end

If you use [acts_as_xlsx](https://github.com/randym/acts_as_xlsx), configure the active record normally, but specify the package in the template:

	User.to_xlsx package: xlsx_package, (other options)

To set the author attribute upon Axlsx::Package.new, insert the following in application.rb:

	config.axlsx_author = "Elmer Fudd"

> NOTE: We really ought to allow the author to be set in each call

####Partials

Partials work as expected:

	wb = xlsx_package.workbook
	render :partial => 'cover_sheet', :locals => {:wb => wb}
	wb.add_worksheet(name: "Content") do |sheet|
	  sheet.add_row ['Content']
	end

With the partial simply using the passed variables:

	wb.add_worksheet(name: "Cover Sheet") do |sheet|
		sheet.add_row ['Cover', 'Sheet']
	end

##Dependencies

- [Axlsx](https://github.com/randym/axlsx)

##Authors

* [Noel Peden](https://github.com/straydogstudio)

##Change log

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
