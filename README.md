# dast

CLI tool to display the **da**te li**st**.

[![Build Status](https://travis-ci.org/at-grandpa/dast.cr.svg?branch=master)](https://travis-ci.org/at-grandpa/dast.cr)

## Installation

### homebrew

```console
$ brew update
$ brew install crystal-lang
$ brew tap at-grandpa/homebrew-dast.cr
$ brew install dast.cr
```

### git clone

```console
$ brew update
$ brew install crystal-lang
$ git clone https://github.com/at-grandpa/dast.cr.git
$ cd dast.cr
$ make install
```

## Usage

If no arguments, display last 1 week.

```console
$ dast
'2018-03-15','2018-03-16', ... (last 1 week)
```

If one date, display from specified date to now.

```console
$ dast 2018-03-10
'2018-03-10','2018-03-11', ... '2018-03-21' (today)
```

* date format: `%Y-%m-%d` or `%Y/%m/%d` or `%Y-%m-%d %H:%M:%S`

If one diff format, display from applied diff date to now.

```console
$ dast ~3day
'2018-03-18','2018-03-19','2018-03-20','2018-03-21' (today)
```

* The minus sign is specified with `~`.
* diff format: `/(|+|~)\d+(year|y|month|mon|day|d||hour|h|minute|min|m|second|sec|s)?/`

If two date, display from date1 to date2.

```console
$ dast 2018-03-25 2018-03-27
'2018-03-25','2018-03-26','2018-03-27'
```

If date and diff format, display from applied diff date to the date.

```console
$ dast 2018-03-27 ~3day
'2018-03-24','2018-03-25','2018-03-26','2018-03-27'
```

Interval, Format, Delimiter, Quote.

```console
$ dast '2018-03-21 12:00:00' 1h --interval=20min --format='%Y-%m-%d %H:%M:%S' --delimiter=' | ' --quote='"'
"2018-03-21 12:00:00" | "2018-03-21 12:20:00" | "2018-03-21 12:40:00" | "2018-03-21 13:00:00"
```

## Development

```console
crystal spec
```

## Contributing

1. Fork it ( https://github.com/at-grandpa/dast.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [at-grandpa](https://github.com/at-grandpa) at-grandpa - creator, maintainer
