<h1 align="center">Welcome to bridgetown-inline-svg 👋</h1>
<p>
  <a href="LICENSE.txt" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  </a>
  <a href="https://badge.fury.io/rb/bridgetown-inline-svg"><img src="https://badge.fury.io/rb/bridgetown-inline-svg.svg" alt="Gem Version" height="18"></a>
<a href="https://app.fossa.com/projects/git%2Bgithub.com%2Fandrewmcodes%2Fbridgetown-inline-svg?ref=badge_shield" alt="FOSSA Status"><img src="https://app.fossa.com/api/projects/git%2Bgithub.com%2Fandrewmcodes%2Fbridgetown-inline-svg.svg?type=shield"/></a>
  <a href="https://depfu.com"><img src="https://badges.depfu.com/badges/54fe87f2b14868b7c6e69aa0322e3764/status.svg" alt="Depfu"></a>
  <a href="https://depfu.com/github/andrewmcodes/bridgetown-inline-svg?project_id=14094"><img src="https://badges.depfu.com/badges/54fe87f2b14868b7c6e69aa0322e3764/count.svg" alt="Depfu"></a>
  <a href="https://codeclimate.com/github/andrewmcodes/bridgetown-inline-svg/maintainability"><img src="https://api.codeclimate.com/v1/badges/f9756d6568f43c7a407b/maintainability" /></a>
  <a href="https://www.codacy.com/manual/andrewmcodes/bridgetown-inline-svg?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=andrewmcodes/bridgetown-inline-svg&amp;utm_campaign=Badge_Grade"><img src="https://app.codacy.com/project/badge/Grade/caad1b16367242ff973fe2e977985364" alt="Codacy Badge"></a>
  <a href='https://coveralls.io/github/andrewmcodes/bridgetown-inline-svg?branch=main'><img src='https://coveralls.io/repos/github/andrewmcodes/bridgetown-inline-svg/badge.svg?branch=main' alt='Coverage Status' /></a>
  <img alt="Tests" src="https://github.com/andrewmcodes/bridgetown-inline-svg/workflows/Tests/badge.svg" />
  <img alt="Linters" src="https://github.com/andrewmcodes/bridgetown-inline-svg/workflows/Linters/badge.svg" />
</p>

> SVG optimizer and inliner for Bridgetown

- [Installation](#installation)
  - [Optional configuration options](#optional-configuration-options)
- [Usage](#usage)
  - [Optimizations](#optimizations)
- [Author](#author)
- [Contributing](#contributing)
- [Show your support](#show-your-support)
- [Acknowledgement](#acknowledgement)
- [License](#license)


[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fandrewmcodes%2Fbridgetown-inline-svg.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fandrewmcodes%2Fbridgetown-inline-svg?ref=badge_large)

## Installation

Run this command to add this plugin to your site's Gemfile:

```shell
bundle add bridgetown-inline-svg -g bridgetown_plugins
```

or add the following to your `Gemfile`:

```ruby
group :bridgetown_plugins do
  gem "bridgetown-inline-svg", "~> 0.0.1"
end
```

### Optional configuration options

Optimization is opt-in and can be enabled by adding this to your `bridgetown.config.yml`

```
svg:
  optimize: true
```

## Usage

Use the Liquid tag in your pages :

```liquid
{% svg /path/to/square.svg width=24 foo="bar" %}
```

Bridgetown will include the svg file in your output HTML like this :

```html
<svg width=24 foo="bar" version="1.1" id="square" xmlns="http://www.w3.org/2000/svg" x="0" y="0" viewBox="0 0 24 24" >
  <rect width="20" height="20" x="2" y="2" />
</svg>
```

**Note** : You will generally want to set the width/height of your SVG or a `style` attribute, but anything can be passed through.

Paths with a space should be quoted :

```liquid
{% svg "/path/to/foo bar.svg" %}
# or :
{% svg '/path/to/foo bar.svg' %}
```
Otherwise anything after the first space will be considered an attribute.

Liquid variables will be interpreted if enclosed in double brackets :

```liquid
{% assign size=40 %}
{% svg "/path/to/{{site.foo-name}}.svg" width="{{size}}" %}
```

`height` is automatically set to match `width` if omitted. It can't be left unset because IE11 won't use the viewport attribute to calculate the image's aspect ratio.

Relative paths and absolute paths will both be interpreted from Bridgetown's `src` directory. So both:

```liquid
{% svg "/path/to/foo.svg" %}
{% svg "path/to/foo.svg"  %}
```

Should resolve to `/your/site/src/path/to/foo.svg`.

### Optimizations

Some processing is done to remove useless data when enabled:

- metadata
- comments
- unused groups
- Other filters from [svg_optimizer](https://github.com/fnando/svg_optimizer)
- default size

If any important data gets removed, or the output SVG looks different from input, it's a bug. Please file an issue to this repository describing your problem.

It does not perform any input validation on attributes. They will be appended as-is to the root node.

## Author

👤 **Andrew Mason**

* Website: https://www.andrewm.codes
* Twitter: [@andrewmcodes](https://twitter.com/andrewmcodes)
* Github: [@andrewmason](https://github.com/andrewmason)

## Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues page](https://github.com/andrewmcodes/bridgetown-inline-svg/issues). You can also take a look at the [contributing guide](https://github.com/andrewmcodes/bridgetown-inline-svg/blob/main/CONTRIBUTING.md).

## Show your support

Give a ⭐️ if this project helped you!

## Acknowledgement

This project was initially forked from [jekyll-inline-svg](https://github.com/sdumetz/jekyll-inline-svg).

## License

Copyright © 2020 [Andrew Mason](https://github.com/andrewmason).<br />
This project is [MIT](LICENSE.txt) licensed.