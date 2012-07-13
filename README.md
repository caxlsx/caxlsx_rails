Axlsx-Rails &mdash; Axlsx templates for Rails views
===================================================

##Installation
--------------
Not yet published. But you can download it and install it.

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

Use the .xlsx.axlsx extension (sorry if your lysdexic!) In the template, use axlsx_package variable, which is set with Axlsx::Package.new:

	wb = axlsx_package.workbook
	style_shout = wb.styles.add_style sz: 16, b: true, alignment: { horizontal: :center }
	wb.add_worksheet(name: "Foobar") do |sheet|
	  sheet.add_row ['Bad', 'spellers', 'of', 'the', 'world', '...']
	  sheet.add_row ['Untie!']
	  sheet.merge_cells("B1:B6")
	  sheet["B1"].style = style_shout
	end

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