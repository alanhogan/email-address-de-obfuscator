# Plugin Email Address De-Obfuscator by Alan Hogan, 2013
#
# It’s public domain. Enjoy freely.
#
# Project home on GitHub: https://github.com/alanhogan/email-address-de-obfuscator
#
# There are no tests, but there’s a jsFiddle: http://jsfiddle.net/alanhogan/tyLtQ/
#
# Started from https://github.com/alanhogan/Coffeescript-jQuery-Plugin-Template

(($, window) ->
  $.extend $.fn, deObfuscateEmailAddresses: (options) ->
    @defaultOptions = 
      class: 'js-e'
      # Each replacement is a two-item array: search, replace.
      replacements:  [
        # Using CoffeeScript's expanded regex syntax. It is love.
        [
          ///
            \s*      # optional whitespace, greedily
            \[at\]   # Literal hard brackets around the string "at"
            \s+      # optional whitespace, greedily
          ///i,     # Modifier: Case-insensitive (match AT, at, At…)
          '@'
        ],
        [
          ///
            \s*      # optional whitespace, greedily
            \[dot\]  # Literal hard brackets around the string "dot"
            \s+      # optional whitespace, greedily
          ///ig,     # Modifiers: Case-insensitive; global (match multiple times)
          '.'
        ]
      ]
    settings = $.extend({}, @defaultOptions, options)
    
    # Code here will run each time this plugin is invoked

    @each (i, el) ->
      $scope = $(el) # If you need it!

      $scope.find(".#{settings.class}").each (j, anchor) ->
        $anchor = $(anchor)
        address = $anchor.attr 'href'
        if address?[0..6] is 'mailto:'
          address = address[7..-1]
          fromText = false
        else
          fromText = true
          address = $anchor.text()
        for replacement in settings.replacements
          address = address.replace replacement[0], replacement[1]
        $anchor.text(address) if fromText
        $anchor.attr 'href', "mailto:#{address}"

      true # continue (to avoid returning anything weird)
    
    @ # allow chaining
) this.jQuery or this.Zepto or this.$, this
