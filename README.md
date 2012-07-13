Axlsx-Rails &mdash; Axlsx templates for Rails views
==============================================

# Installation
---------
Not yet published. But you can download it and install it.

# Requirements
---------
* Rails 3.1, but it has only been tested on 3.2.6

# Usage
---------

Axlsx-Rails provides a renderer and a template handler. It adds the :xlsx format and parses .xlsx.axslx templates (yikes - sorry if you're lysdexic).

## Controller

You can either use the typical format:

	respond_to do |format|
		format.xlsx
	end

or call render directly:

	render "foobar", :filename => "the_latest_foobar", :disposition => 'inline'

## Template

In the template, use axlsx_package variable, which is set with Axlsx::Package.new:

	wb = axlsx_package.workbook
	style_bold = wb.styles.add_style b: true
	wb.add_worksheet(name: "Foobar") do |sheet|
	  sheet.add_row ['foo', 'bar', 'mashup']
	  sheet.add_row ['foo', 'bar', 'again'], :style = style_bold
	  sheet.column_widths 10, 20, 30
	end

To set the author attribute upon Axlsx::Package.new, insert the following in application.rb:

	config.axlsx_author = "Elmer Fudd"

> TODO: allow the author to be set in each call

### Partials
Partials are currently untested.

# Dependencies:
---------
- [Axlsx](github.com/randym/axlsx)

# Authors
---------
* [Noel Peden](https://github.com/straydogstudio)

# Change log
---------
- **July 12, 2012**: 0.0.1 release
* Initial posting.
* It works, but there are no tests! Bad programmer!