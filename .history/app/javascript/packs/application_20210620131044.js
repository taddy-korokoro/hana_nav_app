// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks" //コンソールエラー表示のため、コメントアウト
import * as ActiveStorage from "@rails/activestorage"
import "channels"

require("bootstrap/dist/js/bootstrap")

Rails.start()
// Turbolinks.start() //コンソールエラー表示のため、コメントアウト
ActiveStorage.start()

window.$ = window.jQuery = require('jquery');
// レビュー星の表示設定
require('plugin/raty')
require('shared/image_preview')