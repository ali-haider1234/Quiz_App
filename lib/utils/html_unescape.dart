class HtmlUnescape {
  static String unescape(String input) {
    String text = input;
    text = text.replaceAll('&quot;', '"');
    text = text.replaceAll('&#039;', "'");
    text = text.replaceAll('&#39;', "'");
    text = text.replaceAll('&amp;', '&');
    text = text.replaceAll('&lt;', '<');
    text = text.replaceAll('&gt;', '>');
    text = text.replaceAll('&rsquo;', "'");
    text = text.replaceAll('&lsquo;', "'");
    text = text.replaceAll('&ldquo;', '"');
    text = text.replaceAll('&rdquo;', '"');
    text = text.replaceAll('&ndash;', '–');
    text = text.replaceAll('&mdash;', '—');
    text = text.replaceAll('&hellip;', '…');
    text = text.replaceAll('&eacute;', 'é');
    text = text.replaceAll('&uuml;', 'ü');
    text = text.replaceAll('&ntilde;', 'ñ');
    text = text.replaceAll('&Ouml;', 'Ö');
    text = text.replaceAll('&ouml;', 'ö');
    text = text.replaceAll('&auml;', 'ä');
    text = text.replaceAll('&Auml;', 'Ä');
    text = text.replaceAll('&deg;', '°');
    text = text.replaceAll('&trade;', '™');
    text = text.replaceAll('&reg;', '®');
    text = text.replaceAll('&copy;', '©');
    text = text.replaceAll('&bull;', '•');
    text = text.replaceAll('&pi;', 'π');
    text = text.replaceAll('&sup2;', '²');
    text = text.replaceAll('&sup3;', '³');
    text = text.replaceAll('&pound;', '£');
    text = text.replaceAll('&euro;', '€');
    text = text.replaceAll('&yen;', '¥');

    // Decode numeric decimal entities like &#123;
    text = text.replaceAllMapped(RegExp(r'&#(\d+);'), (match) {
      final code = int.tryParse(match.group(1) ?? '');
      return code != null ? String.fromCharCode(code) : match.group(0)!;
    });

    // Decode numeric hex entities like &#x1A;
    text = text.replaceAllMapped(RegExp(r'&#x([0-9a-fA-F]+);'), (match) {
      final code = int.tryParse(match.group(1) ?? '', radix: 16);
      return code != null ? String.fromCharCode(code) : match.group(0)!;
    });

    return text;
  }
}
