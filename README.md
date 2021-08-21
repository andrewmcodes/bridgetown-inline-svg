## ⚠️ Maintenance Mode

This gem has been replaced by [ayushn21/bridgetown-svg-inliner] and will not be receiving further updates.

Upgrade to [ayushn21/bridgetown-svg-inliner] which has a MIT License and works with the latest versions of Bridgetown.

---

<div align="center">
  <h1>bridgetown-inline-svg</h1>
  <p>
    <a href="LICENSE" target="_blank">
      <img alt="License: GPL-3.0" src="https://img.shields.io/github/license/andrewmcodes/bridgetown-inline-svg" />
    </a>
    <a href="https://badge.fury.io/rb/bridgetown-inline-svg"><img src="https://badge.fury.io/rb/bridgetown-inline-svg.svg" alt="Gem Version" height="18"></a>
    <img alt="Tests" src="https://github.com/andrewmcodes/bridgetown-inline-svg/workflows/Tests/badge.svg" />
    <img alt="Linters" src="https://github.com/andrewmcodes/bridgetown-inline-svg/workflows/Linters/badge.svg" />
    <img alt="Changelog" src="https://github.com/andrewmcodes/bridgetown-inline-svg/workflows/Changelog/badge.svg" />
  </p>
</div>

## Installation

Run this command to add this plugin to your site's Gemfile:

```shell
bundle add bridgetown-inline-svg -g bridgetown_plugins
```

Or add the following to your `Gemfile`:

```ruby
group :bridgetown_plugins do
  gem "bridgetown-inline-svg", "~> 1.1.0"
end
```

## Optional Configuration

```yml
# bridgetown.config.yml

svg:
  # Whether to optimize the SVG files with svg_optimizer.
  #
  # Type: Boolean
  # Optional: true
  # Default: false
  optimize: true
```

## Usage

This plugin provides the `svg` Liquid tag to your site.

Use the tag in your pages, collections, and components by passing the tag the name of a file:

```liquid
{% svg path/to/my.svg %}
```

**Note**: The `.svg` file extension is required.

### Attributes

Set attributes like you would in HTML:

```liquid
{% svg assets/svg/square.svg width=24 class="text-indigo-600" foo="bar" %}
```

Bridgetown will include the SVG file in your output HTML like this:

```html
<svg width="24" height="24" class="text-indigo-600" foo="bar" version="1.1" id="square" xmlns="http://www.w3.org/2000/svg" x="0" y="0" viewBox="0 0 24 24" >
  <rect width="20" height="20" x="2" y="2" />
</svg>
```

**Note**: Anything can be passed through, but we'd recommend setting [valid attributes].

#### Height and Width

`height` is automatically set to match `width` if omitted, and vice versa. Height cannot be left unset because IE11 won't use the viewport attribute to calculate the image's aspect ratio.

### Paths

Paths with a space should be quoted with single or double quotes:

```liquid
{% svg "/path/to/my asset.svg" %}
```

If the path is not in quotes, anything after the __first space__ will be considered an attribute.

Relative paths and absolute paths will both be interpreted from Bridgetown's `src` directory:

```liquid
{% svg "/path/to/my.svg" %}
{% svg "path/to/my.svg" %}
```

Should resolve to `/your/site/src/path/to/my.svg`.

### Variables

Liquid variables will be interpolated if enclosed in double brackets:

```liquid
{% assign svg_name="my" %}
{% assign size=40 %}
{% svg "/path/to/{{svg_name}}.svg" width="{{size}}" %}
```

This is helpful inside of Liquid components!

### Optimizations

Processing is done to remove useless data when enabled in the Bridgetown config:

- metadata
- comments
- unused groups
- Other filters from [svg_optimizer]
- default size

If any important data gets removed, or the output SVG looks different from input, it's a bug. Please file an issue to this repository describing your problem.

It does not perform any input validation on attributes. They will be appended as-is to the root node.

## Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues page]. You can take a look at the [contributing guide].

## Acknowledgement

This project was initially forked from [jekyll-inline-svg].

## License

Copyright © 2017-2020 [Sebastien Dumetz]
Copyright © 2020 [Andrew Mason]

The following code is a derivative work of the code from the [jekyll-inline-svg] project, which is licensed GPLv3. This code therefore is also licensed under the terms of the GNU Public License, verison 3.


[ayushn21/bridgetown-svg-inliner]: https://github.com/ayushn21/bridgetown-svg-inliner
[Bridgetown, unlike this gem.]: https://bridgetownrb.com
[valid attributes]: https://developer.mozilla.org/en-US/docs/Web/SVG/Element/svg#Attributes
[svg_optimizer]: https://github.com/fnando/svg_optimizer
[issues page]: https://github.com/andrewmcodes/bridgetown-inline-svg/issues
[contributing guide]: https://github.com/andrewmcodes/bridgetown-inline-svg/blob/main/CONTRIBUTING.md
[jekyll-inline-svg]: https://github.com/sdumetz/jekyll-inline-svg
[Sebastien Dumetz]: https://github.com/sdumetz
[Andrew Mason]: https://github.com/andrewmcodes
