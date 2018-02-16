# Phoenix And Elm: a real use case

This is a [Phoenix 1.3][] port over of the
[Phoenix 1.2/Elm Address Book application][], created by
[Ricardo García Vega][] over a series of posts over at
[his blog][codeloveandboards] ([original app codebase][]).

See the [`original` branch][] for the as-close-to-the-original-as-I-could-get-it
version of the codebase. The `master` and `websockets` branch will likely have
personal tweaks to the codebase in it.

## Installation

### Repository

```sh
git clone git@github.com:paulfioravanti/phoenix_and_elm.git
cd phoenix_and_elm
mix do deps.get, ecto.create, ecto.migrate, run priv/repo/seeds.exs
```

### Dependencies

### Global

```sh
npm install --global elm
```

### npm

To install npm dependencies in `package.json`:

```sh
cd assets
npm install
```

### Elm

To install Elm dependencies in `elm-package.json`:

```sh
cd elm
elm-package install
```

## Run code

From the project root directory:

```sh
mix phx.server
```

Open <http://localhost:4000> in a browser.

## Changes from the original application

- The introduction of [Contexts][] into Phoenix 1.3 required some re-structuring
  of the application to get it working as expected. I made the decision to put
  `Contact` behind an `AddressBook` context.
- I used [Create Elm App][] to generate the Elm app under the assets directory,
  so its structure is slightly different to what is in the original.

## Notes

### Using Create Elm App

If you want to use [Create Elm App][] to have it generate an Elm app in your
Phoenix 1.3 project's `assets/` directory, you can follow these steps:

```sh
npm install create-elm-app --global
cd assets
create-elm-app elm
```

## HTTP version

The `master` branch of this repository contains code covering the first five
sections of the tutorial. In other words, up to and including
[Implementing Elm routing][].

Code from the `master` branch is deployed at
<https://phoenix-and-elm-http.herokuapp.com/>.

## Websockets version

The `websockets` branch of this repository contains code covering all sections
of the tutorial. In other words, up to and including
[Phoenix and Elm WebSockets support][].

Code from the `websockets` branch is deployed at
<https://phoenix-and-elm-websockets.herokuapp.com/>.

## Social

[![Contact][twitter-badge]][twitter-url]

[![Stack Overflow][stackoverflow-badge]][stackoverflow-url]

[codeloveandboards]: http://codeloveandboards.com/
[Contexts]: https://hexdocs.pm/phoenix/contexts.html
[Create Elm App]: https://github.com/halfzebra/create-elm-app
[Implementing Elm routing]: http://codeloveandboards.com/blog/2017/03/07/phoenix-and-elm-a-real-use-case-pt-5/
[`original` branch]: https://github.com/paulfioravanti/phoenix-and-elm/tree/original
[original app codebase]: https://github.com/bigardone/phoenix-and-elm
[Phoenix 1.2/Elm Address Book application]: http://codeloveandboards.com/blog/2017/02/02/phoenix-and-elm-a-real-use-case-pt-1/
[Phoenix 1.3]: http://phoenixframework.org/blog/phoenix-1-3-0-released
[Phoenix and Elm WebSockets support]: http://codeloveandboards.com/blog/2017/03/19/phoenix-and-elm-a-real-use-case-pt-6/
[Ricardo García Vega]: https://twitter.com/bigardone
[stackoverflow-badge]: http://stackoverflow.com/users/flair/567863.png
[stackoverflow-url]: http://stackoverflow.com/users/567863/paul-fioravanti
[twitter-badge]: https://img.shields.io/badge/contact-%40paulfioravanti-blue.svg
[twitter-url]: https://twitter.com/paulfioravanti
