# Change log

**December 18, 2019**: 0.6.2 release

- Release under caxlsx_rails

**December 18, 2019**: 0.6.1 release

- Deprecate axlsx_rails name, release under caxlsx_rails
- Switch to using caxlsx 3.0 gem

**September 5, 2019**: 0.6.0 release

- Improved Rails 6.0 compatibility re MIME type

**May 1st, 2018**: 0.5.2 release

- Improved Rails 5 compatibility re MIME type

**March 29th, 2017**: 0.5.1 release

- Fix stack trace line numbers
- Thanks to [BenoitHiller](https://github.com/BenoitHiller)

**July 26st, 2016**: 0.5.0 release

- Support for Rails 5
- **Tested on on Rails 4.0, 4.1, 4.2, and 5.0**
- Bug fixes for unreadable files and UTF-8 errors

**July 13th, 2015**: 0.4.0 release

- Support for Rails 4.2
- **Removal of forced default_formats** (url format must match)
- **Tested only on Rails 4.1 and 4.2**
- **For Rails 3.2 or below, use 0.3.0**

**November 20th, 2014**: 0.3.0 release

- Support for Rails 4.2.beta4.
- **Removal of shorthand template syntax** (`render xlsx: 'another/directory'`)

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

