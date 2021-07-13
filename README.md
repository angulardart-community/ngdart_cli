# ngdart

[![Pub package](https://img.shields.io/pub/v/ngdart.svg)](https://pub.dev/packages/ngdart)
![GitHub](https://img.shields.io/github/license/gzgavinzhao/ngdart)

A command-line tool for creating and managing AngularDart projects.

## Usage

`ngdart` is not meant to be used as a dependency but a command-line tool. Hence, you have to "activate" it:

```bash
dart pub global activate ngdart
```

Dart will detect automatically if you have added the Pub executables path to your environment variables. Follow its instructions if you haven't.

If you use the Dart SDK provided by the Flutter SDK, it is highly recommended to also add the Dart SDK's bin to your environment variables (otherwise sometimes the program can't find `pub`, which is not directly provided in the Flutter SDK). It is located at `path/to/flutter/sdk/bin/cache/dart-sdk/bin`

To create a new AngularDart project:

```bash
ngdart create <package_name>
```

To remove the `build/` and `.dart_tool/` directory (similar to `flutter clean`), run in your project directory:
```
ngdart clean
```

## Motivation

[Stagehand](https://pub.dev/packages/stagehand), the tool that many AngularDart developers use to generate a starter project, has been discontinued in favor of `dart create`. However, since `dart create` doesn't have an option for AngularDart projects, developers are left with nothing but [quickstart](https://github.com/googlearchive/quickstart/tree/master) and [angular_cli](https://pub.dev/packages/angular_cli), which are both great options but very outdated. Hence, `ngdart` is created to compensate for the lack of tools.

Also, as a Flutter developer myself, I'm often envious of how many useful tools that the Flutter cli tool provides (such as `flutter clean`). Hence, another purpose of `ngdart` is to unify the all the tools developers need to create a brilliant AngularDart project. The first step is `ngdart clean`, and more is coming (see [Future Plans](#future-plans)) below)

## Future Plans

Feel free to create pull requests on any of these goals! :) To prevent doing duplicate work, I marked the ones that I myself is currently working on.

* [x] Add `--verbose` global flag.
* [ ] Prompt user to update (by checking the latest version on Pub and compare to [`packageVersion`](lib/src/version.dart)). [currently working on]
* [x] Run `pub get` (or prompt the user to run) after creating a project.
* [X] Add `ngdart build` and `ngdart serve` command (likely from [webdev](https://pub.dev/packages/webdev), but null safety has been a problem for me).
* [ ] Generate components (a function that [angular_cli](https://pub.dev/packages/angular_cli) provides, though I'm unsure if this is useful for many developers).
