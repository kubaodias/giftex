# GiftEx (Gifts in Elixir)

[![Build Status](https://travis-ci.org/kubaodias/giftex.svg?branch=master)](https://travis-ci.org/kubaodias/giftex)

This application can be used to make random assigments between people that want to share gifts with each other.
Plugins can be used to send notifications with drawn assignment.

## Configuration

In your config/dev.exs file you can find reference to gifts.yml configuration file:
```
use Mix.Config

config :giftex,
  config: "config/gifts.yml"
```
Save config/gifts.yml.example as config/gifts.yml and configure to your needs.
YML configuration file contains list of plugins and list of members
with configuration for each of the plugins.
```
---

plugins:
 - type: sms
   module: GiftexJustSendPlugin

members:
 - name: "John Williams"
   plugins:
   - type: sms
     meta:
      number: "+01234567890"
 - name: "Diane Smith"
   plugins:
   - type: sms
     meta:
      number: "+01098765432"
 - name: "Bob McRoe"
   plugins:
   - type: sms
     meta:
      number: "+01873456210"
   exclude:
   - "John Williams"

```
Each member can have an optional list of excluded members e.g. members to whom he or she can't give gifts.

## Usage

After configuring list of members and available plugins in YML file you can run the application with:
```
mix giftex
```
It will assign members randomly to each other and send notifications
 to each of them accordingly to configured plugins. An application will fail if there's no possibility to draw gift assignments based on current YML configuration.
