CrawlerMaster
=============

你的爬蟲大統領（之類der）

-----------------

## Draft

以下列出想實作的功能

* index => 列出所有的 crawlers
  * endpoint: /crawlers
* show => 顯示單一爬蟲的資訊 name / crawling status
  * endpoint: /crawlers/ntust, /crawler/{school name}
* setting => 設定單一爬蟲的 api secrets / retry interval / scheduling
  * endpoint: /crawlers/{school name}/setting

之前 sync 到 Core 的方式是邊爬邊上傳，這次為了資料的完整正確性（不要只給我更新到一半就掛掉需要重來），sync to Colorgy Core 的部分會改在檢查資料完整後才進行
