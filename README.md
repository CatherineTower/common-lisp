# umbra

A library of reusable GPU shader functions.

## Overview

This is a library consisting of a collection of useful GPU shader functions, written with
[Shadow](https://github.com/mfiano/shadow).

## Install

```lisp
(ql:quickload :umbra)
```

## Usage

The functions contained in this library are meant to be compiled by your GPU, using
[Shadow](https://github.com/mfiano/shadow). On their own, they don't do anything, Please consult the
Shadow documentation for usage instructions for inclusion in a shader program.

## License

Copyright © Michael Fiano <mail@michaelfiano.com>.

Licensed under the MIT License.
