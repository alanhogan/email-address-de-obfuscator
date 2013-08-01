Email Address De-Obfuscator
===========================

This is a simple, well-factored jQuery plug-in. It is written in CoffeeScript. (Not using CoffeeScript? Just paste it in to <http://coffeescript.org>.)

<https://github.com/alanhogan/email-address-de-obfuscator>

### Motivation

For understandable reasons, you:

- Do not want to expose raw email addresses in your web pages
- Do not want to serve up HTML that is absolute garbage if JavaScript is off
- Want to let users simply click email addresses to use them (in the common case with JavaScript enabled)
- Don’t want to over-engineer this

### Usage

Simplest usage? 

1. Whenever you have an email address, write it **exactly** like this, except changing `username`, `example` and `tld` as appropriate:

    ~~~~~~
    <a class="js-e">username [AT] example [DOT] tld</a>
    ~~~~~~

2. Include jQuery and this plugin

3. After DOM load, call `jQuery(document).deObfuscateEmailAddresses();`.

Want to get fancy? Read on to customize:

- _Where_ in the DOM changes are made,
- What string _substitutions_ are made, and
- What _class name_ to use when locating obfuscated email addresses.

### Niceties

1. This plugin should work with Zepto (out of the box!) or other jQuery-compatible libraries.

2. Can work with AJAX-loaded content. 
  

  If you AJAX content into `<div id="my-dynamic-content"></div>`, then immediately call
  `jQuery('#my-dynamic-content').deObfuscateEmailAddresses();`.

  Or just make the global call (`jQuery(document)`) again if you don’t feel like scoping it. That should be fine. It’ll just search the whole document again.

3. Someone else did the work for you already.

### Extensible

* Don’t like the class name `js-e`? Choose your own:

    ~~~~~~~~
    jQuery(document).deObfuscateEmailAddresses({ "class": "magic-email-link" });
    ~~~~~~~~

* `[AT]` is too obvious? Cool. Define your own replacements as pairs of a regex or string to search for and a string replacement to make. Pass this as a configuration option:

    ~~~~~~~~
    var myReplacements = [
      [/\s*at domain\s*/, '@'],
      ['daht cohm!', '.com']
    ];
    jQuery(document).deObfuscateEmailAddresses({ replacements: myReplacements });
    ~~~~~~~~

### Custom anchor text

Usually, you want to show the email address as well as making a `mailto:` link. After all, not everyone has an email client set up.

But when that isn’t the case, you can still obfuscate your address. Just set up your `href` to use the `mailto` link you want, but with an obfuscated address:

    <a class="js-e"
      href="mailto:foo [at] example [dot] com"
      >Contact us</a>

This plugin processes this link into the equivalent of:

    <a class="js-e" href="mailto:foo@example.com">Contact us</a>

### Examples

Absolutely. [Here’s a jsFiddle for you.](http://jsfiddle.net/alanhogan/tyLtQ/)

### License

Public domain. (No license needed: I waive my copyright claims.)

