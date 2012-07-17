Axlsx-Rails &mdash; Axlsx templates for Rails views
===================================================

##Installation
--------------
Until published:
	gem 'axlsx_rails', :git => "https://github.com/straydogstudio/axlsx_rails.git"

##Requirements
--------------
* Rails 3.1, but it has only been tested on 3.2.6

##Usage
-------

Axlsx-Rails provides a renderer and a template handler. It adds the :xlsx format and parses .xlsx.axslx templates.

###Controller

You can either use the typical format:

	respond_to do |format|
		format.xlsx
	end

or call render directly:

	render "foobar", filename: "the_latest_foobar", disposition: 'inline'

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
Partials are currently untested.

##Dependencies
--------------
- [Axlsx](https://github.com/randym/axlsx)

##Authors
---------
* [Noel Peden](https://github.com/straydogstudio)

##Change log
------------
- **July 12, 2012**: 0.0.1 release
* Initial posting.
* It works, but there are no tests! Bad programmer!