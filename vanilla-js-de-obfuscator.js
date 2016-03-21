
function deObfuscateEmailAddresses (options) {
  var settings = {
    "class": options["class"] || 'js-e',
    "processedClass": options["processedClass"] || 'js-e-processed',
    replacements: options.replacements || [[/\s*\[at\]\s+/i, '@'], [/\s*\[dot\]\s+/ig, '.']]
  };

  var searchSelector;

  // new API. https://developer.mozilla.org/en-US/docs/Web/API/CSS/escape
  if (window && window.CSS && CSS.escape) {
    searchSelector = "." +
      CSS.escape(settings["class"]) +
      ":not(" +
      CSS.escape(settings["processedClass"]) +
      ")";
  } else {
    // Will work for normal class names.
    searchSelector = "." + settings["class"] + ":not("+settings["processedClass"]+")";
  }
  var elements = document.querySelectorAll(searchSelector);

  Array.prototype.forEach.call(elements, (function(element) {
    var address, fromText, k, len, ref, replacement;
    address = element.href;

    if ((address != null ? address.slice(0, 7) : void 0) === 'mailto:') {
      address = address.slice(7);
      fromText = false;
    } else {
      fromText = true;
      address = element.innerHTML.trim();
    }

    ref = settings.replacements;

    for (k = 0, len = ref.length; k < len; k++) {
      replacement = ref[k];
      address = address.replace(replacement[0], replacement[1]);
    }

    if (fromText) {
      element.innerHTML = address;
    }

    element.href = "mailto:" + address;
  }));
  return true;
}
