# PyTezos Core

[![Python](https://img.shields.io/badge/made%20with-python-blue.svg?)](https://www.python.org)
[![GitHub stars](https://img.shields.io/github/stars/baking-bad/pytezos-core)](https://github.com/baking-bad/pytezos-core)
[![Latest stable release](https://img.shields.io/github/v/release/baking-bad/pytezos-core?label=stable)](https://github.com/baking-bad/pytezos-core/releases)
[![Latest pre-release)](https://img.shields.io/github/v/release/baking-bad/pytezos-core?include_prereleases&label=latest)](https://github.com/baking-bad/pytezos-core/releases)
[![PyPI monthly downloads](https://img.shields.io/pypi/dm/pytezos-core)](https://pypi.org/project/pytezos-core/)
<br>
[![GitHub tests](https://img.shields.io/github/workflow/status/baking-bad/pytezos-core/Test)](https://github.com/baking-bad/pytezos-core/actions)
[![GitHub issues](https://img.shields.io/github/issues/baking-bad/pytezos-core)](https://github.com/baking-bad/pytezos-core/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/baking-bad/pytezos-core)](https://github.com/baking-bad/pytezos-core/pulls)
[![License: MIT](https://img.shields.io/github/license/baking-bad/pytezos-core)](https://github.com/baking-bad/pytezos-core/blob/master/LICENSE)

This repository contains utilities to work with [Tezos cryptography](https://pytezos.org/crypto.html). It is a part of the [PyTezos](https://github.com/baking-bad/pytezos) framework.

To switch from mothership library replace `pytezos.crypto` imports with `pytezos_core`.

```diff
- from pytezos.crypto.key import Key
+ from pytezos_core.key import Key
```
